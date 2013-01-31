%{
%}
%%
[ \t]                              ;
"\n"                               ;
"venc"                             return (venc);
"vspa"                             return (vspa);
"vsep"                             return (vsep);
"vlis"                             return (vlis);
"henc"                             return (henc);
"hspa"                             return (hspa);
"hsep"                             return (hsep);
"hlis"                             return (hlis);

-?[0-9]+                        { (token.the.number.value = atoi(yytext));
                                   return(number); }

\"([^"]|\\\")*\"                 { yytext[yyleng - 1] = '\0';
                                   strcpy(token.the.text.string,(yytext+1));
				   return(text); }

","                                return *yytext;
"("                                return *yytext;
")"                                return *yytext;
.                                  {fputs(" Bad char: ", stderr);
				    fputs(yytext, stderr);
				    putc('\n', stderr);
				   }
%%
yywrap(){ return(1);}
