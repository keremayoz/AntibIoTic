/* Antibiotic.y */

%{
	#include <stdio.h>
	#include <stdlib.h>
    void yyerror(char *);
	int yylex(void);
%}

%token 			
	PLUS
	MINUS
	MULTIPLY
	DIVIDE
	MODULUS
	SEMICOLON
	GREATER
	SMALLER
	GREATER_EQUAL
	SMALLER_EQUAL
	COMMA
	AND
	OR
	DOT
	ASSIGN
	NOT_EQUAL
	EQUALITY_CHECK
	LEFT_BRACE 
	RIGHT_BRACE 
	LEFT_PARANT 
	RIGHT_PARANT 
	LEFT_BOX 
	RIGHT_BOX 
	NEW_LINE
	PRINT
	FOR_SEPERATOR
	INCREMENTOR 
	DECREMENTOR
	IF
	ELSEIF
	ELSE
	FOR 
	WHILE
	INT 
	FLT
	STRING
	CHAR 
	BOOL 
	FUNCTION 
	SENSOR
	TIME
	CONNECT
	SEND 
	RECEIVE 
	PORT
	SENSOR_IDENTIFIER 
	IDENTIFIER 
	INTEGER 
	FLOAT
	CHARACTER
	COMMENT 
	TEXT 
	SWITCH
	TRUE
	FALSE
	URL
%%

start: program {
			printf("Input is valid!");
			return 0;
		}

program: statements ; 

statements: statement statements | statement ;

statement:  IF logic_expr LEFT_BOX matched RIGHT_BOX unmatched | non_if_statement ;

matched:  IF logic_expr LEFT_BOX matched RIGHT_BOX ELSE LEFT_BOX matched RIGHT_BOX | non_if_statement ; 

unmatched: ELSE LEFT_BOX single_if RIGHT_BOX | ; 

single_if:  IF logic_expr LEFT_BOX single_if RIGHT_BOX | non_if_statement;

identifier: IDENTIFIER;

logic_expr: logic_value logic_operator logic_expr | logic_value;

logic_value: arithmetic_logic | identifier ; 

logic_operator: AND | OR ;

arithmetic_logic: expression comparator expression ; 

comparator: EQUALITY_CHECK | GREATER | SMALLER | SMALLER_EQUAL | GREATER_EQUAL | NOT_EQUAL ; 

non_if_statement:  assignment | declaration | loop_statement | print_statement 
| sensor_definition | send_function | switch_set | function_declaration
| array_decleration | array_assignment ;

assignment: identifier ASSIGN expression ; 

declaration: primitive_type identifier | primitive_type assignment ;

primitive_type: INT | FLT | BOOL | CHAR | STRING  ; 

for_loop: FOR declaration for_seperator logic_expr for_seperator modifier LEFT_BOX statements RIGHT_BOX ; 

while_loop: WHILE logic_expr LEFT_BOX statements RIGHT_BOX ; 

loop_statement: for_loop | while_loop ; 

modifier: identifier INCREMENTOR | identifier DECREMENTOR ; 

expression: expression low_prec_operator term | term ;

term: term high_prec_operator factor | factor ;

factor: LEFT_PARANT expression RIGHT_PARANT | identifier | number
| function_call | sensor_identifier | SWITCH INTEGER | TEXT ;

low_prec_operator: PLUS | MINUS ;

high_prec_operator: MULTIPLY | DIVIDE ;

number: signed_integer | signed_float ;

signed_float: sign float | float ;

float: FLOAT ;

signed_integer: sign integer | integer ;

integer: INTEGER ;

sign: PLUS | MINUS ;

bool: TRUE | FALSE ;

for_seperator: FOR_SEPERATOR ;

array_decleration: primitive_type identifier SMALLER integer GREATER ;

array_assignment: array_element ASSIGN expression ;

array_element: identifier SMALLER integer GREATER ;
	
function_call: identifier  LEFT_PARANT input_parameter_list RIGHT_PARANT  LEFT_PARANT output_parameter_list RIGHT_PARANT 
| identifier LEFT_PARANT RIGHT_PARANT LEFT_PARANT RIGHT_PARANT 
| identifier LEFT_PARANT input_parameter_list RIGHT_PARANT LEFT_PARANT RIGHT_PARANT
| identifier LEFT_PARANT RIGHT_PARANT LEFT_PARANT output_parameter_list RIGHT_PARANT 
| receive_function | connection | timestamp ;

input_parameter_list: expression COMMA input_parameter_list | expression ;

output_parameter_list: identifier COMMA output_parameter_list | identifier ;

function_declaration: FUNCTION identifier LEFT_PARANT parameter_list RIGHT_PARANT LEFT_PARANT parameter_list RIGHT_PARANT LEFT_BOX statements RIGHT_BOX ;

parameter_list: primitive_type identifier COMMA parameter_list
| primitive_type identifier | ;

print_statement: PRINT expression | PRINT bool | PRINT CHARACTER ;

sensor_identifier: SENSOR_IDENTIFIER ;

switch_set: SWITCH INTEGER ASSIGN bool ;

sensor_definition: SENSOR sensor_identifier PORT INTEGER ;

timestamp: TIME LEFT_PARANT RIGHT_PARANT ; 

connection: CONNECT LEFT_PARANT URL RIGHT_PARANT ;

send_function: SEND LEFT_PARANT identifier COMMA INTEGER RIGHT_PARANT ;

receive_function: RECEIVE LEFT_PARANT URL RIGHT_PARANT ;


%%
#include "lex.yy.c"

int lineNo;
int state = 0;

int main() {
	yyparse();
	if (state == 0) {
		fprintf(stderr, "Parsing is successfully completed.\n");
	}
	return 0;

}

void yyerror( char *s ) { 
	state = -1;
	fprintf(stderr, "%s in line %d\n", s, (lineNo+1));
}


