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
 R0=11;
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
 R0=8;
STAT(1)
 STR(73700, "Hola mundo");
CODE(1)
 R0=73700;
 I(R6-28)=R0;
 R0=1;
 R1=4;

 R0=R0+R1;
 R1=5;
 R2=2;
 R3=2;
 R4=2;
 I(R6-32)=R0;
 R0=2;
 I(R6-36)=R1;
 R1=2;
 I(R6-40)=R2;
 R2=2;
 I(R6-44)=R3;
 R3=4;
 I(R6-48)=R4;
 R4=3;

 R3=R3*R4;

 R2=R2+R3;

 R1=R1+R2;

 R0=R0+R1;

 R4=I(R6-48);
 R4=R4+R0;

 R3=I(R6-44);
 R3=R3+R4;

 R2=I(R6-40);
 R2=R2+R3;

 R1=I(R6-36);
 R1=R1+R2;
 R2=6;

 R1=R1+R2;

 R0=I(R6-32);
 R0=R0*R1;
 R1=7;
 R2=8;

 R1=R1+R2;

 R0=R0*R1;
 R1=9;
 R2=10;

 R1=R1+R2;

 R0=R0*R1;
 R1=11;
 R2=12;

 R1=R1+R2;

 R0=R0*R1;
 R1=13;
 R2=14;

 R1=R1+R2;

 R0=R0*R1;
 R1=15;
 R2=16;

 R1=R1+R2;

 R0=R0*R1;
 R1=R0;
 R0=1;
 GT(-13);
L 1:
 R0=I(R6-4);
 R1=3;
 R2=2;
 R3=4;

 R2=R2*R3;

 R1=R1+R2;
 R0=R0==R1;
 IF(!R0) GT(2);
STAT(2)
 STR(73688, "if correcto");
CODE(2)
 R0=73688;
 R1=R0;
 R0=3;
 GT(-12);
L 3:
L 2:
 R0=4;
 R1=6;
 I(R6-32)=R0;
 I(R6-36)=R1;
L 4:
 R0=I(R6-32);
 R1=I(R6-36);
 IF(R0>R1) GT(5);
 R2=I(R6-32);
 R1=R2;
 R0=6;
 GT(-13);
L 6:
 R0=I(R6-32);
 R0=R0+1;
 I(R6-32)=R0;
 GT(4);
L 5:
 R0=I(R6-4);
 R1=R0;
 R0=7;
 GT(-13);
L 7:
 RR0=F(R6-8);
 RR1=RR0;
 R0=8;
 GT(-14);
L 8:
 R0=8;
 R0=R6-R0;
 I(R6-32)=R0;
 I(R6-36)=0;
L 9:
 R0=I(R6-36);
 R1=4;
 IF(R0>=R1) GT(10);
 R0=I(R6-36);
 R0=R0+1;
 R0=R0*4;
 R1=I(R6-32);
 R0=R1-R0;
 RR0=F(R0);
 F(R6-40)=RR0;
STAT(3)
 STR(73680, "bucle");
CODE(3)
 R0=73680;
 R1=R0;
 R0=11;
 GT(-12);
L 11:
 RR0=F(R6-40);
 RR1=RR0;
 R0=12;
 GT(-14);
L 12:
 R0=I(R6-36);
 R0=R0+1;
 I(R6-36)=R0;
 GT(9);
L 10:
 R0=3;
 I(R6-36)=R0;
 R0=I(R6-36);
 R1=R0;
 R0=13;
 GT(-13);
L 13:
 R0=I(R6-28);
 R1=R0;
 R0=14;
 GT(-12);
L 14:
 GT(-2);
END
