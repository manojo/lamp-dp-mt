lexer grammar InternalMathematica;
@header {
package fr.irisa.cairn.model.ui.contentassist.antlr.internal;

// Hack: Use our own Lexer superclass by means of import. 
// Currently there is no other way to specify the superclass for the lexer.
import org.eclipse.xtext.ui.editor.contentassist.antlr.internal.Lexer;
}

T12 : '[' ;
T13 : ']' ;
T14 : ',' ;
T15 : '.' ;
T16 : '-' ;

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g" 1380
RULE_KEYWORD : ('Module'|'List'|'Clear'|'CompundExpression'|'BeginPackage'|'Set'|'SetDelayed'|'Message'|'MessageName'|'Pattern'|'Rule'|'RuleDelayed'|'With'|'Blank'|'ReplaceAll'|'Map'|'Length'|'Protect'|'Union'|'Plus'|'Catch'|'If'|'Do'|'SameQ'|'UnSameQ'|'Or'|'And'|'Part'|'Print'|'Return'|'Times');

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g" 1382
RULE_ID : '^'? ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'0'..'9')*;

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g" 1384
RULE_INT : ('0'..'9')+;

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g" 1386
RULE_STRING : ('"' ('\\' ('b'|'t'|'n'|'f'|'r'|'"'|'\''|'\\')|~(('\\'|'"')))* '"'|'\'' ('\\' ('b'|'t'|'n'|'f'|'r'|'"'|'\''|'\\')|~(('\\'|'\'')))* '\'');

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g" 1388
RULE_ML_COMMENT : '/*' ( options {greedy=false;} : . )*'*/';

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g" 1390
RULE_SL_COMMENT : '//' ~(('\n'|'\r'))* ('\r'? '\n')?;

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g" 1392
RULE_WS : (' '|'\t'|'\r'|'\n')+;

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g" 1394
RULE_ANY_OTHER : .;


