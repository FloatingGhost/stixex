Definitions.

HEXDIGIT = [0-9a-fA-F]
QUOTE = [\'\"]
BASE64CHAR = [A-Za-z0-9+/]
HYPHEN = -
DOT = \.
EQ = \=|\=\=
NEQ = !=|<>
LT = <
LE = <=
GT = >
GE = >=
COLON = :
COMMA = ,
RPAREN = \)
LPAREN = \(
RBRACK = \]
LBRACK = \[
PLUS = +
MINUS = -
POWER_OP = \^
ASTERISK = \*
WS = [\s\t\r\n]+
COMMENT = /\*.*?\*/
LINECOMMENT = //[^\r\n]*

Rules.

{ASTERISK} : {token, {wildcard, TokenLine}}.
{COMMA} : {token, {comma, TokenLine}}.
{DOT} : {token, {dot, TokenLine}}.
{EQ} : {token, {equal_to, TokenLine}}.
{NEQ} : {token, {not_equal, TokenLine}}.
{LT} : {token, {less_than, TokenLine}}.
{GT} : {token, {greater_than, TokenLine}}.
{LE} : {token, {less_than_or_equal_to, TokenLine}}.
{GE} : {token, {greater_than_or_equal_to, TokenLine}}.
{COLON} : {token, {colon, TokenLine}}.
{LBRACK} : {token, {left_bracket, TokenLine}}.
{RBRACK} : {token, {right_bracket, TokenLine}}.
{LPAREN} : {token, {left_parenthesis, TokenLine}}.
{RPAREN} : {token, {right_parenthesis, TokenLine}}.
AND : {token, {and_cond, TokenLine}}.
OR : {token, {or_cond, TokenLine}}.
NOT : {token, {not_cond, TokenLine}}.
FOLLOWEDBY : {token, {followed_by, TokenLine}}.
LIKE : {token, {like, TokenLine}}.
MATCHES : {token, {matches, TokenLine}}.
ISSUPERSET : {token, {is_superset, TokenLine}}.
ISSUBSET : {token, {is_subset, TokenLine}}.
LAST : {token, {last, TokenLine}}.
IN : {token, {contained_in, TokenLine}}.
START : {token, {start, TokenLine}}.
STOP : {token, {stop, TokenLine}}.
SECONDS : {token, {seconds, TokenLine}}.
TRUE : {token, {true, TokenLine}}.
FALSE : {token, {false, TokenLine}}.
WITHIN : {token, {within, TokenLine}}.
REPEATS : {token, {repeats, TokenLine}}.
TIMES : {token, {times, TokenLine}}.

(-|\+)?[0-9]+ : {token, {integer, TokenLine, list_to_integer(TokenChars)}}.

h{QUOTE}({HEXDIGIT}{HEXDIGIT})*{QUOTE} : S = strip(TokenChars, TokenLen),
                                           {token, {hex, TokenLine, S}}.

b{QUOTE}({BASE64CHAR}{4})*(({BASE64CHAR}{4})|({BASE64CHAR}{3})=|({BASE64CHAR}{2})==){QUOTE} : S = strip (TokenChars, TokenLen), {token, {binary, TokenLine, S}}.

{QUOTE}[^']*{QUOTE} :
    S = strip(TokenChars, TokenLen),
    {token, {string, TokenLine, S}}.

(TRUE|true|FALSE|false) : {token, {boolean, TokenLine, list_to_atom(TokenChars)}} .

t{QUOTE}[0-9]{4}{HYPHEN}((0[1-9])|(1[012])){HYPHEN}((0[1-9])|([12][0-9])|(3[01]))T(([01][0-9])|(2[0-3])){COLON}[0-5][0-9]{COLON}([0-5][0-9]|60)({DOT}[0-9]+)?Z{QUOTE} : 
    S = strip (TokenChars, TokenLen),
    {token, {timestamp, TokenLine, S}}.

[a-zA-Z_][a-zA-Z0-9_]* : {token, {identifier, TokenLine, TokenChars}}.
[a-zA-Z_][a-zA-Z0-9_-]* : {token, {identifier, TokenLine, TokenChars}}.

{WS}+ : skip_token.
{COMMENT} : skip_token.
{LINECOMMENT} : skip_token.
[.]+ : {error, syntax}.

Erlang code.

strip(TokenChars, TokenLen) -> lists:sublist(TokenChars, 2, TokenLen - 2).
