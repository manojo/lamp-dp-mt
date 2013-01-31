%{
typedef struct file_rec_
{ YY_BUFFER_STATE b;
  int		  lineNb;
  struct file_rec_ *next;
} file_rec;

file_rec *fr_stack=(file_rec *)0;

%}
%S sentences comment filename
%%
<filename>[ \t,]*	;
<filename>[^ \t\n,]*	{   FILE *f;
		            f = fopen(yytext, "r");
		            if (!f)
			    {   char msg[128];
			        sprintf(msg, "? include file '%s' not found", yytext);
		                yyerror(msg);
		            }
		            else  /* save caller -- switch to f */
		            {   file_rec *fr;
				fr = (file_rec *)malloc(sizeof(file_rec));
				fr->lineNb = lineNb;
				fr->b = YY_CURRENT_BUFFER;
				fr->next = fr_stack;
				fr_stack = fr;
				lineNb = 1;
				fprintf(stderr, "\n[include file:%s]", yytext);
				yy_switch_to_buffer(yy_create_buffer(f, YY_BUF_SIZE));
				BEGIN sentences;
		            }
			}
<filename>"\n"		{ lineNb++; BEGIN sentences; }

<comment>.*		;
<comment>"\n"		{ lineNb++; BEGIN sentences; }

<sentences><<EOF>>	{   file_rec *fr;
			    fr = fr_stack;
			    if (fr)	/* switch back to caller */
			    {	fr_stack = fr->next;
				/* close current file */
			        if (YY_CURRENT_BUFFER->yy_is_interactive==0)
				    fclose(YY_CURRENT_BUFFER->yy_input_file);
				yy_delete_buffer(YY_CURRENT_BUFFER);
				/* restart old file */
				yy_switch_to_buffer(fr->b);
				lineNb = fr->lineNb;
				free(fr);
				fprintf(stderr, "\n[return to previous file]");
				BEGIN filename;
			    }
			    else return 0;
			}
<sentences>"\n"		{ lineNb++; }
<sentences>[ \t]	;
<sentences>"--include"	BEGIN filename;
<sentences>"--"		BEGIN comment;
<sentences>"of"		return(KW_of);
<sentences>"integer"	return(KW_integer);
<sentences>"boolean"	return(KW_boolean);
<sentences>"real"	return(KW_real);
<sentences>"invar"	return(KW_invar);
<sentences>"outvar"	return(KW_outvar);
<sentences>"locvar"	return(KW_locvar);
<sentences>"usevar"	return(KW_usevar);
<sentences>"returns"	return(KW_returns);
<sentences>"system"	return(KW_system);
<sentences>"var"	return(KW_var);
<sentences>"let"	return(KW_let);
<sentences>"tel"	return(KW_tel);
<sentences>"case"	return(KW_case);
<sentences>"esac"	return(KW_esac);
<sentences>"if"		return(KW_if);
<sentences>"then"	return(KW_then);
<sentences>"else"	return(KW_else);
<sentences>"or"		return(KW_or);
<sentences>"xor"	return(KW_xor);
<sentences>"and"	return(KW_and);
<sentences>"not"	return(KW_not);
<sentences>"div"	return(KW_div);
<sentences>"mod"	return(KW_mod);
<sentences>"use"	return(KW_use);
<sentences>"m_use"	return(KW_use);  /* temporary */
<sentences>"sqrt"	return(KW_sqrt);
<sentences>"abs"	return(KW_abs);
<sentences>[tT][rR][uU][eE]	{   yylval.n = new_node(bcons);
                            yylval.n->info.icons.value = 1;
                            return(BOOLEAN); }
<sentences>[fF][aA][lL][sS][eE]	{   yylval.n = new_node(bcons);
                            yylval.n->info.icons.value = 0;
                            return(BOOLEAN); }
<sentences>[iI][nN][fF][iI][nN][iI][tT][yY]	{ yylval.n = new_node(icons);
			    if (*yytext=='-') yylval.n->info.icons.value = -1;
			    else              yylval.n->info.icons.value = 1;
			    yylval.n->info.icons.fraction = 0;
			    yylval.n->info.icons.infinity = 1;
                            return(INFINITY); }
<sentences>"convex"	return(KW_convex);
<sentences>"domain"	return(KW_domain);
<sentences>"reduce"	return(KW_reduce);
<sentences>"->"		return(KW_arrow);
<sentences>">="		return(KW_geq);
<sentences>"<="		return(KW_leq);
<sentences>"<>"		return(KW_ne);
<sentences>"?<"		return(KW_min);
<sentences>"min"	return(KW_min);
<sentences>"?>"		return(KW_max);
<sentences>"max"	return(KW_max);
<sentences>"::"		return(KW_loop);
<sentences>[\;\:\,\~\&\{\}\|\(\)\[\]\-\=\<\>\+\/\.\"\*\@]	return(*yytext);
<sentences>"\\\n"	;
<sentences>[0-9][0-9]*	{   yylval.n = new_node(icons);
                            yylval.n->info.icons.value = atoi(yytext);
			    yylval.n->info.icons.fraction = 0;
			    yylval.n->info.icons.infinity = 0;
                            return(NUMBER); }
<sentences>[0-9][0-9]*[\.][0-9][0-9]* {    yylval.n = new_node(rcons);
			    sscanf(yytext, "%d.%d",
				&yylval.n->info.icons.value,
				&yylval.n->info.icons.fraction);
			    yylval.n->info.icons.infinity = 0;
                            return(REAL); }
<sentences>[a-zA-Z_][a-zA-Z0-9_]* {   yylval.n = new_id(yytext);
			    if (search_list(id_context, yytext)) return(XID);
			    else return(ID); }
<sentences>.	{	BEGIN sentences; }
