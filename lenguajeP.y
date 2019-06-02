%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h> 
	#include <limits.h> 

	// ASIGNACIONES A POSICIONES DE LISTA
	// !!!!!!!!!!!!!!!!!!!!!!!!RETURNS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

	// stuff from flex that bison needs to know about:
	extern int yylex();
	extern int yyparse();
	extern int numlin;
	extern FILE *yyin;

	void yyerror(const char *s);

	char* removeQuotes(char* s);

	struct symbol{
		int type;
		int memDir;
		int size;
		char* name;
		int* values;
		int scope;
	};

	struct Stack { 
		int top; 
		unsigned capacity; 
		struct symbol* array; 
	};
	
	struct Stack* stack;
	struct Stack* funcStack;

	FILE* fp;
	
	int currentScope = 0;
	int memoryDir = 73728;
	int localOffset = 0;
	int nextLabel = 1;
	int nextStatBlock = 1;
	int emptyStringDir;
	int currentReg = -1;
	int currentFloatReg = 0;
	int inFor = 0;
	int listPosition;
	int spillMode = 0;
	int spillRegs = 0;
	int lastRegSpilled = -1;
	int spilled[5] = {1, 1, 1, 1, 1};	
	int floatSpillMode = 0;
	int floatSpillRegs = 0;
	int lastFloatRegSpilled = -1;
	int floatSpilled[4] = {1, 1, 1, 1};
	int inFunc = 0;
	int funcParams = 0;
	int funcOffset = 0;
	int funcAssignedParams = 0;

	void advanceRegister();
	void reduceRegister();
	void advanceFloatRegister();
	void reduceLastRegSpilled();
	void reduceFloatRegister();
	void reduceLastFloatRegSpilled();
	void intSpill(int r1, int r2);
	void floatSpill(int r1, int r2);

	void initQFile();
	int getStringLength(char* string);
	void printStringQ(int memDir); 
	void loadRegisterOperatorQ(int reg);

	int isNotVar(int type);
	int varIsInt(int type);
	int varIsFloat(int type);
	int varIsString(int type);
	int varIsList(int type);
	int varIsFunc(int type);

	void resetRegs();
	int doExpr(int r1, int r2, char* op);	
	void initNumVarQ(char* varName, int reg);
	void initTextVarQ(char* varName, int reg);
	void initListPositionQ(int reg);
	int getStringRegQ(char* string);
	int getVarnameRegQ(char* varName);
	void printFromReg(int reg);
	void processCondition(int r1, int r2, char* comp);
	void initFromQ(int r1, int r2);
	void endFromQ(int label);
	void initForeachQ(char* varName, int cod);
	void endForeachQ(int label);
	void assignRegToVar(char* varName, int reg);
	int accessListQ(char* varName, int reg);
	int initFunctionQ(char* funcName);
	void initFuncParamQ(char* varName);
	void symbolFunctionQ(char* funcName, int funcLabel);
	void endFunctionQ(int funcLabel);
	int callFunctionQ(char* funcName);	
	void leaveFunctionQ(int label);
	void assignParamQ(int reg);

	void changeSymbolType(char* varName, int type);
	char* intToString(int number);
	char* floatToString(float number);
	struct symbol getSymbol(char* varName);
	struct symbol getFuncSymbol(char* varName);
	struct Stack* createStack(unsigned capacity);
	void push(struct Stack* stack, struct symbol item);
	int isEmpty(struct Stack* stack); 
	void pop(struct Stack* stack); 
	void removeScope(struct Stack* stack);

%}

%union {int entero; float real; char* string;}
%token TEXT NUM LIST
%token PLUS MINUS TIMES DIVIDED_BY MOD
%token <entero> INT
%token <real> FLOAT
%token <string> VARNAME STRING
%token IS IF THEN FROM TO DO DONE ENDFUNC
%token SHOW TAB
%token NOT GREATER LOWER GEQUALS LEQUALS EQUALS NOT_EQUALS
%token AND OR
%token FOREACH IN
%token FUNC RETURN
%token OPEN_BRACKET CLOSE_BRACKET OPEN_PAREN CLOSE_PAREN

%type <entero> expr function listAccess
%type <string> comparator negation

%left SHOW
%left NOT GREATER LOWER OPEN_BRACKET CLOSE_BRACKET GEQUALS LEQUALS EQUALS NOT_EQUALS IS VARNAME INT FLOAT STRING
%left PLUS MINUS
%left TIMES DIVIDED_BY MOD
%left OPEN_PAREN CLOSE_PAREN


%%

lenguajeP:
	lenguajeP line //{fprintf(fp, "/////////////Scope: %i\n", localOffset);}
	|;

line:
	init
	| assign
	| show 
	| ifClause
	| fromClause
	| initFunction
	| foreachClause
	| returnClause
	| function;

init:
	initNum
	| initText
	| initList;

initNum:
	NUM VARNAME asignator expr {initNumVarQ($2, $4);};
initText:
	TEXT VARNAME asignator expr {initTextVarQ($2, $4);};

asignator:
	IS
	| '=';

initList:
	LIST NUM VARNAME {struct symbol s; if (inFunc) s = getFuncSymbol($3); else s = getSymbol($3); if (s.type != -1) yyerror("La variable ya ha sido inicializada"); else {if (inFunc) $<entero>$ = funcOffset; else $<entero>$ = localOffset; listPosition = 0;}} asignator numList {struct symbol s; s.memDir = $<entero>4; s.type = 3; s.name = $3; s.scope = currentScope; s.size = listPosition; if (inFunc) {funcOffset += listPosition * 4; push(funcStack, s);} else {localOffset += listPosition * 4; push(stack, s);} listPosition = 0; resetRegs();};
