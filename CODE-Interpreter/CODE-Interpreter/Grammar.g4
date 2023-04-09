﻿grammar Grammar;

// MAIN CODE
program: 'BEGIN CODE' (NEWLINE statements+ | NEWLINE)* 'END CODE'; 
//

// one or more statement (stmt | stmt , stmts)
statements: statement+;
//

// Exec (x = 123) , vardec (INT x, y =123)
statement: (assignment | vardec | functionCall) NEWLINE+;
//

// INT x or INT x, y
vardec: DATATYPE declaratorlist;
//

// x = 123 or x = y = 123
assignment: VARIABLENAME '=' (value | assignment);
//

//functionCall: VARIABLENAME ': ' STRINGVAL;

functionCall: VARIABLENAME '(' (value (',' value)*)? ')';

// x or y = 123
declarator: VARIABLENAME | VARIABLENAME '=' value; 
//

// INT x or INT x, y
declaratorlist: declarator | declarator ',' declaratorlist;
//

constant: INTEGERVAL | FLOATVAL | CHARVAL | BOOLVAL;

value:
	constant                    #constantExpression
	| VARIABLENAME              #variablenameExpression
	| value compareOp value     #comparisonExpression
	| value boolOp value        #booleanExpression
	| value multOp value        #multiplicativeExpression
	| value addOp value         #additiveExpression
    ;
multOp: '*' | '/' | '%';
addOp: '+' | '-';
compareOp: '>' | '<' | '>=' | '<=' | '==' | '<>';
boolOp: 'AND' | 'OR' | 'NOT';

DATATYPE: 'BOOL' | 'CHAR' | 'INT' | 'FLOAT';
BOOLVAL: '"TRUE"' | '"FALSE"';
CHARVAL: '\'' [a-zA-Z] '\'';
INTEGERVAL: ('-')? [1-9]+;
FLOATVAL: ('-')? [1-9]+ '.' ('-')? [0-9]+;
STRINGVAL: ('"' ~'"'* '"') | ('\'' ~'\''* '\'');

WS: [ \t\r]+ -> skip; // Skips whitespaces
NEWLINE: [\r\n]+;
VARIABLENAME: [_a-z][a-zA-Z0-9_]* | [a-z][a-zA-Z0-9_]*;
COMMENT: '#' ~[\r\n]* -> skip;