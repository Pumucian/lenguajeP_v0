#include "Q.h"

BEGIN
L 0:
STAT(0)
	STR(0x11ffc, "\n");	
	STR(0x11ff8, "%i");
	STR(0x11ff4, "%f");
CODE(0)	
	I(0x11ff0) = 4;
	R0 = I(0x11ff0);
	R1 = 2;
	R1 = R0 * R1;
	R0 = 1;
STAT(1)
	STR(0x11fec, R1)
CODE(1)
	T(printint_);
L 1:
	GT(-2);
END