numList:
	expr {initListPositionQ($1);} ',' numList
	| expr {initListPositionQ($1); $<entero>$ = 100 + listPosition; }; //100 indica que la posición actual es el comienzo de una lista

assign:
	VARNAME asignator expr {assignRegToVar($1, $3); resetRegs();};
	//| listAccess asignator expr;
expr:
	expr PLUS expr {$$ = doExpr($1, $3, "+");}
	| expr MINUS expr {$$ = doExpr($1, $3, "-");}
	| expr TIMES expr {$$ = doExpr($1, $3, "*");}
	| expr DIVIDED_BY expr {$$ = doExpr($1, $3, "/");}
	| expr MOD expr {$$ = doExpr($1, $3, "%");}
	| OPEN_PAREN expr CLOSE_PAREN {$$ = $2;}	
	| listAccess {$$ = $1;}
	| VARNAME {$$ = getVarnameRegQ($1);} 
	| INT {advanceRegister(); fprintf(fp, "\tR%i=%i;\n", currentReg, $1); $$ = currentReg;}
	| FLOAT {advanceFloatRegister(); fprintf(fp, "\tRR%i=%f;\n", currentFloatReg, $1); $$ = currentFloatReg + 10; }
	| STRING {advanceRegister(); $$ = getStringRegQ(removeQuotes($1)); }
	| function {$$ = $1;};

show:
	SHOW expr {printFromReg($2); resetRegs();}
	| SHOW {printStringQ(emptyStringDir);};

ifClause:
	IF expr negation comparator expr THEN {processCondition($2, $5, $4); $<entero>$ = nextLabel++; fprintf(fp, "\n\tIF(%sR0) GT(%i);\n", $3, $<entero>$); resetRegs(); currentScope++;} lenguajeP DONE {fprintf(fp, "L %i:\n", $<entero>7); if (inFunc) removeScope(funcStack); else removeScope(stack); resetRegs();};

negation:
	NOT {$$ = "";}
	|{$$ = "!";};
comparator:
	GREATER {$$ = ">";}
	| LOWER {$$ = "<";}
	| IS {$$ = "==";}
	| GEQUALS {$$ = ">=";}
	| LEQUALS {$$ = "<=";}
	| EQUALS {$$ = "==";}
	| NOT_EQUALS {$$ = "!=";}; 

fromClause:
	FROM expr TO expr {$<entero>$ = nextLabel; initFromQ($2, $4);} DO lenguajeP {endFromQ($<entero>5);} DONE;

foreachClause:
	FOREACH VARNAME IN expr {$<entero>$ = nextLabel; initForeachQ($2, $4);} DO lenguajeP {endForeachQ($<entero>5);} DONE;

listAccess:
	VARNAME OPEN_BRACKET expr CLOSE_BRACKET {$$ = accessListQ($1, $3);};

initFunction:
	FUNC VARNAME {$<entero>$ = initFunctionQ($2);} OPEN_PAREN funcParam CLOSE_PAREN {symbolFunctionQ($2, $<entero>3);} lenguajeP {endFunctionQ($<entero>3);} ENDFUNC;
funcParam:
	VARNAME {initFuncParamQ($1);} ',' funcParam
	| VARNAME {initFuncParamQ($1);};

function:
	VARNAME OPEN_PAREN {$<entero>$ = callFunctionQ($1);} assignParams {leaveFunctionQ($<entero>3);} CLOSE_PAREN {$$ = 0;}; 
assignParams:
	expr {assignParamQ($1);} ","
	| expr {assignParamQ($1);};

returnClause:
	RETURN expr;
	
%%

int main(int argc, char** argv) {
	
	stack = createStack(100);
	fp = fopen("compiled.q.c", "w");
	initQFile();

	if (argc > 1) yyin = fopen(argv[1], "r");
	else yyin = stdin;	
	yyparse();

	fprintf(fp, "\tGT(-2);\nEND"); //Fin del programa, se le añadiría un código de salida a R0
	fclose(fp);

	return 0;
	
}

void advanceRegister(){
	if (currentReg == 4) {
		currentReg = 0;
		if (spillMode) spillRegs++;
		spillMode = 1;
		if (inFunc) {
			funcOffset += 4;
			if (spilled[0] != 0) fprintf(fp, "\tI(R7-%i)=R0;\n", funcOffset);
		} else {			
			localOffset += 4;
			if (spilled[0] != 0) fprintf(fp, "\tI(R7-%i)=R0;\n", localOffset);
		}
	}
	else {
		currentReg++;
		if (spillMode) {
			if (spilled[currentReg] != 0){				
				spillRegs++;
				if (inFunc) {
					funcOffset += 4;
					fprintf(fp, "\tI(R7-%i)=R%i;\n", funcOffset, currentReg);
				} else {					
					localOffset += 4;
					fprintf(fp, "\tI(R7-%i)=R%i;\n", localOffset, currentReg);
				}
			}
			spilled[currentReg] = 1;	
		}
	}
}

void reduceRegister(){
	if (currentReg == 0) currentReg = 4;
	else currentReg--;
}

void reduceLastRegSpilled(){
	if (lastRegSpilled == 0) lastRegSpilled = 4;
	else lastRegSpilled--;
}

