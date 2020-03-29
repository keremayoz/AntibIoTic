CS315f19_group25: y.tab.c lex.yy.c
	    gcc -o parser y.tab.c
y.tab.c: CS315f19_group25.y lex.yy.c
	 yacc CS315f19_group25.y
lex.yy.c: CS315f19_group25.l
	  lex CS315f19_group25.l
clean:
	rm -f lex.yy.c y.tab.c parser
