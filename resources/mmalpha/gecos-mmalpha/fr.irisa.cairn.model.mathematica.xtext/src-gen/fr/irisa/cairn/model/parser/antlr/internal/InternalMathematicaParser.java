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



import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

@SuppressWarnings("all")
public class InternalMathematicaParser extends AbstractInternalAntlrParser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "RULE_ID", "RULE_KEYWORD", "RULE_INT", "RULE_STRING", "RULE_ML_COMMENT", "RULE_SL_COMMENT", "RULE_WS", "RULE_ANY_OTHER", "'['", "','", "']'", "'-'", "'.'"
    };
    public static final int RULE_ID=4;
    public static final int RULE_STRING=7;
    public static final int RULE_KEYWORD=5;
    public static final int RULE_ANY_OTHER=11;
    public static final int RULE_INT=6;
    public static final int RULE_WS=10;
    public static final int RULE_SL_COMMENT=9;
    public static final int EOF=-1;
    public static final int RULE_ML_COMMENT=8;

        public InternalMathematicaParser(TokenStream input) {
            super(input);
        }
        

    public String[] getTokenNames() { return tokenNames; }
    public String getGrammarFileName() { return "../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g"; }



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



    // $ANTLR start entryRuleNode
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:77:1: entryRuleNode returns [EObject current=null] : iv_ruleNode= ruleNode EOF ;
    public final EObject entryRuleNode() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleNode = null;


        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:78:2: (iv_ruleNode= ruleNode EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:79:2: iv_ruleNode= ruleNode EOF
            {
             currentNode = createCompositeNode(grammarAccess.getNodeRule(), currentNode); 
            pushFollow(FOLLOW_ruleNode_in_entryRuleNode75);
            iv_ruleNode=ruleNode();
            _fsp--;

             current =iv_ruleNode; 
            match(input,EOF,FOLLOW_EOF_in_entryRuleNode85); 

            }

        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end entryRuleNode


    // $ANTLR start ruleNode
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:86:1: ruleNode returns [EObject current=null] : (this_ASTNode_0= ruleASTNode | this_ASTLeaf_1= ruleASTLeaf | this_BuiltInNode_2= ruleBuiltInNode ) ;
    public final EObject ruleNode() throws RecognitionException {
        EObject current = null;

        EObject this_ASTNode_0 = null;

        EObject this_ASTLeaf_1 = null;

        EObject this_BuiltInNode_2 = null;


         EObject temp=null; setCurrentLookahead(); resetLookahead(); 
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:91:6: ( (this_ASTNode_0= ruleASTNode | this_ASTLeaf_1= ruleASTLeaf | this_BuiltInNode_2= ruleBuiltInNode ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:92:1: (this_ASTNode_0= ruleASTNode | this_ASTLeaf_1= ruleASTLeaf | this_BuiltInNode_2= ruleBuiltInNode )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:92:1: (this_ASTNode_0= ruleASTNode | this_ASTLeaf_1= ruleASTLeaf | this_BuiltInNode_2= ruleBuiltInNode )
            int alt1=3;
            switch ( input.LA(1) ) {
            case RULE_ID:
                {
                int LA1_1 = input.LA(2);

                if ( (LA1_1==12) ) {
                    alt1=1;
                }
                else if ( (LA1_1==EOF||(LA1_1>=13 && LA1_1<=14)) ) {
                    alt1=2;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("92:1: (this_ASTNode_0= ruleASTNode | this_ASTLeaf_1= ruleASTLeaf | this_BuiltInNode_2= ruleBuiltInNode )", 1, 1, input);

                    throw nvae;
                }
                }
                break;
            case RULE_INT:
            case RULE_STRING:
            case 15:
            case 16:
                {
                alt1=2;
                }
                break;
            case RULE_KEYWORD:
                {
                alt1=3;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("92:1: (this_ASTNode_0= ruleASTNode | this_ASTLeaf_1= ruleASTLeaf | this_BuiltInNode_2= ruleBuiltInNode )", 1, 0, input);

                throw nvae;
            }

            switch (alt1) {
                case 1 :
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:93:5: this_ASTNode_0= ruleASTNode
                    {
                     
                            currentNode=createCompositeNode(grammarAccess.getNodeAccess().getASTNodeParserRuleCall_0(), currentNode); 
                        
                    pushFollow(FOLLOW_ruleASTNode_in_ruleNode132);
                    this_ASTNode_0=ruleASTNode();
                    _fsp--;

                     
                            current = this_ASTNode_0; 
                            currentNode = currentNode.getParent();
                        

                    }
                    break;
                case 2 :
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:103:5: this_ASTLeaf_1= ruleASTLeaf
                    {
                     
                            currentNode=createCompositeNode(grammarAccess.getNodeAccess().getASTLeafParserRuleCall_1(), currentNode); 
                        
                    pushFollow(FOLLOW_ruleASTLeaf_in_ruleNode159);
                    this_ASTLeaf_1=ruleASTLeaf();
                    _fsp--;

                     
                            current = this_ASTLeaf_1; 
                            currentNode = currentNode.getParent();
                        

                    }
                    break;
                case 3 :
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:113:5: this_BuiltInNode_2= ruleBuiltInNode
                    {
                     
                            currentNode=createCompositeNode(grammarAccess.getNodeAccess().getBuiltInNodeParserRuleCall_2(), currentNode); 
                        
                    pushFollow(FOLLOW_ruleBuiltInNode_in_ruleNode186);
                    this_BuiltInNode_2=ruleBuiltInNode();
                    _fsp--;

                     
                            current = this_BuiltInNode_2; 
                            currentNode = currentNode.getParent();
                        

                    }
                    break;

            }


            }

             resetLookahead(); 
                	lastConsumedNode = currentNode;
                
        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end ruleNode


    // $ANTLR start entryRuleASTNode
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:129:1: entryRuleASTNode returns [EObject current=null] : iv_ruleASTNode= ruleASTNode EOF ;
    public final EObject entryRuleASTNode() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleASTNode = null;


        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:130:2: (iv_ruleASTNode= ruleASTNode EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:131:2: iv_ruleASTNode= ruleASTNode EOF
            {
             currentNode = createCompositeNode(grammarAccess.getASTNodeRule(), currentNode); 
            pushFollow(FOLLOW_ruleASTNode_in_entryRuleASTNode221);
            iv_ruleASTNode=ruleASTNode();
            _fsp--;

             current =iv_ruleASTNode; 
            match(input,EOF,FOLLOW_EOF_in_entryRuleASTNode231); 

            }

        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end entryRuleASTNode


    // $ANTLR start ruleASTNode
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:138:1: ruleASTNode returns [EObject current=null] : ( ( (lv_name_0_0= RULE_ID ) ) '[' ( ( (lv_children_2_0= ruleNode ) ) ( ',' ( (lv_children_4_0= ruleNode ) ) )* )? ']' ) ;
    public final EObject ruleASTNode() throws RecognitionException {
        EObject current = null;

        Token lv_name_0_0=null;
        EObject lv_children_2_0 = null;

        EObject lv_children_4_0 = null;


         EObject temp=null; setCurrentLookahead(); resetLookahead(); 
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:143:6: ( ( ( (lv_name_0_0= RULE_ID ) ) '[' ( ( (lv_children_2_0= ruleNode ) ) ( ',' ( (lv_children_4_0= ruleNode ) ) )* )? ']' ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:144:1: ( ( (lv_name_0_0= RULE_ID ) ) '[' ( ( (lv_children_2_0= ruleNode ) ) ( ',' ( (lv_children_4_0= ruleNode ) ) )* )? ']' )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:144:1: ( ( (lv_name_0_0= RULE_ID ) ) '[' ( ( (lv_children_2_0= ruleNode ) ) ( ',' ( (lv_children_4_0= ruleNode ) ) )* )? ']' )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:144:2: ( (lv_name_0_0= RULE_ID ) ) '[' ( ( (lv_children_2_0= ruleNode ) ) ( ',' ( (lv_children_4_0= ruleNode ) ) )* )? ']'
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:144:2: ( (lv_name_0_0= RULE_ID ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:145:1: (lv_name_0_0= RULE_ID )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:145:1: (lv_name_0_0= RULE_ID )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:146:3: lv_name_0_0= RULE_ID
            {
            lv_name_0_0=(Token)input.LT(1);
            match(input,RULE_ID,FOLLOW_RULE_ID_in_ruleASTNode273); 

            			createLeafNode(grammarAccess.getASTNodeAccess().getNameIDTerminalRuleCall_0_0(), "name"); 
            		

            	        if (current==null) {
            	            current = factory.create(grammarAccess.getASTNodeRule().getType().getClassifier());
            	            associateNodeWithAstElement(currentNode, current);
            	        }
            	        try {
            	       		set(
            	       			current, 
            	       			"name",
            	        		lv_name_0_0, 
            	        		"ID", 
            	        		lastConsumedNode);
            	        } catch (ValueConverterException vce) {
            				handleValueConverterException(vce);
            	        }
            	    

            }


            }

            match(input,12,FOLLOW_12_in_ruleASTNode288); 

                    createLeafNode(grammarAccess.getASTNodeAccess().getLeftSquareBracketKeyword_1(), null); 
                
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:172:1: ( ( (lv_children_2_0= ruleNode ) ) ( ',' ( (lv_children_4_0= ruleNode ) ) )* )?
            int alt3=2;
            int LA3_0 = input.LA(1);

            if ( ((LA3_0>=RULE_ID && LA3_0<=RULE_STRING)||(LA3_0>=15 && LA3_0<=16)) ) {
                alt3=1;
            }
            switch (alt3) {
                case 1 :
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:172:2: ( (lv_children_2_0= ruleNode ) ) ( ',' ( (lv_children_4_0= ruleNode ) ) )*
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:172:2: ( (lv_children_2_0= ruleNode ) )
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:173:1: (lv_children_2_0= ruleNode )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:173:1: (lv_children_2_0= ruleNode )
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:174:3: lv_children_2_0= ruleNode
                    {
                     
                    	        currentNode=createCompositeNode(grammarAccess.getASTNodeAccess().getChildrenNodeParserRuleCall_2_0_0(), currentNode); 
                    	    
                    pushFollow(FOLLOW_ruleNode_in_ruleASTNode310);
                    lv_children_2_0=ruleNode();
                    _fsp--;


                    	        if (current==null) {
                    	            current = factory.create(grammarAccess.getASTNodeRule().getType().getClassifier());
                    	            associateNodeWithAstElement(currentNode.getParent(), current);
                    	        }
                    	        try {
                    	       		add(
                    	       			current, 
                    	       			"children",
                    	        		lv_children_2_0, 
                    	        		"Node", 
                    	        		currentNode);
                    	        } catch (ValueConverterException vce) {
                    				handleValueConverterException(vce);
                    	        }
                    	        currentNode = currentNode.getParent();
                    	    

                    }


                    }

                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:196:2: ( ',' ( (lv_children_4_0= ruleNode ) ) )*
                    loop2:
                    do {
                        int alt2=2;
                        int LA2_0 = input.LA(1);

                        if ( (LA2_0==13) ) {
                            alt2=1;
                        }


                        switch (alt2) {
                    	case 1 :
                    	    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:196:4: ',' ( (lv_children_4_0= ruleNode ) )
                    	    {
                    	    match(input,13,FOLLOW_13_in_ruleASTNode321); 

                    	            createLeafNode(grammarAccess.getASTNodeAccess().getCommaKeyword_2_1_0(), null); 
                    	        
                    	    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:200:1: ( (lv_children_4_0= ruleNode ) )
                    	    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:201:1: (lv_children_4_0= ruleNode )
                    	    {
                    	    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:201:1: (lv_children_4_0= ruleNode )
                    	    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:202:3: lv_children_4_0= ruleNode
                    	    {
                    	     
                    	    	        currentNode=createCompositeNode(grammarAccess.getASTNodeAccess().getChildrenNodeParserRuleCall_2_1_1_0(), currentNode); 
                    	    	    
                    	    pushFollow(FOLLOW_ruleNode_in_ruleASTNode342);
                    	    lv_children_4_0=ruleNode();
                    	    _fsp--;


                    	    	        if (current==null) {
                    	    	            current = factory.create(grammarAccess.getASTNodeRule().getType().getClassifier());
                    	    	            associateNodeWithAstElement(currentNode.getParent(), current);
                    	    	        }
                    	    	        try {
                    	    	       		add(
                    	    	       			current, 
                    	    	       			"children",
                    	    	        		lv_children_4_0, 
                    	    	        		"Node", 
                    	    	        		currentNode);
                    	    	        } catch (ValueConverterException vce) {
                    	    				handleValueConverterException(vce);
                    	    	        }
                    	    	        currentNode = currentNode.getParent();
                    	    	    

                    	    }


                    	    }


                    	    }
                    	    break;

                    	default :
                    	    break loop2;
                        }
                    } while (true);


                    }
                    break;

            }

            match(input,14,FOLLOW_14_in_ruleASTNode356); 

                    createLeafNode(grammarAccess.getASTNodeAccess().getRightSquareBracketKeyword_3(), null); 
                

            }


            }

             resetLookahead(); 
                	lastConsumedNode = currentNode;
                
        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end ruleASTNode


    // $ANTLR start entryRuleBuiltInNode
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:236:1: entryRuleBuiltInNode returns [EObject current=null] : iv_ruleBuiltInNode= ruleBuiltInNode EOF ;
    public final EObject entryRuleBuiltInNode() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleBuiltInNode = null;


        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:237:2: (iv_ruleBuiltInNode= ruleBuiltInNode EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:238:2: iv_ruleBuiltInNode= ruleBuiltInNode EOF
            {
             currentNode = createCompositeNode(grammarAccess.getBuiltInNodeRule(), currentNode); 
            pushFollow(FOLLOW_ruleBuiltInNode_in_entryRuleBuiltInNode392);
            iv_ruleBuiltInNode=ruleBuiltInNode();
            _fsp--;

             current =iv_ruleBuiltInNode; 
            match(input,EOF,FOLLOW_EOF_in_entryRuleBuiltInNode402); 

            }

        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end entryRuleBuiltInNode


    // $ANTLR start ruleBuiltInNode
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:245:1: ruleBuiltInNode returns [EObject current=null] : ( ( (lv_keyword_0_0= RULE_KEYWORD ) ) '[' ( ( (lv_children_2_0= ruleNode ) ) ( ',' ( (lv_children_4_0= ruleNode ) ) )* )? ']' ) ;
    public final EObject ruleBuiltInNode() throws RecognitionException {
        EObject current = null;

        Token lv_keyword_0_0=null;
        EObject lv_children_2_0 = null;

        EObject lv_children_4_0 = null;


         EObject temp=null; setCurrentLookahead(); resetLookahead(); 
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:250:6: ( ( ( (lv_keyword_0_0= RULE_KEYWORD ) ) '[' ( ( (lv_children_2_0= ruleNode ) ) ( ',' ( (lv_children_4_0= ruleNode ) ) )* )? ']' ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:251:1: ( ( (lv_keyword_0_0= RULE_KEYWORD ) ) '[' ( ( (lv_children_2_0= ruleNode ) ) ( ',' ( (lv_children_4_0= ruleNode ) ) )* )? ']' )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:251:1: ( ( (lv_keyword_0_0= RULE_KEYWORD ) ) '[' ( ( (lv_children_2_0= ruleNode ) ) ( ',' ( (lv_children_4_0= ruleNode ) ) )* )? ']' )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:251:2: ( (lv_keyword_0_0= RULE_KEYWORD ) ) '[' ( ( (lv_children_2_0= ruleNode ) ) ( ',' ( (lv_children_4_0= ruleNode ) ) )* )? ']'
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:251:2: ( (lv_keyword_0_0= RULE_KEYWORD ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:252:1: (lv_keyword_0_0= RULE_KEYWORD )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:252:1: (lv_keyword_0_0= RULE_KEYWORD )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:253:3: lv_keyword_0_0= RULE_KEYWORD
            {
            lv_keyword_0_0=(Token)input.LT(1);
            match(input,RULE_KEYWORD,FOLLOW_RULE_KEYWORD_in_ruleBuiltInNode444); 

            			createLeafNode(grammarAccess.getBuiltInNodeAccess().getKeywordKeyWordTerminalRuleCall_0_0(), "keyword"); 
            		

            	        if (current==null) {
            	            current = factory.create(grammarAccess.getBuiltInNodeRule().getType().getClassifier());
            	            associateNodeWithAstElement(currentNode, current);
            	        }
            	        try {
            	       		set(
            	       			current, 
            	       			"keyword",
            	        		lv_keyword_0_0, 
            	        		"KeyWord", 
            	        		lastConsumedNode);
            	        } catch (ValueConverterException vce) {
            				handleValueConverterException(vce);
            	        }
            	    

            }


            }

            match(input,12,FOLLOW_12_in_ruleBuiltInNode459); 

                    createLeafNode(grammarAccess.getBuiltInNodeAccess().getLeftSquareBracketKeyword_1(), null); 
                
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:279:1: ( ( (lv_children_2_0= ruleNode ) ) ( ',' ( (lv_children_4_0= ruleNode ) ) )* )?
            int alt5=2;
            int LA5_0 = input.LA(1);

            if ( ((LA5_0>=RULE_ID && LA5_0<=RULE_STRING)||(LA5_0>=15 && LA5_0<=16)) ) {
                alt5=1;
            }
            switch (alt5) {
                case 1 :
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:279:2: ( (lv_children_2_0= ruleNode ) ) ( ',' ( (lv_children_4_0= ruleNode ) ) )*
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:279:2: ( (lv_children_2_0= ruleNode ) )
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:280:1: (lv_children_2_0= ruleNode )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:280:1: (lv_children_2_0= ruleNode )
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:281:3: lv_children_2_0= ruleNode
                    {
                     
                    	        currentNode=createCompositeNode(grammarAccess.getBuiltInNodeAccess().getChildrenNodeParserRuleCall_2_0_0(), currentNode); 
                    	    
                    pushFollow(FOLLOW_ruleNode_in_ruleBuiltInNode481);
                    lv_children_2_0=ruleNode();
                    _fsp--;


                    	        if (current==null) {
                    	            current = factory.create(grammarAccess.getBuiltInNodeRule().getType().getClassifier());
                    	            associateNodeWithAstElement(currentNode.getParent(), current);
                    	        }
                    	        try {
                    	       		add(
                    	       			current, 
                    	       			"children",
                    	        		lv_children_2_0, 
                    	        		"Node", 
                    	        		currentNode);
                    	        } catch (ValueConverterException vce) {
                    				handleValueConverterException(vce);
                    	        }
                    	        currentNode = currentNode.getParent();
                    	    

                    }


                    }

                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:303:2: ( ',' ( (lv_children_4_0= ruleNode ) ) )*
                    loop4:
                    do {
                        int alt4=2;
                        int LA4_0 = input.LA(1);

                        if ( (LA4_0==13) ) {
                            alt4=1;
                        }


                        switch (alt4) {
                    	case 1 :
                    	    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:303:4: ',' ( (lv_children_4_0= ruleNode ) )
                    	    {
                    	    match(input,13,FOLLOW_13_in_ruleBuiltInNode492); 

                    	            createLeafNode(grammarAccess.getBuiltInNodeAccess().getCommaKeyword_2_1_0(), null); 
                    	        
                    	    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:307:1: ( (lv_children_4_0= ruleNode ) )
                    	    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:308:1: (lv_children_4_0= ruleNode )
                    	    {
                    	    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:308:1: (lv_children_4_0= ruleNode )
                    	    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:309:3: lv_children_4_0= ruleNode
                    	    {
                    	     
                    	    	        currentNode=createCompositeNode(grammarAccess.getBuiltInNodeAccess().getChildrenNodeParserRuleCall_2_1_1_0(), currentNode); 
                    	    	    
                    	    pushFollow(FOLLOW_ruleNode_in_ruleBuiltInNode513);
                    	    lv_children_4_0=ruleNode();
                    	    _fsp--;


                    	    	        if (current==null) {
                    	    	            current = factory.create(grammarAccess.getBuiltInNodeRule().getType().getClassifier());
                    	    	            associateNodeWithAstElement(currentNode.getParent(), current);
                    	    	        }
                    	    	        try {
                    	    	       		add(
                    	    	       			current, 
                    	    	       			"children",
                    	    	        		lv_children_4_0, 
                    	    	        		"Node", 
                    	    	        		currentNode);
                    	    	        } catch (ValueConverterException vce) {
                    	    				handleValueConverterException(vce);
                    	    	        }
                    	    	        currentNode = currentNode.getParent();
                    	    	    

                    	    }


                    	    }


                    	    }
                    	    break;

                    	default :
                    	    break loop4;
                        }
                    } while (true);


                    }
                    break;

            }

            match(input,14,FOLLOW_14_in_ruleBuiltInNode527); 

                    createLeafNode(grammarAccess.getBuiltInNodeAccess().getRightSquareBracketKeyword_3(), null); 
                

            }


            }

             resetLookahead(); 
                	lastConsumedNode = currentNode;
                
        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end ruleBuiltInNode


    // $ANTLR start entryRuleASTLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:343:1: entryRuleASTLeaf returns [EObject current=null] : iv_ruleASTLeaf= ruleASTLeaf EOF ;
    public final EObject entryRuleASTLeaf() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleASTLeaf = null;


        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:344:2: (iv_ruleASTLeaf= ruleASTLeaf EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:345:2: iv_ruleASTLeaf= ruleASTLeaf EOF
            {
             currentNode = createCompositeNode(grammarAccess.getASTLeafRule(), currentNode); 
            pushFollow(FOLLOW_ruleASTLeaf_in_entryRuleASTLeaf563);
            iv_ruleASTLeaf=ruleASTLeaf();
            _fsp--;

             current =iv_ruleASTLeaf; 
            match(input,EOF,FOLLOW_EOF_in_entryRuleASTLeaf573); 

            }

        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end entryRuleASTLeaf


    // $ANTLR start ruleASTLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:352:1: ruleASTLeaf returns [EObject current=null] : (this_IntLeaf_0= ruleIntLeaf | this_StringLeaf_1= ruleStringLeaf | this_FloatLeaf_2= ruleFloatLeaf | this_SymbolLeaf_3= ruleSymbolLeaf ) ;
    public final EObject ruleASTLeaf() throws RecognitionException {
        EObject current = null;

        EObject this_IntLeaf_0 = null;

        EObject this_StringLeaf_1 = null;

        EObject this_FloatLeaf_2 = null;

        EObject this_SymbolLeaf_3 = null;


         EObject temp=null; setCurrentLookahead(); resetLookahead(); 
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:357:6: ( (this_IntLeaf_0= ruleIntLeaf | this_StringLeaf_1= ruleStringLeaf | this_FloatLeaf_2= ruleFloatLeaf | this_SymbolLeaf_3= ruleSymbolLeaf ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:358:1: (this_IntLeaf_0= ruleIntLeaf | this_StringLeaf_1= ruleStringLeaf | this_FloatLeaf_2= ruleFloatLeaf | this_SymbolLeaf_3= ruleSymbolLeaf )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:358:1: (this_IntLeaf_0= ruleIntLeaf | this_StringLeaf_1= ruleStringLeaf | this_FloatLeaf_2= ruleFloatLeaf | this_SymbolLeaf_3= ruleSymbolLeaf )
            int alt6=4;
            switch ( input.LA(1) ) {
            case 15:
                {
                int LA6_1 = input.LA(2);

                if ( (LA6_1==RULE_INT) ) {
                    int LA6_2 = input.LA(3);

                    if ( (LA6_2==16) ) {
                        alt6=3;
                    }
                    else if ( (LA6_2==EOF||(LA6_2>=13 && LA6_2<=14)) ) {
                        alt6=1;
                    }
                    else {
                        NoViableAltException nvae =
                            new NoViableAltException("358:1: (this_IntLeaf_0= ruleIntLeaf | this_StringLeaf_1= ruleStringLeaf | this_FloatLeaf_2= ruleFloatLeaf | this_SymbolLeaf_3= ruleSymbolLeaf )", 6, 2, input);

                        throw nvae;
                    }
                }
                else if ( (LA6_1==16) ) {
                    alt6=3;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("358:1: (this_IntLeaf_0= ruleIntLeaf | this_StringLeaf_1= ruleStringLeaf | this_FloatLeaf_2= ruleFloatLeaf | this_SymbolLeaf_3= ruleSymbolLeaf )", 6, 1, input);

                    throw nvae;
                }
                }
                break;
            case RULE_INT:
                {
                int LA6_2 = input.LA(2);

                if ( (LA6_2==16) ) {
                    alt6=3;
                }
                else if ( (LA6_2==EOF||(LA6_2>=13 && LA6_2<=14)) ) {
                    alt6=1;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("358:1: (this_IntLeaf_0= ruleIntLeaf | this_StringLeaf_1= ruleStringLeaf | this_FloatLeaf_2= ruleFloatLeaf | this_SymbolLeaf_3= ruleSymbolLeaf )", 6, 2, input);

                    throw nvae;
                }
                }
                break;
            case RULE_STRING:
                {
                alt6=2;
                }
                break;
            case 16:
                {
                alt6=3;
                }
                break;
            case RULE_ID:
                {
                alt6=4;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("358:1: (this_IntLeaf_0= ruleIntLeaf | this_StringLeaf_1= ruleStringLeaf | this_FloatLeaf_2= ruleFloatLeaf | this_SymbolLeaf_3= ruleSymbolLeaf )", 6, 0, input);

                throw nvae;
            }

            switch (alt6) {
                case 1 :
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:359:5: this_IntLeaf_0= ruleIntLeaf
                    {
                     
                            currentNode=createCompositeNode(grammarAccess.getASTLeafAccess().getIntLeafParserRuleCall_0(), currentNode); 
                        
                    pushFollow(FOLLOW_ruleIntLeaf_in_ruleASTLeaf620);
                    this_IntLeaf_0=ruleIntLeaf();
                    _fsp--;

                     
                            current = this_IntLeaf_0; 
                            currentNode = currentNode.getParent();
                        

                    }
                    break;
                case 2 :
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:369:5: this_StringLeaf_1= ruleStringLeaf
                    {
                     
                            currentNode=createCompositeNode(grammarAccess.getASTLeafAccess().getStringLeafParserRuleCall_1(), currentNode); 
                        
                    pushFollow(FOLLOW_ruleStringLeaf_in_ruleASTLeaf647);
                    this_StringLeaf_1=ruleStringLeaf();
                    _fsp--;

                     
                            current = this_StringLeaf_1; 
                            currentNode = currentNode.getParent();
                        

                    }
                    break;
                case 3 :
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:379:5: this_FloatLeaf_2= ruleFloatLeaf
                    {
                     
                            currentNode=createCompositeNode(grammarAccess.getASTLeafAccess().getFloatLeafParserRuleCall_2(), currentNode); 
                        
                    pushFollow(FOLLOW_ruleFloatLeaf_in_ruleASTLeaf674);
                    this_FloatLeaf_2=ruleFloatLeaf();
                    _fsp--;

                     
                            current = this_FloatLeaf_2; 
                            currentNode = currentNode.getParent();
                        

                    }
                    break;
                case 4 :
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:389:5: this_SymbolLeaf_3= ruleSymbolLeaf
                    {
                     
                            currentNode=createCompositeNode(grammarAccess.getASTLeafAccess().getSymbolLeafParserRuleCall_3(), currentNode); 
                        
                    pushFollow(FOLLOW_ruleSymbolLeaf_in_ruleASTLeaf701);
                    this_SymbolLeaf_3=ruleSymbolLeaf();
                    _fsp--;

                     
                            current = this_SymbolLeaf_3; 
                            currentNode = currentNode.getParent();
                        

                    }
                    break;

            }


            }

             resetLookahead(); 
                	lastConsumedNode = currentNode;
                
        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end ruleASTLeaf


    // $ANTLR start entryRuleIntLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:405:1: entryRuleIntLeaf returns [EObject current=null] : iv_ruleIntLeaf= ruleIntLeaf EOF ;
    public final EObject entryRuleIntLeaf() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleIntLeaf = null;


        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:406:2: (iv_ruleIntLeaf= ruleIntLeaf EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:407:2: iv_ruleIntLeaf= ruleIntLeaf EOF
            {
             currentNode = createCompositeNode(grammarAccess.getIntLeafRule(), currentNode); 
            pushFollow(FOLLOW_ruleIntLeaf_in_entryRuleIntLeaf736);
            iv_ruleIntLeaf=ruleIntLeaf();
            _fsp--;

             current =iv_ruleIntLeaf; 
            match(input,EOF,FOLLOW_EOF_in_entryRuleIntLeaf746); 

            }

        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end entryRuleIntLeaf


    // $ANTLR start ruleIntLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:414:1: ruleIntLeaf returns [EObject current=null] : ( ( (lv_signed_0_0= '-' ) )? ( (lv_value_1_0= RULE_INT ) ) ) ;
    public final EObject ruleIntLeaf() throws RecognitionException {
        EObject current = null;

        Token lv_signed_0_0=null;
        Token lv_value_1_0=null;

         EObject temp=null; setCurrentLookahead(); resetLookahead(); 
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:419:6: ( ( ( (lv_signed_0_0= '-' ) )? ( (lv_value_1_0= RULE_INT ) ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:420:1: ( ( (lv_signed_0_0= '-' ) )? ( (lv_value_1_0= RULE_INT ) ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:420:1: ( ( (lv_signed_0_0= '-' ) )? ( (lv_value_1_0= RULE_INT ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:420:2: ( (lv_signed_0_0= '-' ) )? ( (lv_value_1_0= RULE_INT ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:420:2: ( (lv_signed_0_0= '-' ) )?
            int alt7=2;
            int LA7_0 = input.LA(1);

            if ( (LA7_0==15) ) {
                alt7=1;
            }
            switch (alt7) {
                case 1 :
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:421:1: (lv_signed_0_0= '-' )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:421:1: (lv_signed_0_0= '-' )
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:422:3: lv_signed_0_0= '-'
                    {
                    lv_signed_0_0=(Token)input.LT(1);
                    match(input,15,FOLLOW_15_in_ruleIntLeaf789); 

                            createLeafNode(grammarAccess.getIntLeafAccess().getSignedHyphenMinusKeyword_0_0(), "signed"); 
                        

                    	        if (current==null) {
                    	            current = factory.create(grammarAccess.getIntLeafRule().getType().getClassifier());
                    	            associateNodeWithAstElement(currentNode, current);
                    	        }
                    	        
                    	        try {
                    	       		set(current, "signed", lv_signed_0_0, "-", lastConsumedNode);
                    	        } catch (ValueConverterException vce) {
                    				handleValueConverterException(vce);
                    	        }
                    	    

                    }


                    }
                    break;

            }

            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:441:3: ( (lv_value_1_0= RULE_INT ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:442:1: (lv_value_1_0= RULE_INT )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:442:1: (lv_value_1_0= RULE_INT )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:443:3: lv_value_1_0= RULE_INT
            {
            lv_value_1_0=(Token)input.LT(1);
            match(input,RULE_INT,FOLLOW_RULE_INT_in_ruleIntLeaf820); 

            			createLeafNode(grammarAccess.getIntLeafAccess().getValueINTTerminalRuleCall_1_0(), "value"); 
            		

            	        if (current==null) {
            	            current = factory.create(grammarAccess.getIntLeafRule().getType().getClassifier());
            	            associateNodeWithAstElement(currentNode, current);
            	        }
            	        try {
            	       		set(
            	       			current, 
            	       			"value",
            	        		lv_value_1_0, 
            	        		"INT", 
            	        		lastConsumedNode);
            	        } catch (ValueConverterException vce) {
            				handleValueConverterException(vce);
            	        }
            	    

            }


            }


            }


            }

             resetLookahead(); 
                	lastConsumedNode = currentNode;
                
        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end ruleIntLeaf


    // $ANTLR start entryRuleStringLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:473:1: entryRuleStringLeaf returns [EObject current=null] : iv_ruleStringLeaf= ruleStringLeaf EOF ;
    public final EObject entryRuleStringLeaf() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleStringLeaf = null;


        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:474:2: (iv_ruleStringLeaf= ruleStringLeaf EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:475:2: iv_ruleStringLeaf= ruleStringLeaf EOF
            {
             currentNode = createCompositeNode(grammarAccess.getStringLeafRule(), currentNode); 
            pushFollow(FOLLOW_ruleStringLeaf_in_entryRuleStringLeaf861);
            iv_ruleStringLeaf=ruleStringLeaf();
            _fsp--;

             current =iv_ruleStringLeaf; 
            match(input,EOF,FOLLOW_EOF_in_entryRuleStringLeaf871); 

            }

        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end entryRuleStringLeaf


    // $ANTLR start ruleStringLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:482:1: ruleStringLeaf returns [EObject current=null] : ( (lv_value_0_0= RULE_STRING ) ) ;
    public final EObject ruleStringLeaf() throws RecognitionException {
        EObject current = null;

        Token lv_value_0_0=null;

         EObject temp=null; setCurrentLookahead(); resetLookahead(); 
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:487:6: ( ( (lv_value_0_0= RULE_STRING ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:488:1: ( (lv_value_0_0= RULE_STRING ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:488:1: ( (lv_value_0_0= RULE_STRING ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:489:1: (lv_value_0_0= RULE_STRING )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:489:1: (lv_value_0_0= RULE_STRING )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:490:3: lv_value_0_0= RULE_STRING
            {
            lv_value_0_0=(Token)input.LT(1);
            match(input,RULE_STRING,FOLLOW_RULE_STRING_in_ruleStringLeaf912); 

            			createLeafNode(grammarAccess.getStringLeafAccess().getValueSTRINGTerminalRuleCall_0(), "value"); 
            		

            	        if (current==null) {
            	            current = factory.create(grammarAccess.getStringLeafRule().getType().getClassifier());
            	            associateNodeWithAstElement(currentNode, current);
            	        }
            	        try {
            	       		set(
            	       			current, 
            	       			"value",
            	        		lv_value_0_0, 
            	        		"STRING", 
            	        		lastConsumedNode);
            	        } catch (ValueConverterException vce) {
            				handleValueConverterException(vce);
            	        }
            	    

            }


            }


            }

             resetLookahead(); 
                	lastConsumedNode = currentNode;
                
        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end ruleStringLeaf


    // $ANTLR start entryRuleSymbolLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:520:1: entryRuleSymbolLeaf returns [EObject current=null] : iv_ruleSymbolLeaf= ruleSymbolLeaf EOF ;
    public final EObject entryRuleSymbolLeaf() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleSymbolLeaf = null;


        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:521:2: (iv_ruleSymbolLeaf= ruleSymbolLeaf EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:522:2: iv_ruleSymbolLeaf= ruleSymbolLeaf EOF
            {
             currentNode = createCompositeNode(grammarAccess.getSymbolLeafRule(), currentNode); 
            pushFollow(FOLLOW_ruleSymbolLeaf_in_entryRuleSymbolLeaf952);
            iv_ruleSymbolLeaf=ruleSymbolLeaf();
            _fsp--;

             current =iv_ruleSymbolLeaf; 
            match(input,EOF,FOLLOW_EOF_in_entryRuleSymbolLeaf962); 

            }

        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end entryRuleSymbolLeaf


    // $ANTLR start ruleSymbolLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:529:1: ruleSymbolLeaf returns [EObject current=null] : ( (lv_name_0_0= RULE_ID ) ) ;
    public final EObject ruleSymbolLeaf() throws RecognitionException {
        EObject current = null;

        Token lv_name_0_0=null;

         EObject temp=null; setCurrentLookahead(); resetLookahead(); 
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:534:6: ( ( (lv_name_0_0= RULE_ID ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:535:1: ( (lv_name_0_0= RULE_ID ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:535:1: ( (lv_name_0_0= RULE_ID ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:536:1: (lv_name_0_0= RULE_ID )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:536:1: (lv_name_0_0= RULE_ID )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:537:3: lv_name_0_0= RULE_ID
            {
            lv_name_0_0=(Token)input.LT(1);
            match(input,RULE_ID,FOLLOW_RULE_ID_in_ruleSymbolLeaf1003); 

            			createLeafNode(grammarAccess.getSymbolLeafAccess().getNameIDTerminalRuleCall_0(), "name"); 
            		

            	        if (current==null) {
            	            current = factory.create(grammarAccess.getSymbolLeafRule().getType().getClassifier());
            	            associateNodeWithAstElement(currentNode, current);
            	        }
            	        try {
            	       		set(
            	       			current, 
            	       			"name",
            	        		lv_name_0_0, 
            	        		"ID", 
            	        		lastConsumedNode);
            	        } catch (ValueConverterException vce) {
            				handleValueConverterException(vce);
            	        }
            	    

            }


            }


            }

             resetLookahead(); 
                	lastConsumedNode = currentNode;
                
        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end ruleSymbolLeaf


    // $ANTLR start entryRuleFloatLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:567:1: entryRuleFloatLeaf returns [EObject current=null] : iv_ruleFloatLeaf= ruleFloatLeaf EOF ;
    public final EObject entryRuleFloatLeaf() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleFloatLeaf = null;


        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:568:2: (iv_ruleFloatLeaf= ruleFloatLeaf EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:569:2: iv_ruleFloatLeaf= ruleFloatLeaf EOF
            {
             currentNode = createCompositeNode(grammarAccess.getFloatLeafRule(), currentNode); 
            pushFollow(FOLLOW_ruleFloatLeaf_in_entryRuleFloatLeaf1043);
            iv_ruleFloatLeaf=ruleFloatLeaf();
            _fsp--;

             current =iv_ruleFloatLeaf; 
            match(input,EOF,FOLLOW_EOF_in_entryRuleFloatLeaf1053); 

            }

        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end entryRuleFloatLeaf


    // $ANTLR start ruleFloatLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:576:1: ruleFloatLeaf returns [EObject current=null] : ( ( (lv_signed_0_0= '-' ) )? ( ( ( (lv_a_1_0= RULE_INT ) ) '.' ( (lv_b_3_0= RULE_INT ) ) ) | ( '.' ( (lv_b_5_0= RULE_INT ) ) ) ) ) ;
    public final EObject ruleFloatLeaf() throws RecognitionException {
        EObject current = null;

        Token lv_signed_0_0=null;
        Token lv_a_1_0=null;
        Token lv_b_3_0=null;
        Token lv_b_5_0=null;

         EObject temp=null; setCurrentLookahead(); resetLookahead(); 
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:581:6: ( ( ( (lv_signed_0_0= '-' ) )? ( ( ( (lv_a_1_0= RULE_INT ) ) '.' ( (lv_b_3_0= RULE_INT ) ) ) | ( '.' ( (lv_b_5_0= RULE_INT ) ) ) ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:582:1: ( ( (lv_signed_0_0= '-' ) )? ( ( ( (lv_a_1_0= RULE_INT ) ) '.' ( (lv_b_3_0= RULE_INT ) ) ) | ( '.' ( (lv_b_5_0= RULE_INT ) ) ) ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:582:1: ( ( (lv_signed_0_0= '-' ) )? ( ( ( (lv_a_1_0= RULE_INT ) ) '.' ( (lv_b_3_0= RULE_INT ) ) ) | ( '.' ( (lv_b_5_0= RULE_INT ) ) ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:582:2: ( (lv_signed_0_0= '-' ) )? ( ( ( (lv_a_1_0= RULE_INT ) ) '.' ( (lv_b_3_0= RULE_INT ) ) ) | ( '.' ( (lv_b_5_0= RULE_INT ) ) ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:582:2: ( (lv_signed_0_0= '-' ) )?
            int alt8=2;
            int LA8_0 = input.LA(1);

            if ( (LA8_0==15) ) {
                alt8=1;
            }
            switch (alt8) {
                case 1 :
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:583:1: (lv_signed_0_0= '-' )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:583:1: (lv_signed_0_0= '-' )
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:584:3: lv_signed_0_0= '-'
                    {
                    lv_signed_0_0=(Token)input.LT(1);
                    match(input,15,FOLLOW_15_in_ruleFloatLeaf1096); 

                            createLeafNode(grammarAccess.getFloatLeafAccess().getSignedHyphenMinusKeyword_0_0(), "signed"); 
                        

                    	        if (current==null) {
                    	            current = factory.create(grammarAccess.getFloatLeafRule().getType().getClassifier());
                    	            associateNodeWithAstElement(currentNode, current);
                    	        }
                    	        
                    	        try {
                    	       		set(current, "signed", lv_signed_0_0, "-", lastConsumedNode);
                    	        } catch (ValueConverterException vce) {
                    				handleValueConverterException(vce);
                    	        }
                    	    

                    }


                    }
                    break;

            }

            // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:603:3: ( ( ( (lv_a_1_0= RULE_INT ) ) '.' ( (lv_b_3_0= RULE_INT ) ) ) | ( '.' ( (lv_b_5_0= RULE_INT ) ) ) )
            int alt9=2;
            int LA9_0 = input.LA(1);

            if ( (LA9_0==RULE_INT) ) {
                alt9=1;
            }
            else if ( (LA9_0==16) ) {
                alt9=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("603:3: ( ( ( (lv_a_1_0= RULE_INT ) ) '.' ( (lv_b_3_0= RULE_INT ) ) ) | ( '.' ( (lv_b_5_0= RULE_INT ) ) ) )", 9, 0, input);

                throw nvae;
            }
            switch (alt9) {
                case 1 :
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:603:4: ( ( (lv_a_1_0= RULE_INT ) ) '.' ( (lv_b_3_0= RULE_INT ) ) )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:603:4: ( ( (lv_a_1_0= RULE_INT ) ) '.' ( (lv_b_3_0= RULE_INT ) ) )
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:603:5: ( (lv_a_1_0= RULE_INT ) ) '.' ( (lv_b_3_0= RULE_INT ) )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:603:5: ( (lv_a_1_0= RULE_INT ) )
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:604:1: (lv_a_1_0= RULE_INT )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:604:1: (lv_a_1_0= RULE_INT )
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:605:3: lv_a_1_0= RULE_INT
                    {
                    lv_a_1_0=(Token)input.LT(1);
                    match(input,RULE_INT,FOLLOW_RULE_INT_in_ruleFloatLeaf1129); 

                    			createLeafNode(grammarAccess.getFloatLeafAccess().getAINTTerminalRuleCall_1_0_0_0(), "a"); 
                    		

                    	        if (current==null) {
                    	            current = factory.create(grammarAccess.getFloatLeafRule().getType().getClassifier());
                    	            associateNodeWithAstElement(currentNode, current);
                    	        }
                    	        try {
                    	       		set(
                    	       			current, 
                    	       			"a",
                    	        		lv_a_1_0, 
                    	        		"INT", 
                    	        		lastConsumedNode);
                    	        } catch (ValueConverterException vce) {
                    				handleValueConverterException(vce);
                    	        }
                    	    

                    }


                    }

                    match(input,16,FOLLOW_16_in_ruleFloatLeaf1144); 

                            createLeafNode(grammarAccess.getFloatLeafAccess().getFullStopKeyword_1_0_1(), null); 
                        
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:631:1: ( (lv_b_3_0= RULE_INT ) )
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:632:1: (lv_b_3_0= RULE_INT )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:632:1: (lv_b_3_0= RULE_INT )
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:633:3: lv_b_3_0= RULE_INT
                    {
                    lv_b_3_0=(Token)input.LT(1);
                    match(input,RULE_INT,FOLLOW_RULE_INT_in_ruleFloatLeaf1161); 

                    			createLeafNode(grammarAccess.getFloatLeafAccess().getBINTTerminalRuleCall_1_0_2_0(), "b"); 
                    		

                    	        if (current==null) {
                    	            current = factory.create(grammarAccess.getFloatLeafRule().getType().getClassifier());
                    	            associateNodeWithAstElement(currentNode, current);
                    	        }
                    	        try {
                    	       		set(
                    	       			current, 
                    	       			"b",
                    	        		lv_b_3_0, 
                    	        		"INT", 
                    	        		lastConsumedNode);
                    	        } catch (ValueConverterException vce) {
                    				handleValueConverterException(vce);
                    	        }
                    	    

                    }


                    }


                    }


                    }
                    break;
                case 2 :
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:656:6: ( '.' ( (lv_b_5_0= RULE_INT ) ) )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:656:6: ( '.' ( (lv_b_5_0= RULE_INT ) ) )
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:656:8: '.' ( (lv_b_5_0= RULE_INT ) )
                    {
                    match(input,16,FOLLOW_16_in_ruleFloatLeaf1184); 

                            createLeafNode(grammarAccess.getFloatLeafAccess().getFullStopKeyword_1_1_0(), null); 
                        
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:660:1: ( (lv_b_5_0= RULE_INT ) )
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:661:1: (lv_b_5_0= RULE_INT )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:661:1: (lv_b_5_0= RULE_INT )
                    // ../fr.irisa.cairn.model.mathematica.xtext/src-gen/fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.g:662:3: lv_b_5_0= RULE_INT
                    {
                    lv_b_5_0=(Token)input.LT(1);
                    match(input,RULE_INT,FOLLOW_RULE_INT_in_ruleFloatLeaf1201); 

                    			createLeafNode(grammarAccess.getFloatLeafAccess().getBINTTerminalRuleCall_1_1_1_0(), "b"); 
                    		

                    	        if (current==null) {
                    	            current = factory.create(grammarAccess.getFloatLeafRule().getType().getClassifier());
                    	            associateNodeWithAstElement(currentNode, current);
                    	        }
                    	        try {
                    	       		set(
                    	       			current, 
                    	       			"b",
                    	        		lv_b_5_0, 
                    	        		"INT", 
                    	        		lastConsumedNode);
                    	        } catch (ValueConverterException vce) {
                    				handleValueConverterException(vce);
                    	        }
                    	    

                    }


                    }


                    }


                    }
                    break;

            }


            }


            }

             resetLookahead(); 
                	lastConsumedNode = currentNode;
                
        }
         
            catch (RecognitionException re) { 
                recover(input,re); 
                appendSkippedTokens();
            } 
        finally {
        }
        return current;
    }
    // $ANTLR end ruleFloatLeaf


 

    public static final BitSet FOLLOW_ruleNode_in_entryRuleNode75 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleNode85 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleASTNode_in_ruleNode132 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleASTLeaf_in_ruleNode159 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleBuiltInNode_in_ruleNode186 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleASTNode_in_entryRuleASTNode221 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleASTNode231 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RULE_ID_in_ruleASTNode273 = new BitSet(new long[]{0x0000000000001000L});
    public static final BitSet FOLLOW_12_in_ruleASTNode288 = new BitSet(new long[]{0x000000000001C0F0L});
    public static final BitSet FOLLOW_ruleNode_in_ruleASTNode310 = new BitSet(new long[]{0x0000000000006000L});
    public static final BitSet FOLLOW_13_in_ruleASTNode321 = new BitSet(new long[]{0x00000000000180F0L});
    public static final BitSet FOLLOW_ruleNode_in_ruleASTNode342 = new BitSet(new long[]{0x0000000000006000L});
    public static final BitSet FOLLOW_14_in_ruleASTNode356 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleBuiltInNode_in_entryRuleBuiltInNode392 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleBuiltInNode402 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RULE_KEYWORD_in_ruleBuiltInNode444 = new BitSet(new long[]{0x0000000000001000L});
    public static final BitSet FOLLOW_12_in_ruleBuiltInNode459 = new BitSet(new long[]{0x000000000001C0F0L});
    public static final BitSet FOLLOW_ruleNode_in_ruleBuiltInNode481 = new BitSet(new long[]{0x0000000000006000L});
    public static final BitSet FOLLOW_13_in_ruleBuiltInNode492 = new BitSet(new long[]{0x00000000000180F0L});
    public static final BitSet FOLLOW_ruleNode_in_ruleBuiltInNode513 = new BitSet(new long[]{0x0000000000006000L});
    public static final BitSet FOLLOW_14_in_ruleBuiltInNode527 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleASTLeaf_in_entryRuleASTLeaf563 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleASTLeaf573 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleIntLeaf_in_ruleASTLeaf620 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleStringLeaf_in_ruleASTLeaf647 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleFloatLeaf_in_ruleASTLeaf674 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleSymbolLeaf_in_ruleASTLeaf701 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleIntLeaf_in_entryRuleIntLeaf736 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleIntLeaf746 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_15_in_ruleIntLeaf789 = new BitSet(new long[]{0x0000000000000040L});
    public static final BitSet FOLLOW_RULE_INT_in_ruleIntLeaf820 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleStringLeaf_in_entryRuleStringLeaf861 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleStringLeaf871 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RULE_STRING_in_ruleStringLeaf912 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleSymbolLeaf_in_entryRuleSymbolLeaf952 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleSymbolLeaf962 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RULE_ID_in_ruleSymbolLeaf1003 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleFloatLeaf_in_entryRuleFloatLeaf1043 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleFloatLeaf1053 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_15_in_ruleFloatLeaf1096 = new BitSet(new long[]{0x0000000000010040L});
    public static final BitSet FOLLOW_RULE_INT_in_ruleFloatLeaf1129 = new BitSet(new long[]{0x0000000000010000L});
    public static final BitSet FOLLOW_16_in_ruleFloatLeaf1144 = new BitSet(new long[]{0x0000000000000040L});
    public static final BitSet FOLLOW_RULE_INT_in_ruleFloatLeaf1161 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_16_in_ruleFloatLeaf1184 = new BitSet(new long[]{0x0000000000000040L});
    public static final BitSet FOLLOW_RULE_INT_in_ruleFloatLeaf1201 = new BitSet(new long[]{0x0000000000000002L});

}