#include "Q.h"
# 1 "<stdin>"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 32 "<command-line>" 2
# 1 "<stdin>"
# 1 "Qlib.h" 1
# 2 "<stdin>" 2

BEGIN
L 0:
STAT(0)
 STR(73724, "\n");
 STR(73720, "%i");
 STR(73716, "%f");
 STR(73712, "");
CODE(0)
 R6=R7;
 R0=3;
 I(R6-4)=R0;
 RR0=3.200000;
 F(R6-8)=RR0;
 R0=2;
 F(R6-12)=R0;
 R0=1;
 F(R6-16)=R0;
 R0=4;
 F(R6-20)=R0;
 RR0=2.500000;
 F(R6-24)=RR0;
STAT(1)
 STR(73700, "Hola mundo");
CODE(1)
 R0=73700;
 I(R6-28)=R0;
 R0=4;
 R1=I(R6-4);
 R0=R0%R1;
 R1=2;
 R2=5;
 R3=I(R6-4);
 R2=R2+R3;
 R1=R1*R2;
 R2=4;
 R1=R1*R2;
 R0=R0+R1;
 R1=R0;
 R0=1;
 GT(-13);
L 1:
 R1=I(R6-4);
 R1=R1;
 R0=2;
 GT(-13);
L 2:
 R2=I(R6-28);
 R1=R2;
 R0=3;
 GT(-12);
L 3:
 GT(-2);
END
