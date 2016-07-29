alpha   [a-zA-Z]
digit   [0-9]
white   [\n\t ]
%%
do                          { return DO; }
while                       { return WHILE; }
if                          { return IF; }
read                        { return READ; }
print                       { return PRINT; }
{alpha}({alpha}|{digit})*   { return IDENT; }
{digit}+                    { return NUM; }
[-+()=;{}<>*/%]             { return yytext[0]; }
{white}                     { ; }
