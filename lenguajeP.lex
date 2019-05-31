%{
	#include "lenguajeP.tab.h"
	int numlin = 1;
	void error(char*);
%}

DIGIT	[0-9]
LETRA	[A-Za-z]
LETDIGIT	[A-Za-z0-9]

%%
("+"|-)?{DIGIT}+	{yylval.entero=atoi(yytext); return INT;}
("+"|-)?{DIGIT}+"."{DIGIT}*	{yylval.real=atof(yytext); return FLOAT;}
"+"|plus	return PLUS;
"-"|minus	return MINUS;
"*"|times	return TIMES;
"/"|"divided by"	return DIVIDED_BY;
"%"|mod	return MOD;
is	return IS;
if	return IF;
and	return AND;
or	return OR;
!=	return NOT_EQUALS;
"!"|not	return NOT;
from	return FROM;
to	return TO;
then	return THEN;
foreach	return FOREACH;
in	return IN;
do	return DO;
done	return DONE;
func	return FUNC;
endfunc	return ENDFUNC;
show	return SHOW;
return	return RETURN;
Num	return NUM;
List	return LIST;
Text	return TEXT;
","	return yytext[0];
"["	return OPEN_BRACKET;
"]"	return CLOSE_BRACKET;
"("	return OPEN_PAREN;
")"	return CLOSE_PAREN;
"<"	return LOWER;
"<="	return LEQUALS;
>=	return GEQUALS;
>	return GREATER;
=	return yytext[0];
==	return EQUALS;
\n	numlin++;
\t	
[ ]+
^#.*	
{LETRA}{LETDIGIT}*	{yylval.string=strdup(yytext);return VARNAME;}
\".*\"	{yylval.string=strdup(yytext); return STRING;}
.	error("caracter raro");
<<EOF>> return 0;
%%

int yywrap(){}
