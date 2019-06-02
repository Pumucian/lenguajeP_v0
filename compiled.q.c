#include "Q.h"

BEGIN
L 0:
STAT(0)
	STR(73724, "\n");
	STR(73720, "%i");
	STR(73716, "%f");
	STR(73712, "");
CODE(0)
	R6=R7-4;
///////////////////////Spillmode: 0
	R0=5;
	I(R6-4)=R0;
///////////////////////Spillmode: 0
	R0=3;
	I(R6-8)=R0;
	RR0=-6.400000;
	F(R6-12)=RR0;
///////////////////////Spillmode: 0
	R0=I(R6-4);
	R1=R0;
	R0=1;
	GT(printint_);
L 1:
///////////////////////Spillmode: 0
	R0=I(R6-4);
///////////////////////Spillmode: 0
	R1=I(R6-8);
	R0=R0+R1;
	R1=R0;
	R0=2;
	GT(printint_);
L 2:
///////////////////////Spillmode: 0
	R0=I(R6-4);
///////////////////////Spillmode: 0
	R1=I(R6-8);
	R0=R0-R1;
	R1=R0;
	R0=3;
	GT(printint_);
L 3:
///////////////////////Spillmode: 0
	R0=I(R6-4);
///////////////////////Spillmode: 0
	R1=I(R6-8);
	R0=R0*R1;
	R1=R0;
	R0=4;
	GT(printint_);
L 4:
///////////////////////Spillmode: 0
	R0=I(R6-4);
///////////////////////Spillmode: 0
	R1=I(R6-8);
	R0=R0/R1;
	RR0=F(R6-12);
	RR0=R0+RR0;
	RR1=RR0;
	R0=5;
	GT(printfloat_);
L 5:
///////////////////////Spillmode: 0
	R0=I(R6-4);
///////////////////////Spillmode: 0
	R1=I(R6-8);
	R0=R0>R1;
	IF(!R0) GT(6);
///////////////////////Spillmode: 0
	R0=2;
	R1=R0;
	R0=7;
	GT(printint_);
L 7:
///////////////////////Spillmode: 0
STAT(1)
	STR(73692, "a es mayor que b");
CODE(1)
	R0=73692;
	R1=R0;
	R0=8;
	GT(putf_);
L 8:
///////////////////////Spillmode: 0
STAT(2)
	STR(73684, "Hola");
CODE(2)
	R0=73684;
	R1=R0;
	R0=9;
	GT(putf_);
L 9:
L 6:
///////////////////////Spillmode: 0
	R0=I(R6-4);
///////////////////////Spillmode: 0
	R1=I(R6-8);
	R0=R0<R1;
	IF(!R0) GT(10);
///////////////////////Spillmode: 0
STAT(3)
	STR(73664, "a is lower than b");
CODE(3)
	R0=73664;
	R1=R0;
	R0=11;
	GT(putf_);
L 11:
L 10:
///////////////////////Spillmode: 0
	R0=I(R6-4);
///////////////////////Spillmode: 0
	R1=I(R6-8);
	R0=R0==R1;
	IF(!R0) GT(12);
///////////////////////Spillmode: 0
STAT(4)
	STR(73644, "a is equals to b");
CODE(4)
	R0=73644;
	R1=R0;
	R0=13;
	GT(putf_);
L 13:
L 12:
///////////////////////Spillmode: 0
	R0=I(R6-4);
///////////////////////Spillmode: 0
	R1=I(R6-8);
	R0=R0==R1;
	IF(R0) GT(14);
///////////////////////Spillmode: 0
STAT(5)
	STR(73620, "a is not equals to b");
CODE(5)
	R0=73620;
	R1=R0;
	R0=15;
	GT(putf_);
L 15:
L 14:
///////////////////////Spillmode: 0
	R0=I(R6-4);
	RR0=F(R6-12);
	R0=R0==RR0;
	IF(R0) GT(16);
///////////////////////Spillmode: 0
STAT(6)
	STR(73612, "TEST");
CODE(6)
	R0=73612;
	R1=R0;
	R0=17;
	GT(putf_);
L 17:
L 16:
///////////////////////Spillmode: 0
	R0=I(R6-4);
///////////////////////Spillmode: 0
	R1=I(R6-8);
	R0=R0<=R1;
	IF(R0) GT(18);
///////////////////////Spillmode: 0
STAT(7)
	STR(73580, "a is not lower or equals to b");
