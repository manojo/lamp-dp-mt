/*
* generated by Xtext
*/
grammar InternalMathematica;

options {
	superClass=AbstractInternalAntlrParser;
	
}

@lexer::header {
package fr.irisa.cairn.model.parser.antlr.internal;

// Hack: Use our own Lexer superclass by means of import. 
// Currently there is no other way to specify the superclass for the lexer.
import org.eclipse.xtext.parser.antlr.Lexer;
}

@parser::header {
package fr.irisa.cairn.model.parser.antlr.internal; 

import java.io.InputStream;
import org.eclipse.xtext.*;
import org.eclipse.xtext.parser.*;
import org.eclipse.xtext.parser.impl.*;
import org.eclipse.xtext.parsetree.*;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.parser.antlr.AbstractInternalAntlrParser;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.parser.antlr.AntlrDatatypeRuleToken;
import org.eclipse.xtext.conversion.ValueConverterException;
import fr.irisa.cairn.model.services.MathematicaGrammarAccess;

}

@parser::members {

 	private MathematicaGrammarAccess grammarAccess;
 	
    public InternalMathematicaParser(TokenStream input, IAstFactory factory, MathematicaGrammarAccess grammarAccess) {
        this(input);
        this.factory = factory;
        registerRules(grammarAccess.getGrammar());
        this.grammarAccess = grammarAccess;
    }
    
    @Override
    protected InputStream getTokenFile() {
    	ClassLoader classLoader = getClass().getClassLoader();
    	return classLoader.getResourceAsStream("fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.tokens");
    }
    
    @Override
    protected String getFirstRuleName() {
    	return "Node";	
   	}
   	
   	@Override
   	protected MathematicaGrammarAccess getGrammarAccess() {
   		return grammarAccess;
   	}
}

@rulecatch { 
    catch (RecognitionException re) { 
        recover(input,re); 
        appendSkippedTokens();
    } 
}




// Entry rule entryRuleNode
entryRuleNode returns [EObject current=null] 
	:
	{ currentNode = createCompositeNode(grammarAccess.getNodeRule(), currentNode); }
	 iv_ruleNode=ruleNode 
	 { $current=$iv_ruleNode.current; } 
	 EOF 
;

// Rule Node
ruleNode returns [EObject current=null] 
    @init { EObject temp=null; setCurrentLookahead(); resetLookahead(); 
    }
    @after { resetLookahead(); 
    	lastConsumedNode = currentNode;
    }:
(
    { 
        currentNode=createCompositeNode(grammarAccess.getNodeAccess().getASTNodeParserRuleCall_0(), currentNode); 
    }
    this_ASTNode_0=ruleASTNode
    { 
        $current = $this_ASTNode_0.current; 
        currentNode = currentNode.getParent();
    }

    |
    { 
        currentNode=createCompositeNode(grammarAccess.getNodeAccess().getASTLeafParserRuleCall_1(), currentNode); 
    }
    this_ASTLeaf_1=ruleASTLeaf
    { 
        $current = $this_ASTLeaf_1.current; 
        currentNode = currentNode.getParent();
    }

    |
    { 
        currentNode=createCompositeNode(grammarAccess.getNodeAccess().getBuiltInNodeParserRuleCall_2(), currentNode); 
    }
    this_BuiltInNode_2=ruleBuiltInNode
    { 
        $current = $this_BuiltInNode_2.current; 
        currentNode = currentNode.getParent();
    }
)
;





// Entry rule entryRuleASTNode
entryRuleASTNode returns [EObject current=null] 
	:
	{ currentNode = createCompositeNode(grammarAccess.getASTNodeRule(), currentNode); }
	 iv_ruleASTNode=ruleASTNode 
	 { $current=$iv_ruleASTNode.current; } 
	 EOF 
;

// Rule ASTNode
ruleASTNode returns [EObject current=null] 
    @init { EObject temp=null; setCurrentLookahead(); resetLookahead(); 
    }
    @after { resetLookahead(); 
    	lastConsumedNode = currentNode;
    }:
