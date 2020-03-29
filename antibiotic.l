digit  [0-9]
integer {digit}+
float {digit}*(\.)?{digit}+
signed_integer ([+-]?{integer})
signed_float ([+-]?{float})
letter [a-z]
capital_letter [A-Z]
letters {letter}+
capital_letters {capital_letter}+
alphabetic ({letter}|{capital_letter}|$|_)
strings \"(\\.|[^"\\])*\"
chr \'{character}\'
character ({digit}|{alphabetic})
identifier {alphabetic}+{character}*
url \'((http)|(ftp))s?:\/\/[a-zA-Z0-9]{2,}(\.[a-z]{2,})+(\/[a-zA-Z0-9+=?]*)*\'
sensor_identifier \_{capital_letters}
comment  \#.*

%%

\+                      return( PLUS );
\-                      return( MINUS );
\*                      return( MULTIPLY );
\/                      return( DIVIDE );
\%                      return( MODULUS );
\;                      return( SEMICOLON );
\&\&                    return( AND );
\|\|                    return( OR );
\>                      return( GREATER );
\<                      return( SMALLER );
\>\=                    return( GREATER_EQUAL );
\<\=                    return( SMALLER_EQUAL );
\,                      return( COMMA );
\.                      return( DOT );
\<\-\-                  return( ASSIGN );
\!\=                    return( NOT_EQUAL );
\=                      return( EQUALITY_CHECK );
\{                      return( LEFT_BRACE );
\}                      return( RIGHT_BRACE );
\(                      return( LEFT_PARANT );
\)                      return( RIGHT_PARANT );
\[						return( LEFT_BOX );
\]						return( RIGHT_BOX );
\>\>					return( PRINT );
\|                      return( FOR_SEPERATOR );
\+\+                    return( INCREMENTOR );
\-\-                    return( DECREMENTOR );
if                      return( IF );
elseif                  return( ELSEIF );
else                    return( ELSE );
for                     return( FOR );
while                   return( WHILE );
int                     return( INT );
float                   return( FLT );
string                  return( STRING );
char                    return( CHAR );
bool                    return( BOOL );
function                return( FUNCTION );
sensor                  return( SENSOR );
time                    return( TIME );
connect                 return( CONNECT );
send                    return( SEND );
receive                 return( RECEIVE );
port                    return( PORT );
true                    return( TRUE );
false                   return( FALSE ); 
switch                  return( SWITCH );

{sensor_identifier}     return( SENSOR_IDENTIFIER );
{identifier}            return( IDENTIFIER );
{integer}               return( INTEGER );
{float}                 return( FLOAT );
{comment}               return( COMMENT );
{strings}               return( TEXT ); 
{url}                   return( URL );
{chr}                   return( CHARACTER );

%%

int yywrap() { return 1; }
