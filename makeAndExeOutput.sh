bison -d -v lenguajeP.y
flex lenguajeP.lex
gcc lenguajeP.tab.c lex.yy.c -o output.out
./output.out q_test.txt
