%token NUM;
%token IDENT;
%token READ;
%token PRINT;
%token WHILE;
%token IF;
%%
prog    : IDENT '{' stlist '}'    { dotree($3); return; }
        ;
stlist  :                         { $$ = 0; }
        | stlist stat             { $$ = node(T_STLIST, $1, $2); }
        ;
stat    : var '=' expr ';'        { $$ = node(T_ASSIGN, $1, $3); }
        | READ var ';'            { $$ = node(T_READ, $2, 0); }
        | PRINT expr ';'          { $$ = node(T_PRINT, $2, 0); }
        | WHILE '(' cond ')' stat { $$ = node(T_WHILE, $3, $5); }
        | IF '(' cond ')' stat    { $$ = node(T_IF, $3, $5); }
        | '{' stlist '}'          { $$ = $2; }
        ;
cond    : expr '<' expr           { $$ = node(T_LT, $1, $3); }
        | expr '>' expr           { $$ = node(T_GT, $1, $3); }
        ;
expr    : term                    { $$ = $1; }
        | expr '+' term           { $$ = node(T_ADD, $1, $3); }
        | expr '-' term           { $$ = node(T_SUB, $1, $3); }
        ;
term    : prim                    { $$ = $1; }
        | term '*' prim           { $$ = node(T_MUL, $1, $3); }
        | term '/' prim           { $$ = node(T_DIV, $1, $3); }
        | term '%' prim           { $$ = node(T_REM, $1, $3); }
        ;
prim    : NUM                     { $$ = node(T_NUM, atoi(yytext), 0); }
        | var                     { $$ = node(T_VAR, $1, 0); }
        | '(' expr ')'            { $$ = $2; }
        ;
var     : IDENT                   { $$ = lookup(yytext); }
        ;
