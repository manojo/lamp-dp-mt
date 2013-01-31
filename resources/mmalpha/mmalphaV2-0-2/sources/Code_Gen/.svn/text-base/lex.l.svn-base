%{
/* lex.l
     COPYRIGHT
          Both this software and its documentation are

              Copyright 1995,1996,1997,1998 by Brigham Young University,
              Provo, Utah; all rights reserved.

          Permission is granted to copy, use, and distribute
          for any commercial or noncommercial purpose under the terms
          of the GNU General Public license, version 2, June 1991
          (see file : LICENSING).
*/
%}
%%
[ \t]		; 		/* white space */
\\?\n		lineNb++;	/* white space */
"Alpha`"	;		/* white space */
"(*"		{ register int c;	/* mange comments */
		    for (;;)
		    {	c=input(); if (c=='\n') lineNb++;
			if (c!='*')  continue;
                        for (;;)
			{   c=input(); if (c=='\n') lineNb++; 
			    if (c!='*')  break;
			}
			if (c==')') break;
		    }
		}
"system"	return(KW_system);
"decl"		return(KW_decl);
"scalar"	return(KW_scalar);
"integer"	return(KW_integer);
"boolean"	return(KW_boolean);
"real"		return(KW_real);
"notype"	return(KW_notype);
"equation"	return(KW_equation);
"case"		return(KW_case);
"restrict"	return(KW_restrict);
"var"		return(KW_var);
"affine"	return(KW_affine);
"const"		return(KW_const);
"binop"		return(KW_binop);
"unop"		return(KW_unop);
"if"		return(KW_if);
"add"		return(KW_add);
"sub"		return(KW_sub);
"mul"		return(KW_mul);
"div"		return(KW_div);
"idiv"		return(KW_idiv);
"mod"		return(KW_mod);
"eq"		return(KW_eq);
"le"		return(KW_le);
"lt"		return(KW_lt);
"gt"		return(KW_gt);
"ge"		return(KW_ge);
"ne"		return(KW_ne);
"or"		return(KW_or);
"and"		return(KW_and);
"neg"		return(KW_neg);
"not"		return(KW_not);
"xor"           return(KW_xor);
"max"           return(KW_max);
"min"           return(KW_min);
"domain"	return(KW_domain);
"pol"		return(KW_pol);
"matrix"	return(KW_matrix);
"reduce"        return(KW_reduce);
"depend"        return(KW_depend);
"dtable"        return(KW_dtable);
"let"		return(KW_let);
"loop"		return(KW_loop);
"use"		return(KW_use);
"call"		return(KW_call);
"sqrt"		return(KW_sqrt);
[Tt]"rue"	return(KW_true);
[Ff]"alse"	return(KW_false);
-?[Ii]"nfinity"	{   if (*yytext=='-') return(KW_neg_infinity);
		    else              return(KW_pos_infinity);; }
-?[0-9]+\.	{    yylval.n = new_node(rconst);
				sscanf(yytext, "%d.", &yylval.n->the.rconst.value);
				yylval.n->the.rconst.fraction=0;
                                return(REAL); }
-?[0-9]+\.[0-9]+ {    yylval.n = new_node(rconst);
				sscanf(yytext, "%d.%d",
				&yylval.n->the.rconst.value,
				&yylval.n->the.rconst.fraction);
                                return(REAL); }
-?[0-9]+	{   yylval.b = atoi(yytext);
                    return(NUMBER); }
\"(\\\n[ \t]*)?[a-zA-Z_]([a-zA-Z0-9_:]|(\\\n[ \t]*))*\" {
		    yylval.n = new_id(yytext);
		    return(ID); }
","		return *yytext;
"["		return *yytext;
"]"		return *yytext;
"{"		return *yytext;
"}"		return *yytext;
.		{	fputs("? bad char: ",stderr);
			fputs(yytext,stderr);
			putc('\n',stderr); }