void advanceFloatRegister(){
	if (currentFloatReg == 3) {
		currentFloatReg = 0;
		if (floatSpillMode) floatSpillRegs++;
		floatSpillMode = 1;
		if (inFunc){
			funcOffset += 4;
			if (floatSpilled[0] != 0) fprintf(fp, "\tF(R7-%i)=RR0;\n", funcOffset);
		} else {
			localOffset += 4;
			if (floatSpilled[0] != 0) fprintf(fp, "\tF(R7-%i)=RR0;\n", localOffset);
		}
	}
	else {
		currentFloatReg++;
		if (floatSpillMode) {
			if (floatSpilled[currentFloatReg] != 0){				
				floatSpillRegs++;
				if (inFunc) {
					funcOffset += 4;
					fprintf(fp, "\tF(R7-%i)=RR%i;\n", funcOffset, currentFloatReg);
				} else {
					localOffset += 4;
					fprintf(fp, "\tF(R7-%i)=RR%i;\n", localOffset, currentFloatReg);
				}
			}
			floatSpilled[currentFloatReg] = 1;	
		}
	}
}

void reduceFloatRegister(){
	if (currentFloatReg == 0) currentFloatReg = 3;
	else currentFloatReg--;
}

void reduceLastFloatRegSpilled(){
	if (lastFloatRegSpilled == 0) lastFloatRegSpilled = 3;
	else lastFloatRegSpilled--;
}

int isNotVar(int type){
	return (type == -1);
}

int varIsInt(int type){
	return (type == 0);
}

int varIsFloat(int type){
	return (type == 1);
}

int varIsString(int type){
	return (type == 2);
}

int varIsList(int type){
	return (type == 3);
}

int varIsFunc(int type){
	return (type == 4);
}

void floatSpill(int r1, int r2){
	if (floatSpillMode){		
		if (lastFloatRegSpilled == -1) lastFloatRegSpilled = r2;
		else if (r1 == lastFloatRegSpilled){
			if (inFunc){
				fprintf(fp, "\tRR%i=F(R7-%i);\n", r1, funcOffset);
				funcOffset -= 4;
			} else {
				fprintf(fp, "\tRR%i=F(R7-%i);\n", r1, localOffset);
				localOffset -= 4;
			}						
			if (floatSpillRegs > 0) {floatSpillRegs--; reduceLastFloatRegSpilled();}
			else {
				lastFloatRegSpilled = -1;
				floatSpillMode = 0;
			}
		}
		floatSpilled[r2] = 0;
	}
}

void intSpill(int r1, int r2){
	if (spillMode){		
		if (lastRegSpilled == -1) lastRegSpilled = r2;
		else if (r1 == lastRegSpilled){
			if (inFunc){
				fprintf(fp, "\tR%i=I(R7-%i);\n", r1, funcOffset);
				funcOffset -= 4;
			} else {
				fprintf(fp, "\tR%i=I(R7-%i);\n", r1, localOffset);
				localOffset -= 4;
			}						
			if (spillRegs > 0) {spillRegs--; reduceLastRegSpilled();}
			else {
				lastRegSpilled = -1;
				spillMode = 0;
			}
		}
		spilled[r2] = 0;
	}
}

int doExpr(int r1, int r2, char* op){
	if (r1 > 100 || r2 > 100) yyerror("No se puede operar con una lista. Pruebe a operar un elemento."); // 100 indica que hay una posición de lista base en R0 y cada número que sume es el tamaño de dicha lista (p. ej 105 indica una lista tamaño 5)
	else if (r1 < -9 || r2 < -9) yyerror("No se puede operar con una variable texto.");
	else if (r1 > 9 && r2 > 9) {
		floatSpill(r1-10, r2-10);
		fprintf(fp, "\tRR%i=RR%i%sRR%i;\n", r1-10, r1-10, op, r2-10); 
		reduceFloatRegister();
	} else if (r1 > 9) {		
		int r_aux = r2 - 1;
		if (r_aux == -1) r_aux = 4;
		intSpill(r2, r2);
		fprintf(fp, "\tRR%i=RR%i%sR%i;\n", r1-10, r1-10, op, r2);
	} else if (r2 > 9) {		
		int r_aux = r1 - 1;
		if (r_aux == -1) r_aux = 4;
		intSpill(r1, r1);
		fprintf(fp, "\tRR%i=R%i%sRR%i;\n", r2-10, r1, op, r2-10);
		return r2;
	} else {
		intSpill(r1, r2);
		fprintf(fp, "\tR%i=R%i%sR%i;\n", r1, r1, op, r2); 
		reduceRegister();
	}
	return r1;
}	

void initQFile(){	
	fprintf(fp, "#include \"Q.h\"\n\nBEGIN\nL 0:\nSTAT(0)\n");
	fprintf(fp, "\tSTR(%i, \"\\n\");\n", memoryDir -= 4);
	fprintf(fp, "\tSTR(%i, \"%%i\");\n", memoryDir -= 4);
	fprintf(fp, "\tSTR(%i, \"%%f\");\n", memoryDir -= 4);
	fprintf(fp, "\tSTR(%i, \"\");\n", memoryDir -= 4);
	emptyStringDir = memoryDir;
	fprintf(fp, "CODE(0)\n");
}

void resetRegs(){
	currentReg = -1;
	currentFloatReg = -1;
	spillMode = 0;
	floatSpillMode = 0;
	int i = 0;
	for (i; i < 5; i++){
		spilled[i] = 1;
		if (i < 4) floatSpilled[i] = 1;	
	}
}

