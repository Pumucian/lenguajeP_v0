#include "Q.h"

BEGIN
L 0:
STAT(0)
	STR(73724, "\n");
	STR(73720, "%i");
	STR(73716, "%f");
	STR(73712, "");
CODE(0)
	R6=R7;
	GT(2);
L 1:
	RR1=3.200000;
	F(R6-12)=RR1;
/////////////Scope: 0
	R0=2;
	F(R6-16)=R0;
	R0=1;
	F(R6-20)=R0;
	R0=4;
	F(R6-24)=R0;
	RR0=2.500000;
	F(R6-28)=RR0;
/////////////Scope: 0
STAT(1)
	STR(73700, "Hola mundo");
CODE(1)
	R0=73700;
	I(R6-32)=R0;
/////////////Scope: 0
STAT(2)
	STR(73688, "Adios mundo");
CODE(2)
	R0=73688;
	I(R6-36)=R0;
/////////////Scope: 0
	R0=I(R6-32);
	R1=R0;
	R0=3;
	GT(putf_);
L 3:
/////////////Scope: 0
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
	I(R6-12)=R0;
/////////////Scope: 0
	RR0=1.000000;
	RR1=4.000000;
	RR0=RR0+RR1;
	R0=5;
	R1=2;
	RR1=2.000000;
	R2=2;
	R3=0;
	I(R6-40)=R4;
	I(R6-44)=R0;
	R4=4;
	R0=R3;
	IF(R0<0) GT(-2);
	IF(R0>=R4) GT(-2);
	R4=4*R0;
	R4=R4+4;
	R4=12+R4;
	RR2=F(R6-R4);
	R0=I(R6-44);
	R4=I(R6-40);
	R3=2;
	RR3=2.000000;
	R4=I(R6-8);
	F(R6-40)=RR0;
	RR0=2.000000;
	I(R6-44)=R0;
	R0=4;
	F(R6-48)=RR1;
	RR1=3.000000;
	RR1=R0*RR1;
	RR0=RR0+RR1;
	RR0=R4+RR0;
	RR3=RR3+RR0;
	RR3=R3+RR3;
	RR2=RR2+RR3;
	RR2=R2+RR2;
	RR1=F(R6-48);
	RR1=RR1+RR2;
	RR1=R1+RR1;
	R0=I(R6-44);
	RR1=R0+RR1;
	RR2=6.000000;
	RR1=RR1+RR2;
	RR0=F(R6-40);
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
	F(R6-40)=RR0;
/////////////Scope: 0
	R0=I(R6-8);
	R1=3;
	R2=2;
	R3=4;
	R2=R2*R3;
	R1=R1+R2;
	R0=R0==R1;
	IF(!R0) GT(4);
STAT(3)
	STR(73676, "if correcto");
CODE(3)
	R0=73676;
	R1=R0;
	R0=5;
	GT(putf_);
L 5:
/////////////Scope: 0
L 4:
/////////////Scope: 0
	R0=4;
	R1=6;
	I(R6-44)=R0;
	I(R6-48)=R1;
L 6:
	R0=I(R6-44);
	R1=I(R6-48);
	IF(R0>R1) GT(7);
	R2=I(R6-44);
	R1=R2;
	R0=8;
	GT(printint_);
L 8:
/////////////Scope: 0
	R0=I(R6-44);
	R0=R0+1;
	I(R6-44)=R0;
	GT(6);
L 7:
/////////////Scope: 0
	R0=I(R6-12);
	R1=R0;
	R0=9;
	GT(printint_);
L 9:
/////////////Scope: 0
	RR0=F(R6-40);
	RR1=RR0;
	R0=10;
	GT(printfloat_);
L 10:
/////////////Scope: 0
	R0=I(R6-8);
	I(R6-44)=R1;
	I(R6-48)=R2;
	R1=4;
	R2=R0;
	IF(R2<0) GT(-2);
	IF(R2>=R1) GT(-2);
	R1=4*R2;
	R1=R1+4;
	R1=12+R1;
	RR0=F(R6-R1);
	R2=I(R6-48);
	R1=I(R6-44);
	R0=2;
	RR0=RR0+R0;
	RR1=RR0;
	R0=11;
	GT(printfloat_);