((
(
		lv_name_0_0=RULE_ID
		{
			createLeafNode(grammarAccess.getASTNodeAccess().getNameIDTerminalRuleCall_0_0(), "name"); 
		}
		{
	        if ($current==null) {
	            $current = factory.create(grammarAccess.getASTNodeRule().getType().getClassifier());
	            associateNodeWithAstElement(currentNode, $current);
	        }
	        try {
	       		set(
	       			$current, 
	       			"name",
	        		lv_name_0_0, 
	        		"ID", 
	        		lastConsumedNode);
	        } catch (ValueConverterException vce) {
				handleValueConverterException(vce);
	        }
	    }

)
)	'[' 
    {
        createLeafNode(grammarAccess.getASTNodeAccess().getLeftSquareBracketKeyword_1(), null); 
    }
((
(
		{ 
	        currentNode=createCompositeNode(grammarAccess.getASTNodeAccess().getChildrenNodeParserRuleCall_2_0_0(), currentNode); 
	    }
		lv_children_2_0=ruleNode		{
	        if ($current==null) {
	            $current = factory.create(grammarAccess.getASTNodeRule().getType().getClassifier());
	            associateNodeWithAstElement(currentNode.getParent(), $current);
	        }
	        try {
	       		add(
	       			$current, 
	       			"children",
	        		lv_children_2_0, 
	        		"Node", 
	        		currentNode);
	        } catch (ValueConverterException vce) {
				handleValueConverterException(vce);
	        }
	        currentNode = currentNode.getParent();
	    }

)
)(	',' 
    {
        createLeafNode(grammarAccess.getASTNodeAccess().getCommaKeyword_2_1_0(), null); 
    }
(
(
		{ 
	        currentNode=createCompositeNode(grammarAccess.getASTNodeAccess().getChildrenNodeParserRuleCall_2_1_1_0(), currentNode); 
	    }
		lv_children_4_0=ruleNode		{
	        if ($current==null) {
	            $current = factory.create(grammarAccess.getASTNodeRule().getType().getClassifier());
	            associateNodeWithAstElement(currentNode.getParent(), $current);
	        }
	        try {
	       		add(
	       			$current, 
	       			"children",
	        		lv_children_4_0, 
	        		"Node", 
	        		currentNode);
	        } catch (ValueConverterException vce) {
				handleValueConverterException(vce);
	        }
	        currentNode = currentNode.getParent();
	    }

)
))*)?	']' 
    {
        createLeafNode(grammarAccess.getASTNodeAccess().getRightSquareBracketKeyword_3(), null); 
    }
)
;





// Entry rule entryRuleBuiltInNode
entryRuleBuiltInNode returns [EObject current=null] 
	:
	{ currentNode = createCompositeNode(grammarAccess.getBuiltInNodeRule(), currentNode); }
	 iv_ruleBuiltInNode=ruleBuiltInNode 
	 { $current=$iv_ruleBuiltInNode.current; } 
	 EOF 
;

// Rule BuiltInNode
ruleBuiltInNode returns [EObject current=null] 
    @init { EObject temp=null; setCurrentLookahead(); resetLookahead(); 
    }
    @after { resetLookahead(); 
    	lastConsumedNode = currentNode;
    }:
((
(
		lv_keyword_0_0=RULE_KEYWORD
		{
			createLeafNode(grammarAccess.getBuiltInNodeAccess().getKeywordKeyWordTerminalRuleCall_0_0(), "keyword"); 
		}
		{
	        if ($current==null) {
	            $current = factory.create(grammarAccess.getBuiltInNodeRule().getType().getClassifier());
	            associateNodeWithAstElement(currentNode, $current);
	        }
	        try {
	       		set(
	       			$current, 
	       			"keyword",
	        		lv_keyword_0_0, 
	        		"KeyWord", 
	        		lastConsumedNode);
	        } catch (ValueConverterException vce) {
				handleValueConverterException(vce);
	        }
	    }

)
)	'[' 
    {
        createLeafNode(grammarAccess.getBuiltInNodeAccess().getLeftSquareBracketKeyword_1(), null); 
    }
((
(
		{ 
	        currentNode=createCompositeNode(grammarAccess.getBuiltInNodeAccess().getChildrenNodeParserRuleCall_2_0_0(), currentNode); 
	    }
		lv_children_2_0=ruleNode		{
	        if ($current==null) {
	            $current = factory.create(grammarAccess.getBuiltInNodeRule().getType().getClassifier());
	            associateNodeWithAstElement(currentNode.getParent(), $current);
	        }
	        try {
	       		add(
	       			$current, 
	       			"children",
	        		lv_children_2_0, 
	        		"Node", 
	        		currentNode);
	        } catch (ValueConverterException vce) {
				handleValueConverterException(vce);
	        }
	        currentNode = currentNode.getParent();
	    }

)
)(	',' 
    {
        createLeafNode(grammarAccess.getBuiltInNodeAccess().getCommaKeyword_2_1_0(), null); 
    }
(
(
		{ 
	        currentNode=createCompositeNode(grammarAccess.getBuiltInNodeAccess().getChildrenNodeParserRuleCall_2_1_1_0(), currentNode); 
	    }
		lv_children_4_0=ruleNode		{
	        if ($current==null) {
	            $current = factory.create(grammarAccess.getBuiltInNodeRule().getType().getClassifier());
	            associateNodeWithAstElement(currentNode.getParent(), $current);
	        }
	        try {
	       		add(
	       			$current, 
	       			"children",
	        		lv_children_4_0, 
	        		"Node", 
	        		currentNode);
	        } catch (ValueConverterException vce) {
				handleValueConverterException(vce);
	        }
	        currentNode = currentNode.getParent();
	    }

)
))*)?	']' 
    {
        createLeafNode(grammarAccess.getBuiltInNodeAccess().getRightSquareBracketKeyword_3(), null); 
    }
)
;





// Entry rule entryRuleASTLeaf
entryRuleASTLeaf returns [EObject current=null] 
	:
	{ currentNode = createCompositeNode(grammarAccess.getASTLeafRule(), currentNode); }
	 iv_ruleASTLeaf=ruleASTLeaf 
	 { $current=$iv_ruleASTLeaf.current; } 
	 EOF 
;

// Rule ASTLeaf
ruleASTLeaf returns [EObject current=null] 
    @init { EObject temp=null; setCurrentLookahead(); resetLookahead(); 
    }
    @after { resetLookahead(); 
    	lastConsumedNode = currentNode;
    }:
(
    { 
        currentNode=createCompositeNode(grammarAccess.getASTLeafAccess().getIntLeafParserRuleCall_0(), currentNode); 
    }
    this_IntLeaf_0=ruleIntLeaf
    { 
        $current = $this_IntLeaf_0.current; 
        currentNode = currentNode.getParent();
    }

    |
    { 
        currentNode=createCompositeNode(grammarAccess.getASTLeafAccess().getStringLeafParserRuleCall_1(), currentNode); 
    }
    this_StringLeaf_1=ruleStringLeaf
    { 
        $current = $this_StringLeaf_1.current; 
        currentNode = currentNode.getParent();
    }

    |
    { 
        currentNode=createCompositeNode(grammarAccess.getASTLeafAccess().getFloatLeafParserRuleCall_2(), currentNode); 
    }
    this_FloatLeaf_2=ruleFloatLeaf
    { 
        $current = $this_FloatLeaf_2.current; 
        currentNode = currentNode.getParent();
    }

    |
    { 
        currentNode=createCompositeNode(grammarAccess.getASTLeafAccess().getSymbolLeafParserRuleCall_3(), currentNode); 
    }
    this_SymbolLeaf_3=ruleSymbolLeaf
    { 
        $current = $this_SymbolLeaf_3.current; 
        currentNode = currentNode.getParent();
    }
)
;





// Entry rule entryRuleIntLeaf
entryRuleIntLeaf returns [EObject current=null] 
	:
	{ currentNode = createCompositeNode(grammarAccess.getIntLeafRule(), currentNode); }
	 iv_ruleIntLeaf=ruleIntLeaf 
	 { $current=$iv_ruleIntLeaf.current; } 
	 EOF 
;

// Rule IntLeaf
ruleIntLeaf returns [EObject current=null] 
    @init { EObject temp=null; setCurrentLookahead(); resetLookahead(); 
    }
    @after { resetLookahead(); 
    	lastConsumedNode = currentNode;
    }:
((
(
		lv_signed_0_0=	'-' 
    {
        createLeafNode(grammarAccess.getIntLeafAccess().getSignedHyphenMinusKeyword_0_0(), "signed"); 
    }
 
	    {
	        if ($current==null) {
	            $current = factory.create(grammarAccess.getIntLeafRule().getType().getClassifier());
	            associateNodeWithAstElement(currentNode, $current);
	        }
	        
	        try {
	       		set($current, "signed", lv_signed_0_0, "-", lastConsumedNode);
	        } catch (ValueConverterException vce) {
				handleValueConverterException(vce);
	        }
	    }

)
)?(
(
		lv_value_1_0=RULE_INT
		{
			createLeafNode(grammarAccess.getIntLeafAccess().getValueINTTerminalRuleCall_1_0(), "value"); 
		}
		{
	        if ($current==null) {
	            $current = factory.create(grammarAccess.getIntLeafRule().getType().getClassifier());
	            associateNodeWithAstElement(currentNode, $current);
	        }
	        try {
	       		set(
	       			$current, 
	       			"value",
	        		lv_value_1_0, 
	        		"INT", 
	        		lastConsumedNode);
	        } catch (ValueConverterException vce) {
				handleValueConverterException(vce);
	        }
	    }

)
))
;





// Entry rule entryRuleStringLeaf
entryRuleStringLeaf returns [EObject current=null] 
	:
	{ currentNode = createCompositeNode(grammarAccess.getStringLeafRule(), currentNode); }
	 iv_ruleStringLeaf=ruleStringLeaf 
	 { $current=$iv_ruleStringLeaf.current; } 
	 EOF 
;

// Rule StringLeaf
ruleStringLeaf returns [EObject current=null] 
    @init { EObject temp=null; setCurrentLookahead(); resetLookahead(); 
    }
    @after { resetLookahead(); 
    	lastConsumedNode = currentNode;
    }:
(
(
		lv_value_0_0=RULE_STRING
		{
			createLeafNode(grammarAccess.getStringLeafAccess().getValueSTRINGTerminalRuleCall_0(), "value"); 
		}
		{
	        if ($current==null) {
	            $current = factory.create(grammarAccess.getStringLeafRule().getType().getClassifier());
	            associateNodeWithAstElement(currentNode, $current);
	        }
	        try {
	       		set(
	       			$current, 
	       			"value",
	        		lv_value_0_0, 
	        		"STRING", 
	        		lastConsumedNode);
	        } catch (ValueConverterException vce) {
				handleValueConverterException(vce);
	        }
	    }

)
)
;





// Entry rule entryRuleSymbolLeaf
entryRuleSymbolLeaf returns [EObject current=null] 
	:
	{ currentNode = createCompositeNode(grammarAccess.getSymbolLeafRule(), currentNode); }
	 iv_ruleSymbolLeaf=ruleSymbolLeaf 
	 { $current=$iv_ruleSymbolLeaf.current; } 
	 EOF 
;

// Rule SymbolLeaf
ruleSymbolLeaf returns [EObject current=null] 
    @init { EObject temp=null; setCurrentLookahead(); resetLookahead(); 
    }
    @after { resetLookahead(); 
    	lastConsumedNode = currentNode;
    }:
(
(
		lv_name_0_0=RULE_ID
		{
			createLeafNode(grammarAccess.getSymbolLeafAccess().getNameIDTerminalRuleCall_0(), "name"); 
		}
		{
	        if ($current==null) {
	            $current = factory.create(grammarAccess.getSymbolLeafRule().getType().getClassifier());
	            associateNodeWithAstElement(currentNode, $current);
	        }
	        try {
	       		set(
	       			$current, 
	       			"name",
	        		lv_name_0_0, 
	        		"ID", 
	        		lastConsumedNode);
	        } catch (ValueConverterException vce) {
				handleValueConverterException(vce);
	        }
	    }

)
)
;





// Entry rule entryRuleFloatLeaf
entryRuleFloatLeaf returns [EObject current=null] 
	:
	{ currentNode = createCompositeNode(grammarAccess.getFloatLeafRule(), currentNode); }
	 iv_ruleFloatLeaf=ruleFloatLeaf 
	 { $current=$iv_ruleFloatLeaf.current; } 
	 EOF 
;

// Rule FloatLeaf
ruleFloatLeaf returns [EObject current=null] 
    @init { EObject temp=null; setCurrentLookahead(); resetLookahead(); 
    }
    @after { resetLookahead(); 
    	lastConsumedNode = currentNode;
    }:
((
(
		lv_signed_0_0=	'-' 
    {
        createLeafNode(grammarAccess.getFloatLeafAccess().getSignedHyphenMinusKeyword_0_0(), "signed"); 
    }
 
	    {
	        if ($current==null) {
	            $current = factory.create(grammarAccess.getFloatLeafRule().getType().getClassifier());
	            associateNodeWithAstElement(currentNode, $current);
	        }
	        
	        try {
	       		set($current, "signed", lv_signed_0_0, "-", lastConsumedNode);
	        } catch (ValueConverterException vce) {
				handleValueConverterException(vce);
	        }
	    }

)
)?(((
(
		lv_a_1_0=RULE_INT
		{
			createLeafNode(grammarAccess.getFloatLeafAccess().getAINTTerminalRuleCall_1_0_0_0(), "a"); 
		}
		{
	        if ($current==null) {
	            $current = factory.create(grammarAccess.getFloatLeafRule().getType().getClassifier());
	            associateNodeWithAstElement(currentNode, $current);
	        }
	        try {
	       		set(
	       			$current, 
	       			"a",
	        		lv_a_1_0, 
	        		"INT", 
	        		lastConsumedNode);
	        } catch (ValueConverterException vce) {
				handleValueConverterException(vce);
	        }
	    }

)
)	'.' 
    {
        createLeafNode(grammarAccess.getFloatLeafAccess().getFullStopKeyword_1_0_1(), null); 
    }
(
(
		lv_b_3_0=RULE_INT
		{
			createLeafNode(grammarAccess.getFloatLeafAccess().getBINTTerminalRuleCall_1_0_2_0(), "b"); 
		}
		{
	        if ($current==null) {
	            $current = factory.create(grammarAccess.getFloatLeafRule().getType().getClassifier());
	            associateNodeWithAstElement(currentNode, $current);
	        }
	        try {
	       		set(
	       			$current, 
	       			"b",
	        		lv_b_3_0, 
	        		"INT", 
	        		lastConsumedNode);
	        } catch (ValueConverterException vce) {
				handleValueConverterException(vce);
	        }
	    }

)
))
    |(	'.' 
    {
        createLeafNode(grammarAccess.getFloatLeafAccess().getFullStopKeyword_1_1_0(), null); 
    }
(
(
		lv_b_5_0=RULE_INT
		{
			createLeafNode(grammarAccess.getFloatLeafAccess().getBINTTerminalRuleCall_1_1_1_0(), "b"); 
		}
		{
	        if ($current==null) {
	            $current = factory.create(grammarAccess.getFloatLeafRule().getType().getClassifier());
	            associateNodeWithAstElement(currentNode, $current);
	        }
	        try {
	       		set(
	       			$current, 
	       			"b",
	        		lv_b_5_0, 
	        		"INT", 
	        		lastConsumedNode);
	        } catch (ValueConverterException vce) {
				handleValueConverterException(vce);
	        }
	    }

)
))))
;





RULE_KEYWORD : ('Module'|'List'|'Clear'|'CompundExpression'|'BeginPackage'|'Set'|'SetDelayed'|'Message'|'MessageName'|'Pattern'|'Rule'|'RuleDelayed'|'With'|'Blank'|'ReplaceAll'|'Map'|'Length'|'Protect'|'Union'|'Plus'|'Catch'|'If'|'Do'|'SameQ'|'UnSameQ'|'Or'|'And'|'Part'|'Print'|'Return'|'Times');

RULE_ID : '^'? ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'0'..'9')*;

RULE_INT : ('0'..'9')+;

RULE_STRING : ('"' ('\\' ('b'|'t'|'n'|'f'|'r'|'"'|'\''|'\\')|~(('\\'|'"')))* '"'|'\'' ('\\' ('b'|'t'|'n'|'f'|'r'|'"'|'\''|'\\')|~(('\\'|'\'')))* '\'');

RULE_ML_COMMENT : '/*' ( options {greedy=false;} : . )*'*/';

RULE_SL_COMMENT : '//' ~(('\n'|'\r'))* ('\r'? '\n')?;

RULE_WS : (' '|'\t'|'\r'|'\n')+;

RULE_ANY_OTHER : .;