void initNumVarQ(char* varName, int reg){
	if (inFunc) {
		struct symbol s = getFuncSymbol(varName);
		if (!isNotVar(s.type)) yyerror("La variable ya existe.");
		if (reg < -9) yyerror("Una variable numérica no puede inicializarse con una String");
		if (reg > 9) {
			reg -= 10;
			s.type = 1;
			s.name = varName;
			funcOffset += 4;
			s.memDir = funcOffset;
			s.scope = currentScope;
			fprintf(fp, "\tF(R7-%i)=RR%i;\n", s.memDir, reg);
			push(funcStack, s);
			resetRegs();
		} else {
			s.type = 0;
			s.name = varName;
			funcOffset += 4;
			s.memDir = funcOffset;
			s.scope = currentScope;
			fprintf(fp, "\tI(R7-%i)=R%i;\n", s.memDir, reg);
			push(funcStack, s);
			resetRegs();
		}
	} else {
		struct symbol s = getSymbol(varName);
		if (!isNotVar(s.type)) yyerror("La variable ya existe.");
		if (reg < -9) yyerror("Una variable numérica no puede inicializarse con una String"); // es string
		if (reg > 9) {
			reg -= 10;
			s.type = 1;
			s.name = varName;
			localOffset += 4;
			s.memDir = localOffset;
			s.scope = currentScope;
			fprintf(fp, "\tF(R7-%i)=RR%i;\n", s.memDir, reg);
			push(stack, s);
			resetRegs();
		} else {
			s.type = 0;
			s.name = varName;
			localOffset += 4;
			s.memDir = localOffset;
			s.scope = currentScope;
			fprintf(fp, "\tI(R7-%i)=R%i;\n", s.memDir, reg);
			push(stack, s);
			resetRegs();
		}
	}
}

int getStringLength(char* string){
	int length = strlen(string);
	if (length == 0) return 4;	
	else if (length % 4 != 0){
		return (length / 4 + 1) * 4;
	}
	return length;
}

void initTextVarQ(char* varName, int reg){
	if (inFunc) {
		struct symbol s = getFuncSymbol(varName);
		if (!isNotVar(s.type)) yyerror("La variable ya existe.");
		if (reg >= 0) yyerror("Una variable tipo texto no se puede inicializar con un número.");
		else {
			reg += 10;
			s.type = 2;
			s.name = varName;
			funcOffset += 4;
			s.memDir = funcOffset;
			s.scope = currentScope;
			fprintf(fp, "\tI(R7-%i)=R%i;\n", s.memDir, reg);
			push(funcStack, s);
			resetRegs();
		}
	} else {
		struct symbol s = getSymbol(varName);
		if (!isNotVar(s.type)) yyerror("La variable ya existe.");
		if (reg >= 0) yyerror("Una variable tipo texto no se puede inicializar con un número.");
		else {
			reg += 10;
			s.type = 2;
			s.name = varName;
			localOffset += 4;
			s.memDir = localOffset;
			s.scope = currentScope;
			fprintf(fp, "\tI(R7-%i)=R%i;\n", s.memDir, reg);
			push(stack, s);
			resetRegs();
		}
	}
}

void initListPositionQ(int reg){
	if (reg < 0) yyerror("La lista solo admite valores numéricos.");
	else {
		listPosition += 1;
		if (inFunc) {
			if (reg > 9) fprintf(fp, "\tF(R7-%i)=RR%i;\n", funcOffset + listPosition*4, reg-10);
			else {
				fprintf(fp, "\tF(R7-%i)=R%i;\n", funcOffset + listPosition*4, reg);
			}
		} else {
			if (reg > 9) fprintf(fp, "\tF(R7-%i)=RR%i;\n", localOffset + listPosition*4, reg-10);
			else {
				fprintf(fp, "\tF(R7-%i)=R%i;\n", localOffset + listPosition*4, reg);
			}
		}
		
	}
	resetRegs();
}

int getStringRegQ(char* string){
	int length = getStringLength(string);
	fprintf(fp, "STAT(%i)\n", nextStatBlock);
	fprintf(fp, "\tSTR(%i, \"%s\");\n", memoryDir -= length, string);
	fprintf(fp, "CODE(%i)\n", nextStatBlock++);
	fprintf(fp, "\tR%i=%i;\n", currentReg, memoryDir);
	return currentReg-10;
}

int getVarnameRegQ(char* varName){
	if (inFunc) {
		struct symbol s = getFuncSymbol(varName);
		if (isNotVar(s.type)) yyerror("La variable no existe.");
		else if (varIsInt(s.type)){
			advanceRegister();
			fprintf(fp, "\tR%i=I(R7-%i);\n", currentReg, s.memDir);
			int reg = currentReg;
			return reg;
		} else if (varIsFloat(s.type)){
			advanceFloatRegister();
			fprintf(fp, "\tRR%i=F(R7-%i);\n", currentFloatReg, s.memDir);
			int reg = currentFloatReg + 10;
			return reg;
		} else if (varIsString(s.type)){
			advanceRegister();
			fprintf(fp, "\tR%i=I(R7-%i);\n", currentReg, s.memDir);
			int reg = currentReg - 10;
			return reg;
		} else if (varIsList(s.type)){
			fprintf(fp, "\tR0=%i;\n", s.memDir);
			return 100 + s.size;
		}
	} else {
		struct symbol s = getSymbol(varName);
		if (isNotVar(s.type)) yyerror("La variable no existe.");
		else if (varIsInt(s.type)){
			advanceRegister();
			fprintf(fp, "\tR%i=I(R7-%i);\n", currentReg, s.memDir);
			int reg = currentReg;
			return reg;
		} else if (varIsFloat(s.type)){
			advanceFloatRegister();
			fprintf(fp, "\tRR%i=F(R7-%i);\n", currentFloatReg, s.memDir);
			int reg = currentFloatReg + 10;
			return reg;
		} else if (varIsString(s.type)){
			advanceRegister();
			fprintf(fp, "\tR%i=I(R7-%i);\n", currentReg, s.memDir);
			int reg = currentReg - 10;
			return reg;
		} else if (varIsList(s.type)){
			fprintf(fp, "\tR0=%i;\n", s.memDir);
			return 100 + s.size;
		}
	}
}