L 11:
/////////////Scope: 0
	R0=1;
	R1=4;
	R0=R0+R1;
	R1=5;
	R2=2;
	R3=2;
	R4=2;
	I(R6-44)=R0;
	R0=2;
	I(R6-48)=R1;
	R1=2;
	I(R6-52)=R2;
	R2=2;
	I(R6-56)=R3;
	R3=2;
	I(R6-60)=R4;
	R4=2;
	I(R6-64)=R0;
	R0=4;
	I(R6-68)=R1;
	R1=3;
	R0=R0*R1;
	R4=R4+R0;
	R3=R3+R4;
	R2=R2+R3;
	R1=I(R6-68);
	R1=R1+R2;
	R0=I(R6-64);
	R0=R0+R1;
	R4=I(R6-60);
	R4=R4+R0;
	R3=I(R6-56);
	R3=R3+R4;
	R2=I(R6-52);
	R2=R2+R3;
	R1=I(R6-48);
	R1=R1+R2;
	R2=6;
	R1=R1+R2;
	R0=I(R6-44);
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
	R0=12;
	GT(printint_);
L 12:
/////////////Scope: 0
	R0=12;
	R0=R6-R0;
	I(R6-44)=R0;
	I(R6-48)=0;
L 13:
	R0=I(R6-48);
	R1=4;
	IF(R0>=R1) GT(14);
	R0=I(R6-48);
	R0=R0+1;
	R0=R0*4;
	R1=I(R6-44);
	R0=R1-R0;
	RR0=F(R0);
	F(R6-52)=RR0;
STAT(4)
	STR(73668, "bucle");
CODE(4)
	R0=73668;
	R1=R0;
	R0=15;
	GT(putf_);
L 15:
/////////////Scope: 0
	RR0=F(R6-52);
	RR1=RR0;
	R0=16;
	GT(printfloat_);
L 16:
/////////////Scope: 0
	R0=I(R6-48);
	R0=R0+1;
	I(R6-48)=R0;
	GT(13);
L 14:
/////////////Scope: 0
	R0=I(R6-36);
	I(R6-32)=R0;
/////////////Scope: 0
	R0=I(R6-32);
	R1=R0;
	R0=17;
	GT(putf_);
L 17:
/////////////Scope: 0
	R0=I(R6-4);
	GT(R0);
L 2:
/////////////Scope: 0
	GT(19);
L 18:
	R0=I(R6-8);
	R1=R0;
	R0=20;
	GT(printint_);
L 20:
/////////////Scope: 0
	R0=I(R6-8);
	R1=0;
	R0=R0>R1;
	IF(!R0) GT(21);
	I(R6-16)=R0;
	I(R6-20)=R1;
	I(R6-24)=R2;
	I(R6-28)=R3;
	I(R6-32)=R4;
	F(R6-36)=RR0;
	F(R6-40)=RR1;
	F(R6-44)=RR2;
	F(R6-44)=RR3;
	R6=R6-44;
	I(R6-4)=22;
	R0=I(R6-8);
	R1=1;
	R0=R0-R1;
	I(R6-8)=R0;
	GT(18);
L 22:
	R6=R6+44;
	RR3=F(R6-40);
	RR2=F(R6-36);
	RR1=F(R6-32);
	RR0=F(R6-28);
	R4=I(R6-24);
	R3=I(R6-20);
	R2=I(R6-16);
	R1=I(R6-12);
	R0=I(R6-8);
/////////////Scope: 0
L 21:
/////////////Scope: 0
	R0=I(R6-4);
	GT(R0);
L 19:
/////////////Scope: 0
	I(R6-8)=R0;
	I(R6-12)=R1;
	I(R6-16)=R2;
	I(R6-20)=R3;
	I(R6-24)=R4;
	F(R6-28)=RR0;
	F(R6-32)=RR1;
	F(R6-36)=RR2;
	F(R6-36)=RR3;
	R6=R6-36;
	I(R6-4)=23;
	R0=2;
	I(R6-8)=R0;
	GT(1);
L 23:
	R6=R6+36;
	RR3=F(R6-32);
	RR2=F(R6-28);
	RR1=F(R6-24);
	RR0=F(R6-20);
	R4=I(R6-16);
	R3=I(R6-12);
	R2=I(R6-8);
	R1=I(R6-4);
	R0=I(R6-0);
/////////////Scope: 0
	I(R6-8)=R0;
	I(R6-12)=R1;
	I(R6-16)=R2;
	I(R6-20)=R3;
	I(R6-24)=R4;
	F(R6-28)=RR0;
	F(R6-32)=RR1;
	F(R6-36)=RR2;
	F(R6-36)=RR3;
	R6=R6-36;
	I(R6-4)=24;
	R1=2;
	I(R6-8)=R1;
	GT(1);
L 24:
	R6=R6+36;
	RR3=F(R6-32);
	RR2=F(R6-28);
	RR1=F(R6-24);
	RR0=F(R6-20);
	R4=I(R6-16);
	R3=I(R6-12);
	R2=I(R6-8);
	R1=I(R6-4);
	R0=I(R6-0);
/////////////Scope: 0
	GT(-2);
END