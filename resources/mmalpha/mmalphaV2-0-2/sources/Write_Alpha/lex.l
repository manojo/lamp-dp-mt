%{
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
"invar"		return(KW_invar);
"outvar"	return(KW_outvar);
"locvar"	return(KW_locvar);
"usevar"	return(KW_usevar);
"equation"	return(KW_equation);
"case"		return(KW_case);
"restrict"	return(KW_restrict);
"var"		return(KW_var);
"affine"	return(KW_affine);
"const"		return(KW_const);
"index"		return(KW_index);
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
"zpol"		return(KW_zpol);
"matrix"	return(KW_matrix);
"reduce"        return(KW_reduce);
"depend"        return(KW_depend);
"dependence"    return(KW_dependence);
"dtable"        return(KW_dtable);
"let"		return(KW_let);
"loop"		return(KW_loop);
"use"		return(KW_use);
"call"		return(KW_call);
"sqrt"		return(KW_sqrt);
"abs"		return(KW_abs);
[Tt]"rue"	{   yylval.n = new_node(bconst);
                    yylval.n->the.bconst.value = 1;
                    return(BOOLEAN); }
[Ff]"alse"	{   yylval.n = new_node(bconst);
                    yylval.n->the.bconst.value = 0;
                    return(BOOLEAN); }
-?[Ii]"nfinity"	{   yylval.n = new_node(num);
		    if (*yytext=='-') yylval.n->the.iconst.value = -1;
		    else              yylval.n->the.iconst.value = 1;
		    yylval.n->the.iconst.infinity = 1;
                    return(NUMBER); }
-?[0-9]+\.	{    yylval.n = new_node(rconst);
				sscanf(yytext, "%d.", &yylval.n->the.rconst.value);
				yylval.n->the.rconst.fraction=0;
                                return(REAL); }
-?[0-9]+\.[0-9]+ {    yylval.n = new_node(rconst);
				sscanf(yytext, "%d.%d",
				&yylval.n->the.rconst.value,
				&yylval.n->the.rconst.fraction);
                                return(REAL); }
-?[0-9]+	{   yylval.n = new_node(num);
                    yylval.n->the.iconst.value = atoi(yytext);
		    yylval.n->the.iconst.infinity = 0;
                    return(NUMBER); }
\"(\\\n[ \t]*)?[a-zA-Z_]([a-zA-Z0-9_]|(\\\n[ \t]*))*\" {
		    yylval.n = new_id(yytext);
		    return(ID); }
\"\"		{   yylval.n = new_id("");
		    return(ID); }
","		return *yytext;
"["		return *yytext;
"]"		return *yytext;
"{"		return *yytext;
"}"		return *yytext;
.		{	fputs("? bad char: ",stderr);
			fputs(yytext,stderr);
			putc('\n',stderr); }