void printFromReg(int reg){
	if (reg > 100) yyerror("No se puede mostrar una lista."); //quizás podemos hacer un método para imprimir una lista, no creo que sea muy difícil.
	else if (reg < 0){
		fprintf(fp, "\tR1=R%i;\n", reg+10);
		fprintf(fp, "\tR0=%i;\n", nextLabel);
		fprintf(fp, "\tGT(putf_);\n");
		fprintf(fp, "L %i:\n", nextLabel++);
	} else if (reg > 9){
		fprintf(fp, "\tRR1=RR%i;\n", reg-10);
		fprintf(fp, "\tR0=%i;\n", nextLabel);
		fprintf(fp, "\tGT(printfloat_);\n");
		fprintf(fp, "L %i:\n", nextLabel++);
	} else {
		fprintf(fp, "\tR1=R%i;\n", reg);
		fprintf(fp, "\tR0=%i;\n", nextLabel);
		fprintf(fp, "\tGT(printint_);\n");
		fprintf(fp, "L %i:\n", nextLabel++);
	}
}

void processCondition(int r1, int r2, char* comp){
	fprintf(fp, "\tR0=");
	loadRegisterOperatorQ(r1);
	fprintf(fp, "%s", comp);
	loadRegisterOperatorQ(r2);
	fprintf(fp, ";");
}

void loadRegisterOperatorQ(int reg){
	if (reg < 0) yyerror("No se puede comparar una variable texto.");
	else if (reg > 9) fprintf(fp, "RR%i", reg - 10);
	else fprintf(fp, "R%i", reg);
}

void initFromQ(int r1, int r2){
	if (inFor == 1) yyerror("Ya se encuentra en un bucle FROM. Este lenguaje no permite bucles FROM anidados.");
	else if (r1 < 0 || r1 > 9 || r2 < 0 || r2 > 9) yyerror("Solo se puede iterar entre variables enteras.");
	else {
		inFor = 1; 
		currentScope++;
		struct symbol s, t; 
		s.name = "iter";
		s.type = 0; 
		if (inFunc){
			funcOffset += 4; 
			s.memDir = funcOffset;
			funcOffset += 4;
			t.memDir = funcOffset;		 
			fprintf(fp, "\tI(R7-%i)=R%i;\n\tI(R7-%i)=R%i;\nL %i:\n", s.memDir, r1, t.memDir, r2, nextLabel); //init variables iter y final (limites locales) 
			s.scope = currentScope;
			t.scope = currentScope; 
			push(funcStack, s);
			push(funcStack, t);
		} else {			
			localOffset += 4; 
			s.memDir = localOffset;
			localOffset += 4;
			t.memDir = localOffset;		 
			fprintf(fp, "\tI(R7-%i)=R%i;\n\tI(R7-%i)=R%i;\nL %i:\n", s.memDir, r1, t.memDir, r2, nextLabel); //init variables iter y final (limites locales) 
			s.scope = currentScope;
			t.scope = currentScope; 
			push(stack, s);
			push(stack, t);
		}
		fprintf(fp, "\tR0=I(R7-%i);\n\tR1=I(R7-%i);\n\tIF(R0>R1) GT(%i);\n", s.memDir, t.memDir, nextLabel+1); //cargo y comparo				
		nextLabel += 2;
	}	
}

void endFromQ(int label){
	int memDir;
	if (inFunc) memDir = getFuncSymbol("iter").memDir;
	else memDir = getSymbol("iter").memDir;
	fprintf(fp, "\tR0=I(R7-%i);\n", memDir);
	fprintf(fp, "\tR0=R0+1;\n");
	fprintf(fp, "\tI(R7-%i)=R0;\n", memDir);
	fprintf(fp, "\tGT(%i);\n", label);
	fprintf(fp, "L %i:\n", label+1);
	inFor = 0; 
	if (inFunc) removeScope(funcStack);
	else removeScope(stack);
	resetRegs();
}

void initForeachQ(char* varName, int cod){
	//printf("%i", cod);
	if (cod < 100) yyerror("Solo se puede iterar sobre una variable tipo lista.");
	else {
		currentScope++;
		int size = cod - 100;
		struct symbol l, i, s;

		if (inFunc) {
			funcOffset += 4;
			l.memDir = funcOffset;
			l.scope = currentScope;
			fprintf(fp, "\tR0=R7-R0;\n\tI(R7-%i)=R0;\n", l.memDir); //en R0 está la offset base del array

			funcOffset += 4;
			i.memDir = funcOffset;
			i.name = "foreach";
			fprintf(fp, "\tI(R7-%i)=0;\nL %i:\n", i.memDir, nextLabel);
			i.scope = currentScope;
			push(funcStack, i);

			fprintf(fp, "\tR0=I(R7-%i);\n\tR1=%i;\n\tIF(R0>=R1) GT(%i);\n", i.memDir, size, nextLabel+1);
			s.name = varName;
			s.type = 1;
			s.scope = currentScope;
			funcOffset += 4;
			s.memDir = funcOffset;
			fprintf(fp, "\tR0=I(R7-%i);\n\tR0=R0+1;\n\tR0=R0*4;\n", i.memDir); //cojo el índice + 1 para acceder al array en memoria
			fprintf(fp, "\tR1=I(R7-%i);\n\tR0=R1-R0;\n\tRR0=F(R0);\n\tF(R7-%i)=RR0;\n", l.memDir, s.memDir); //recupero la posición base y le resto el offset del array para recuperar el valor de la posición correspondiente
			push(funcStack, s);
			nextLabel += 2;

		} else {
			localOffset += 4;
			l.memDir = localOffset;
			l.scope = currentScope;
			fprintf(fp, "\tR0=R7-R0;\n\tI(R7-%i)=R0;\n", l.memDir); //en R0 está la offset base del array

			localOffset += 4;
			i.memDir = localOffset;
			i.name = "foreach";
			fprintf(fp, "\tI(R7-%i)=0;\nL %i:\n", i.memDir, nextLabel);
			i.scope = currentScope;
			push(stack, i);

			fprintf(fp, "\tR0=I(R7-%i);\n\tR1=%i;\n\tIF(R0>=R1) GT(%i);\n", i.memDir, size, nextLabel+1);
			s.name = varName;
			s.type = 1;
			s.scope = currentScope;
			localOffset += 4;
			s.memDir = localOffset;
			fprintf(fp, "\tR0=I(R7-%i);\n\tR0=R0+1;\n\tR0=R0*4;\n", i.memDir); //cojo el índice + 1 para acceder al array en memoria
			fprintf(fp, "\tR1=I(R7-%i);\n\tR0=R1-R0;\n\tRR0=F(R0);\n\tF(R7-%i)=RR0;\n", l.memDir, s.memDir); //recupero la posición base y le resto el offset del array para recuperar el valor de la posición correspondiente
			push(stack, s);
			nextLabel += 2;
		}
	}
}