CODE(7)
	R0=73580;
	R1=R0;
	R0=19;
	GT(putf_);
L 19:
L 18:
///////////////////////Spillmode: 0
	R0=0;
///////////////////////Spillmode: 0
	R1=4;
	I(R6-16)=R0;
	I(R6-20)=R1;
L 20:
	R0=I(R6-16);
	R1=I(R6-20);
	IF(R0>R1) GT(21);
///////////////////////Spillmode: 0
	R2=4;
	I(R6-24)=R2;
///////////////////////Spillmode: 0
	R0=I(R6-16);
	R1=R0;
	R0=22;
	GT(printint_);
L 22:
	R0=I(R6-16);
	R0=R0+1;
	I(R6-16)=R0;
	GT(20);
L 21:
///////////////////////Spillmode: 0
STAT(8)
	STR(73564, "Hello world.");
CODE(8)
	R0=73564;
	I(R6-16)=R0;
///////////////////////Spillmode: 0
	R0=I(R6-16);
	R1=R0;
	R0=23;
	GT(putf_);
L 23:
///////////////////////Spillmode: 0
	R0=2;
	F(R6-20)=R0;
///////////////////////Spillmode: 0
	R0=3;
	F(R6-24)=R0;
///////////////////////Spillmode: 0
	R0=4;
	F(R6-28)=R0;
///////////////////////Spillmode: 0
	R0=5;
	F(R6-32)=R0;
	R0=16;
	R0=R6-R0;
	I(R6-36)=R0;
	I(R6-40)=0;
L 24:
	R0=I(R6-40);
	R1=4;
	IF(R0>=R1) GT(25);
	R0=I(R6-40);
	R0=R0+1;
	R0=R0*4;
	R1=I(R6-36);
	R0=R1-R0;
	RR0=F(R0);
	F(R6-44)=RR0;
	RR0=F(R6-44);
	RR1=RR0;
	R0=26;
	GT(printfloat_);
L 26:
	R0=I(R6-40);
	R0=R0+1;
	I(R6-40)=R0;
	GT(24);
L 25:
///////////////////////Spillmode: 0
	R0=0;
///////////////////////Spillmode: 0
	R1=3;
	I(R6-40)=R0;
	I(R6-44)=R1;
L 27:
	R0=I(R6-40);
	R1=I(R6-44);
	IF(R0>R1) GT(28);
///////////////////////Spillmode: 0
	R2=I(R6-40);
	I(R6-48)=R3;
	I(R6-52)=R4;
	R3=4;
	R4=R2;
	IF(R4<0) GT(-2);
	IF(R4>=R3) GT(-2);
	R3=4*R4;
	R3=R3+4;
	R3=16+R3;
	RR0=F(R6-R3);
	R4=I(R6-52);
	R3=I(R6-48);
	RR1=RR0;
	R0=29;
	GT(printfloat_);
L 29:
	R0=I(R6-40);
	R0=R0+1;
	I(R6-40)=R0;
	GT(27);
L 28:
	GT(31);
L 30:
	RR0=F(R6-8);
	RR1=F(R6-12);
	RR0=RR0+RR1;
///////////////////////Spillmode: 0
	R0=2;
	RR0=RR0/R0;
	F(R7-4)=RR0;
	R0=I(R6-4);
	GT(R0);
	R0=I(R6-4);
	GT(R0);
L 31:
	I(R6-44)=R0;
	I(R6-48)=R1;
	I(R6-52)=R2;
	I(R6-56)=R3;
	I(R6-60)=R4;
	F(R6-64)=RR0;
	F(R6-68)=RR1;
	F(R6-72)=RR2;
	F(R6-76)=RR3;
///////////////////////Spillmode: 0
	R0=3;
	R6=R6-76;
	F(R6-8)=R0;
	R6=R6+76;
///////////////////////Spillmode: 0
	R1=6;
	R6=R6-76;
	F(R6-12)=R1;
	R6=R6+76;
	R6=R6-76;
	I(R6-4)=32;
	GT(30);
L 32:
	R6=R6+76;
	RR3=F(R6-76);
	RR2=F(R6-72);
	RR1=F(R6-68);
	RR0=F(R6-64);
	R4=I(R6-60);
	R3=I(R6-56);
	R2=I(R6-52);
	R1=I(R6-48);
	R0=I(R6-44);
	RR0=F(R7-4);
	RR1=RR0;
	R0=33;
	GT(printfloat_);
L 33:
	GT(-2);
END