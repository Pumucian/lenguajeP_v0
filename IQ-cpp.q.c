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
 R0=2;
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

STAT(2)
 STR(73688, "Adios mundo");
CODE(2)
 R0=73688;
 I(R6-32)=R0;

 R0=I(R6-28);
 R1=R0;
 R0=1;
 GT(-12);
L 1:

 R0=1;
 R1=4;
 R0=R0+R1;
 R1=5;
 R2=2;
 R3=2;
 R4=2;
 I(R6-36)=R0;
 R0=2;
 I(R6-40)=R1;
 R1=2;
 I(R6-44)=R2;
 R2=2;
 I(R6-48)=R3;
 R3=2;
 I(R6-52)=R4;
 R4=2;
 I(R6-56)=R0;
 R0=4;
 I(R6-60)=R1;
 R1=3;
 R0=R0*R1;
 R4=R4+R0;
 R3=R3+R4;
 R2=R2+R3;
 R1=I(R6-60);
 R1=R1+R2;
 R0=I(R6-56);
 R0=R0+R1;
 R4=I(R6-52);
 R4=R4+R0;
 R3=I(R6-48);
 R3=R3+R4;
 R2=I(R6-44);
 R2=R2+R3;
 R1=I(R6-40);
 R1=R1+R2;
 R2=6;
 R1=R1+R2;
 R0=I(R6-36);
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
 I(R6-8)=R0;

 RR0=1.000000;
 RR1=4.000000;
 RR0=RR0+RR1;
 R0=5;
 R1=2;
 RR1=2.000000;
 R2=2;
 R3=0;

 I(R6-36)=R4;
 I(R6-40)=R0;
 R4=4;
 R0=R3;
 IF(R0<0) GT(-2);
 IF(R0>=R4) GT(-2);
 R4=4*R0;
 R4=R4+4;
 R4=8+R4;
 RR2=F(R6-R4);
 R0=I(R6-40);
 R4=I(R6-36);
 R3=2;
 RR3=2.000000;
 R4=I(R6-4);
 F(R6-36)=RR0;
 RR0=2.000000;
 I(R6-40)=R0;
 R0=4;
 F(R6-44)=RR1;
 RR1=3.000000;
 RR1=R0*RR1;
 RR0=RR0+RR1;
 RR0=R4+RR0;
 RR3=RR3+RR0;
 RR3=R3+RR3;
 RR2=RR2+RR3;
 RR2=R2+RR2;
 RR1=F(R6-44);
 RR1=RR1+RR2;
 RR1=R1+RR1;
 R0=I(R6-40);
 RR1=R0+RR1;
 RR2=6.000000;
 RR1=RR1+RR2;
 RR0=F(R6-36);
 RR0=RR0*RR1;
 R1=7;
 RR1=8.000000;
 RR1=R1+RR1;
 RR0=RR0*RR1;
 R2=9;
 RR1=10.000000;
 RR1=R2+RR1;
 RR0=RR0*RR1;
 RR1=11.000000;
 R3=12;
 RR1=RR1+R3;
 RR0=RR0*RR1;
 F(R6-36)=RR0;

 R0=I(R6-4);
 R1=3;
 R2=2;
 R3=4;
 R2=R2*R3;
 R1=R1+R2;
 R0=R0==R1;
 IF(!R0) GT(2);
STAT(3)
 STR(73676, "if correcto");
CODE(3)
 R0=73676;
 R1=R0;
 R0=3;
 GT(-12);
L 3:

L 2:

 R0=4;
 R1=6;
 I(R6-40)=R0;
 I(R6-44)=R1;
L 4:
 R0=I(R6-40);
 R1=I(R6-44);
 IF(R0>R1) GT(5);
 R2=I(R6-40);
 R1=R2;
 R0=6;
 GT(-13);
L 6:

 R0=I(R6-40);
 R0=R0+1;
 I(R6-40)=R0;
 GT(4);
L 5:

 R0=I(R6-8);
 R1=R0;
 R0=7;
 GT(-13);
L 7:

 RR0=F(R6-36);
 RR1=RR0;
 R0=8;
 GT(-14);
L 8:

 R0=I(R6-4);

 I(R6-40)=R1;
 I(R6-44)=R2;
 R1=4;
 R2=R0;
 IF(R2<0) GT(-2);
 IF(R2>=R1) GT(-2);
 R1=4*R2;
 R1=R1+4;
 R1=8+R1;
 RR0=F(R6-R1);
 R2=I(R6-44);
 R1=I(R6-40);
 R0=2;
 RR0=RR0+R0;
 RR1=RR0;
 R0=9;
 GT(-14);
L 9:

 R0=1;
 R1=4;
 R0=R0+R1;
 R1=5;
 R2=2;
 R3=2;
 R4=2;
 I(R6-40)=R0;
 R0=2;
 I(R6-44)=R1;
 R1=2;
 I(R6-48)=R2;
 R2=2;
 I(R6-52)=R3;
 R3=2;
 I(R6-56)=R4;
 R4=2;
 I(R6-60)=R0;
 R0=4;
 I(R6-64)=R1;
 R1=3;
 R0=R0*R1;
 R4=R4+R0;
 R3=R3+R4;
 R2=R2+R3;
 R1=I(R6-64);
 R1=R1+R2;
 R0=I(R6-60);
 R0=R0+R1;
 R4=I(R6-56);
 R4=R4+R0;
 R3=I(R6-52);
 R3=R3+R4;
 R2=I(R6-48);
 R2=R2+R3;
 R1=I(R6-44);
 R1=R1+R2;
 R2=6;
 R1=R1+R2;
 R0=I(R6-40);
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
 R1=R0;
 R0=10;
 GT(-13);
L 10:

 R0=8;
 R0=R6-R0;
 I(R6-40)=R0;
 I(R6-44)=0;
L 11:
 R0=I(R6-44);
 R1=4;
 IF(R0>=R1) GT(12);
 R0=I(R6-44);
 R0=R0+1;
 R0=R0*4;
 R1=I(R6-40);
 R0=R1-R0;
 RR0=F(R0);
 F(R6-48)=RR0;
STAT(4)
 STR(73668, "bucle");
CODE(4)
 R0=73668;
 R1=R0;
 R0=13;
 GT(-12);
L 13:

 RR0=F(R6-48);
 RR1=RR0;
 R0=14;
 GT(-14);
L 14:

 R0=I(R6-44);
 R0=R0+1;
 I(R6-44)=R0;
 GT(11);
L 12:

 R0=I(R6-32);
 I(R6-28)=R0;

 R0=I(R6-28);
 R1=R0;
 R0=15;
 GT(-12);
L 15:

 GT(-2);
END
