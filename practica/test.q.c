#include "Q.h"

BEGIN
L 0:
STAT(0)
	STR(73724, "\n");	
	STR(0x11ff8, "%i");
	STR(0x11ff4, "%f");
	STR(0x11ee0, "Hola mundo");
CODE(0)
L 1:
	RR0 = 2.4;
	F(0x11fec) = RR0;
	RR1 = F(0x11fec);
	R0 = 2; //etiqueta a la que vuelve del print, hacemos salto de línea
	GT(printfloat_);
L 2:
	R1 = 0x11ee0;
	R0 = 3;
	GT(putf_);
L 3:
	R1 = 4;
	R0 = 4;
	GT(printint_);
L 4:
	GT(-2);
END