void endForeachQ(int label){
	int memDir; 
	if (inFunc) memDir = getFuncSymbol("foreach").memDir;
	else memDir = getSymbol("foreach").memDir;	
	fprintf(fp, "\tR0=I(R7-%i);\n", memDir);
	fprintf(fp, "\tR0=R0+1;\n");
	fprintf(fp, "\tI(R7-%i)=R0;\n", memDir);
	fprintf(fp, "\tGT(%i);\n", label);
	fprintf(fp, "L %i:\n", label+1);
	//inFor = 0; 
	if (inFunc) removeScope(funcStack);
	else removeScope(stack);
	resetRegs();
}

void changeSymbolType(char* varName, int type){
	int i;
	if (inFunc) {
		for (i = 0; i <= funcStack->top; i++){
			if (strcmp(varName, funcStack->array[i].name) == 0){
				funcStack->array[i].type = type;
			}
		}
	}
	else {		
		for (i = 0; i <= stack->top; i++){
			if (strcmp(varName, stack->array[i].name) == 0){
				stack->array[i].type = type;
			}
		}
	}
}

void assignRegToVar(char* varName, int reg){
	struct symbol s;
	if (inFunc) s = getFuncSymbol(varName);
	else s = getSymbol(varName);
	if (isNotVar(s.type)) yyerror("La variable no existe.");
	else if (varIsInt(s.type)) {
		if (reg > 100 || reg < -9) yyerror("Los tipos son incompatibles.");
		else if (reg > 9) {
			changeSymbolType(varName, 1);
			fprintf(fp, "\tF(R7-%i)=RR%i;\n", s.memDir, reg-10);
		} else fprintf(fp, "\tI(R7-%i)=R%i;\n", s.memDir, reg);
	} else if (varIsFloat(s.type)){
		if (reg > 100 || reg < -9) yyerror("Los tipos son incompatibles.");
		else if (reg < 9) {
			changeSymbolType(varName, 0);
			fprintf(fp, "\tI(R7-%i)=R%i;\n", s.memDir, reg);
		} else fprintf(fp, "\tF(R7-%i)=RR%i;\n", s.memDir, reg-10);
	} else if (varIsString(s.type)){
		if (reg > -1) yyerror("Los tipos son incompatibles.");
		fprintf(fp, "\tI(R7-%i)=R%i;\n", s.memDir, reg+10);
	} else if (varIsList(s.type)) yyerror("No se puede asignar una lista. Pruebe a asignar elementos.");
}

int accessListQ(char* varName, int reg){
	struct symbol l;
	if (inFunc) l = getFuncSymbol(varName);
	else l = getSymbol(varName);
	if (!varIsList(l.type)) yyerror("Solo se puede acceder a posiciones de listas.");	
	else {
		if (reg < 0 || reg > 9) yyerror("Solo se puede acceder a una posición entera de una lista.");
		else {
			advanceFloatRegister();
			int aux1 = reg + 1;
			if (aux1 == 5) aux1 = 0;
			if (inFunc){
				funcOffset += 4;
				fprintf(fp, "\tI(R7-%i)=R%i;\n", funcOffset, aux1);			
				int aux2 = aux1 + 1;
				if (aux2 == 5) aux2 = 0;
				funcOffset += 4;
				fprintf(fp, "\tI(R7-%i)=R%i;\n", funcOffset, aux2);
				fprintf(fp, "\tR%i=%i;\n", aux1, l.size);
				fprintf(fp, "\tR%i=R%i;\n", aux2, reg);
				fprintf(fp, "\tIF(R%i<0) GT(-2);\n", aux2);
				fprintf(fp, "\tIF(R%i>=R%i) GT(-2);\n", aux2, aux1); //Se sale del límite del array
				fprintf(fp, "\tR%i=4*R%i;\n", aux1, aux2);
				fprintf(fp, "\tR%i=R%i+4;\n", aux1, aux1);
				fprintf(fp, "\tR%i=%i+R%i;\n", aux1, l.memDir, aux1);
				fprintf(fp, "\tRR%i=F(R7-R%i);\n", currentFloatReg, aux1);
				fprintf(fp, "\tR%i=I(R7-%i);\n", aux2, funcOffset);
				funcOffset -= 4;
				fprintf(fp, "\tR%i=I(R7-%i);\n", aux1, funcOffset);
				funcOffset -= 4;
			} else {
				localOffset += 4;
				fprintf(fp, "\tI(R7-%i)=R%i;\n", localOffset, aux1);			
				int aux2 = aux1 + 1;
				if (aux2 == 5) aux2 = 0;
				localOffset += 4;
				fprintf(fp, "\tI(R7-%i)=R%i;\n", localOffset, aux2);
				fprintf(fp, "\tR%i=%i;\n", aux1, l.size);
				fprintf(fp, "\tR%i=R%i;\n", aux2, reg);
				fprintf(fp, "\tIF(R%i<0) GT(-2);\n", aux2);
				fprintf(fp, "\tIF(R%i>=R%i) GT(-2);\n", aux2, aux1); //Se sale del límite del array
				fprintf(fp, "\tR%i=4*R%i;\n", aux1, aux2);
				fprintf(fp, "\tR%i=R%i+4;\n", aux1, aux1);
				fprintf(fp, "\tR%i=%i+R%i;\n", aux1, l.memDir, aux1);
				fprintf(fp, "\tRR%i=F(R7-R%i);\n", currentFloatReg, aux1);
				fprintf(fp, "\tR%i=I(R7-%i);\n", aux2, localOffset);
				localOffset -= 4;
				fprintf(fp, "\tR%i=I(R7-%i);\n", aux1, localOffset);
				localOffset -= 4;
			}
			
			
			if (spillMode) reduceRegister();
			else currentReg--;
		}
	}
	return currentFloatReg+10;
}

