#include <stdio.h>
#include <stdlib.h>

struct symbol{
	int type;
	char* name;
	char* value;
	int scope;
	int nVariables;
};

struct symbolTable{
	int size;
	struct symbol* symbols;
};

struct symbolTable sT;

void initSymbolTable(){
	sT.size = 0;
	sT.symbols = NULL;
}

int addSymbol(struct symbol s){
	sT.size++;
	struct symbol* newST = malloc(sizeof(struct symbol) * sT.size);
	int i = 0;
	for (i; i < sT.size -1; i++){
		newST[i] = sT.symbols[i];
	}
	newST[sT.size - 1] = s;
	sT.symbols = newST;
	return 0;
}

int main(){
	struct symbol s;
	s.type = 1;
	s.name = "a";
	//printf("%s %i\n", s.name, s.type);
	initSymbolTable();
	addSymbol(s);
	printf("Tamaño de la tabla: %i\nNombre de la variable: %s | Tipo de la variable: %i\n", sT.size, sT.symbols[0].name, sT.symbols[0].type);
	s.type = 2;
	s.name = "x";
	addSymbol(s);
	printf("Tamaño de la tabla: %i\nNombre de la variable: %s | Tipo de la variable: %i\n", sT.size, sT.symbols[0].name, sT.symbols[0].type);
	printf("Tamaño de la tabla: %i\nNombre de la variable: %s | Tipo de la variable: %i\n", sT.size, sT.symbols[1].name, sT.symbols[1].type);
	int a = atoi("4.5");
	printf("")
	return 0;
}
