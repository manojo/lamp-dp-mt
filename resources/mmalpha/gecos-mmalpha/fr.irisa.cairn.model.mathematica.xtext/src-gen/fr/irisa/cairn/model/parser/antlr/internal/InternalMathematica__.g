lexer grammar InternalMathematica;
@header {
package fr.irisa.cairn.model.parser.antlr.internal;

// Hack: Use our own Lexer superclass by means of import. 
// Currently there is no other way to specify the superclass for the lexer.
import org.eclipse.xtext.parser.antlr.Lexer;
}

T12 : '[' ;
T13 : ',' ;
T14 : ']' ;
T15 : '-' ;
T16 : '.' ;

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g" 691
RULE_KEYWORD : ('Module'|'List'|'Clear'|'CompundExpression'|'BeginPackage'|'Set'|'SetDelayed'|'Message'|'MessageName'|'Pattern'|'Rule'|'RuleDelayed'|'With'|'Blank'|'ReplaceAll'|'Map'|'Length'|'Protect'|'Union'|'Plus'|'Catch'|'If'|'Do'|'SameQ'|'UnSameQ'|'Or'|'And'|'Part'|'Print'|'Return'|'Times');

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g" 693
RULE_ID : '^'? ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'0'..'9')*;

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g" 695
RULE_INT : ('0'..'9')+;

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g" 697
RULE_STRING : ('"' ('\\' ('b'|'t'|'n'|'f'|'r'|'"'|'\''|'\\')|~(('\\'|'"')))* '"'|'\'' ('\\' ('b'|'t'|'n'|'f'|'r'|'"'|'\''|'\\')|~(('\\'|'\'')))* '\'');

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g" 699
RULE_ML_COMMENT : '/*' ( options {greedy=false;} : . )*'*/';

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g" 701
RULE_SL_COMMENT : '//' ~(('\n'|'\r'))* ('\r'? '\n')?;

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g" 703
RULE_WS : (' '|'\t'|'\r'|'\n')+;

// $ANTLR src "../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g" 705
RULE_ANY_OTHER : .;