int initFunctionQ(char* funcName){
	funcStack = createStack(100);
	struct symbol s = getSymbol(funcName);
	if (s.type != -1) yyerror("Ya existe una variable o función con este nombre.");
	else if (currentScope > 0) yyerror("Solo se puede definir una función en el ámbito global.");
	else {
		inFunc = 1;
		int funcLabel = nextLabel;
		nextLabel++;
		fprintf(fp, "\tGT(%i);\n", nextLabel);
		fprintf(fp, "L %i:\n", funcLabel);
		funcOffset += 4;
		nextLabel++;
		return funcLabel;
	}
}

void initFuncParamQ(char* varName){
	struct symbol s = getFuncSymbol(varName);
	if (s.type != -1) yyerror("No se pueden tener dos parámetros con el mismo nombre.");
	else {
		s.name = varName;
		s.type = 0;
		s.scope = currentScope;
		funcOffset += 4;
		s.memDir = funcOffset;
		funcParams++;
		push(funcStack, s);	
	}
}

void symbolFunctionQ(char* funcName, int funcLabel){
	struct symbol s;
	s.name = funcName;
	s.memDir = funcLabel;
	s.size = funcParams;
	s.type = 4;
	push(stack, s);
}

void endFunctionQ(int funcLabel){
	inFunc = 0;
	funcParams = 0;
	funcOffset = 0;
	fprintf(fp, "\tR0=I(R7-4);\n");
	fprintf(fp, "\tGT(R0);\n");
	fprintf(fp, "L %i:\n", funcLabel + 1);
}

void saveRegs(){
	if (inFunc) {
		//funcOffset += 4;
		fprintf(fp, "\tI(R7-%i)=R0;\n", funcOffset += 4);
		fprintf(fp, "\tI(R7-%i)=R1;\n", funcOffset += 4);
		fprintf(fp, "\tI(R7-%i)=R2;\n", funcOffset += 4);
		fprintf(fp, "\tI(R7-%i)=R3;\n", funcOffset += 4);
		fprintf(fp, "\tI(R7-%i)=R4;\n", funcOffset += 4);
		fprintf(fp, "\tF(R7-%i)=RR0;\n", funcOffset += 4);
		fprintf(fp, "\tF(R7-%i)=RR1;\n", funcOffset += 4);
		fprintf(fp, "\tF(R7-%i)=RR2;\n", funcOffset += 4);
		fprintf(fp, "\tF(R7-%i)=RR3;\n", funcOffset += 4);
	} else {
		//localOffset += 4;
		fprintf(fp, "\tI(R7-%i)=R0;\n", localOffset += 4);
		fprintf(fp, "\tI(R7-%i)=R1;\n", localOffset += 4);
		fprintf(fp, "\tI(R7-%i)=R2;\n", localOffset += 4);
		fprintf(fp, "\tI(R7-%i)=R3;\n", localOffset += 4);
		fprintf(fp, "\tI(R7-%i)=R4;\n", localOffset += 4);
		fprintf(fp, "\tF(R7-%i)=RR0;\n", localOffset += 4);
		fprintf(fp, "\tF(R7-%i)=RR1;\n", localOffset += 4);
		fprintf(fp, "\tF(R7-%i)=RR2;\n", localOffset += 4);
		fprintf(fp, "\tF(R7-%i)=RR3;\n", localOffset += 4);
	}
}

void loadRegs(){
	if (inFunc) {
		fprintf(fp, "\tRR3=F(R7-%i);\n", funcOffset);
		fprintf(fp, "\tRR2=F(R7-%i);\n", funcOffset -= 4);
		fprintf(fp, "\tRR1=F(R7-%i);\n", funcOffset -= 4);
		fprintf(fp, "\tRR0=F(R7-%i);\n", funcOffset -= 4);
		fprintf(fp, "\tR4=I(R7-%i);\n", funcOffset -= 4);
		fprintf(fp, "\tR3=I(R7-%i);\n", funcOffset -= 4);
		fprintf(fp, "\tR2=I(R7-%i);\n", funcOffset -= 4);
		fprintf(fp, "\tR1=I(R7-%i);\n", funcOffset -= 4);
		fprintf(fp, "\tR0=I(R7-%i);\n", funcOffset -= 4);
		//funcOffset -= 4;
	} else {
		fprintf(fp, "\tRR3=F(R7-%i);\n", localOffset);
		fprintf(fp, "\tRR2=F(R7-%i);\n", localOffset -= 4);
		fprintf(fp, "\tRR1=F(R7-%i);\n", localOffset -= 4);
		fprintf(fp, "\tRR0=F(R7-%i);\n", localOffset -= 4);
		fprintf(fp, "\tR4=I(R7-%i);\n", localOffset -= 4);
		fprintf(fp, "\tR3=I(R7-%i);\n", localOffset -= 4);
		fprintf(fp, "\tR2=I(R7-%i);\n", localOffset -= 4);
		fprintf(fp, "\tR1=I(R7-%i);\n", localOffset -= 4);
		fprintf(fp, "\tR0=I(R7-%i);\n", localOffset -= 4);
		//funcOffset -= 4;
	}	
}

int callFunctionQ(char* funcName){
	struct symbol f = getSymbol(funcName);
	if (isNotVar(f.type)) yyerror("Esta función no ha sido definida previamente.");
	if (!varIsFunc(f.type)) yyerror("No se puede llamar a una variable que no sea función.");
	else {
		if (1 != f.size) yyerror("El número de parámetros no coincide con el de la función.");
		saveRegs();
		return f.memDir;
	}
}

void leaveFunctionQ(int label){
	fprintf(fp, "\tI(R7-4)=%i;\n", nextLabel);
	fprintf(fp, "\tGT(%i);\n", label);
	fprintf(fp, "L %i:\n", nextLabel++);
	if (inFunc) fprintf(fp, "\tR7=R7+%i;\n", funcOffset);	
	else fprintf(fp, "\tR7=R7+%i;\n", localOffset);
	loadRegs();
	funcAssignedParams = 0;
}

void assignParamQ(int reg){
	if (reg < 0 || reg > 100) yyerror("Solo se puede asignar a funciones valores numéricos.");
	else if (reg > 9){			
		if (inFunc) fprintf(fp, "\tR7=R7-%i;\n", funcOffset);
		else fprintf(fp, "\tR7=R7-%i;\n", localOffset);		
		funcAssignedParams++;
		int mem = 4 + funcAssignedParams*4;
		reg -= 10;
		fprintf(fp, "\tF(R7-%i)=RR%i;\n", mem, reg);
	} else {			
		if (inFunc) fprintf(fp, "\tR7=R7-%i;\n", funcOffset);
		else fprintf(fp, "\tR7=R7-%i;\n", localOffset);		
		funcAssignedParams++;
		int mem = 4 + funcAssignedParams*4;
		fprintf(fp, "\tI(R7-%i)=R%i;\n", mem, reg);
	}
}

void printStringQ(int memDir){
	fprintf(fp, "\tR1=I(R7-%i);\n", memDir);
	fprintf(fp, "\tR0=%i;\n", nextLabel);
	fprintf(fp, "\tGT(putf_);\n");
	fprintf(fp, "L %i:\n", nextLabel++);
} 

//para el return guardar codigo de salida en algun registro y cuando entra a función hay que guardar los registros en memoria por si las moscas.


char* removeQuotes(char* s){
	char* res = s; 	
	res++;
	res[strlen(res)-1] = 0;
	return res;
}

void yyerror(const char* mens){
	printf("Error sintáctico en linea %i: %s\n", numlin, mens); // hay que corregir el número de línea cuando se llame a yyerror desde el final de una sentencia.
	exit(-1);
}

struct symbol getSymbol(char* varName){
	int i;
	for (i = 0; i <= stack->top; i++){
		if (strcmp(varName, stack->array[i].name) == 0){
			return stack->array[i];
		}
	}
	struct symbol a;
	a.type = -1;
	return a;
}

struct symbol getFuncSymbol(char* varName){
	int i;
	for (i = 0; i <= funcStack->top; i++){
		if (strcmp(varName, funcStack->array[i].name) == 0){
			return funcStack->array[i];
		}
	}
	struct symbol a;
	a.type = -1;
	return a;
}
  
// function to create a stack of given capacity. It initializes size of 
// stack as 0 
struct Stack* createStack(unsigned capacity) { 
    struct Stack* stack = (struct Stack*) malloc(sizeof(struct Stack)); 
    stack->capacity = capacity; 
    stack->top = -1; 
    stack->array = (struct symbol*) malloc(stack->capacity * sizeof(struct symbol)); 
    return stack; 
} 
  
// Stack is full when top is equal to the last index 
/*int isFull(struct Stack* stack) 
{   return stack->top == stack->capacity - 1; } 
  */
// Stack is empty when top is equal to -1 
int isEmpty(struct Stack* stack) 
{   return stack->top == -1;  } 

// Function to add an item to stack.  It increases top by 1 
void push(struct Stack* stack, struct symbol item) 
{ 
    /*if (isFull(stack)) 
        return; */
    stack->array[++stack->top] = item; 
    //printf("%s, %i, %s pushed to stack\n", item.name, item.type, item.value); 
} 
  
// Function to remove an item from stack.  It decreases top by 1 
void pop(struct Stack* stack) 
{ 
    if (!isEmpty(stack)){		
    	stack->top--; 
	}
}

void removeScope(struct Stack* stack){
	while(currentScope==stack->array[stack->top].scope){
		stack->top--;
		if (inFunc) funcOffset -= 4;
		else localOffset -= 4;
	}
	currentScope--;
} 

