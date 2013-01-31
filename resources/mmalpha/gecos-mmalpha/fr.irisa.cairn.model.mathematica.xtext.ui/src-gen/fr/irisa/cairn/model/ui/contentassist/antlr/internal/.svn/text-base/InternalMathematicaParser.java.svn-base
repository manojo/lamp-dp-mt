package fr.irisa.cairn.model.ui.contentassist.antlr.internal; 

import java.io.InputStream;
import org.eclipse.xtext.*;
import org.eclipse.xtext.parser.*;
import org.eclipse.xtext.parser.impl.*;
import org.eclipse.xtext.parsetree.*;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.ui.editor.contentassist.antlr.internal.AbstractInternalContentAssistParser;
import org.eclipse.xtext.ui.editor.contentassist.antlr.internal.DFA;
import fr.irisa.cairn.model.services.MathematicaGrammarAccess;



import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

@SuppressWarnings("all")
public class InternalMathematicaParser extends AbstractInternalContentAssistParser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "RULE_ID", "RULE_KEYWORD", "RULE_INT", "RULE_STRING", "RULE_ML_COMMENT", "RULE_SL_COMMENT", "RULE_WS", "RULE_ANY_OTHER", "'['", "']'", "','", "'.'", "'-'"
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
    public String getGrammarFileName() { return "../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g"; }


     
     	private MathematicaGrammarAccess grammarAccess;
     	
        public void setGrammarAccess(MathematicaGrammarAccess grammarAccess) {
        	this.grammarAccess = grammarAccess;
        }
        
        @Override
        protected Grammar getGrammar() {
        	return grammarAccess.getGrammar();
        }
        
        @Override
        protected String getValueForTokenName(String tokenName) {
        	return tokenName;
        }




    // $ANTLR start entryRuleNode
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:61:1: entryRuleNode : ruleNode EOF ;
    public final void entryRuleNode() throws RecognitionException {
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:62:1: ( ruleNode EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:63:1: ruleNode EOF
            {
             before(grammarAccess.getNodeRule()); 
            pushFollow(FOLLOW_ruleNode_in_entryRuleNode61);
            ruleNode();
            _fsp--;

             after(grammarAccess.getNodeRule()); 
            match(input,EOF,FOLLOW_EOF_in_entryRuleNode68); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end entryRuleNode


    // $ANTLR start ruleNode
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:70:1: ruleNode : ( ( rule__Node__Alternatives ) ) ;
    public final void ruleNode() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:74:2: ( ( ( rule__Node__Alternatives ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:75:1: ( ( rule__Node__Alternatives ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:75:1: ( ( rule__Node__Alternatives ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:76:1: ( rule__Node__Alternatives )
            {
             before(grammarAccess.getNodeAccess().getAlternatives()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:77:1: ( rule__Node__Alternatives )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:77:2: rule__Node__Alternatives
            {
            pushFollow(FOLLOW_rule__Node__Alternatives_in_ruleNode94);
            rule__Node__Alternatives();
            _fsp--;


            }

             after(grammarAccess.getNodeAccess().getAlternatives()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end ruleNode


    // $ANTLR start entryRuleASTNode
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:89:1: entryRuleASTNode : ruleASTNode EOF ;
    public final void entryRuleASTNode() throws RecognitionException {
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:90:1: ( ruleASTNode EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:91:1: ruleASTNode EOF
            {
             before(grammarAccess.getASTNodeRule()); 
            pushFollow(FOLLOW_ruleASTNode_in_entryRuleASTNode121);
            ruleASTNode();
            _fsp--;

             after(grammarAccess.getASTNodeRule()); 
            match(input,EOF,FOLLOW_EOF_in_entryRuleASTNode128); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end entryRuleASTNode


    // $ANTLR start ruleASTNode
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:98:1: ruleASTNode : ( ( rule__ASTNode__Group__0 ) ) ;
    public final void ruleASTNode() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:102:2: ( ( ( rule__ASTNode__Group__0 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:103:1: ( ( rule__ASTNode__Group__0 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:103:1: ( ( rule__ASTNode__Group__0 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:104:1: ( rule__ASTNode__Group__0 )
            {
             before(grammarAccess.getASTNodeAccess().getGroup()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:105:1: ( rule__ASTNode__Group__0 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:105:2: rule__ASTNode__Group__0
            {
            pushFollow(FOLLOW_rule__ASTNode__Group__0_in_ruleASTNode154);
            rule__ASTNode__Group__0();
            _fsp--;


            }

             after(grammarAccess.getASTNodeAccess().getGroup()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end ruleASTNode


    // $ANTLR start entryRuleBuiltInNode
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:117:1: entryRuleBuiltInNode : ruleBuiltInNode EOF ;
    public final void entryRuleBuiltInNode() throws RecognitionException {
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:118:1: ( ruleBuiltInNode EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:119:1: ruleBuiltInNode EOF
            {
             before(grammarAccess.getBuiltInNodeRule()); 
            pushFollow(FOLLOW_ruleBuiltInNode_in_entryRuleBuiltInNode181);
            ruleBuiltInNode();
            _fsp--;

             after(grammarAccess.getBuiltInNodeRule()); 
            match(input,EOF,FOLLOW_EOF_in_entryRuleBuiltInNode188); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end entryRuleBuiltInNode


    // $ANTLR start ruleBuiltInNode
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:126:1: ruleBuiltInNode : ( ( rule__BuiltInNode__Group__0 ) ) ;
    public final void ruleBuiltInNode() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:130:2: ( ( ( rule__BuiltInNode__Group__0 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:131:1: ( ( rule__BuiltInNode__Group__0 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:131:1: ( ( rule__BuiltInNode__Group__0 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:132:1: ( rule__BuiltInNode__Group__0 )
            {
             before(grammarAccess.getBuiltInNodeAccess().getGroup()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:133:1: ( rule__BuiltInNode__Group__0 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:133:2: rule__BuiltInNode__Group__0
            {
            pushFollow(FOLLOW_rule__BuiltInNode__Group__0_in_ruleBuiltInNode214);
            rule__BuiltInNode__Group__0();
            _fsp--;


            }

             after(grammarAccess.getBuiltInNodeAccess().getGroup()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end ruleBuiltInNode


    // $ANTLR start entryRuleASTLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:145:1: entryRuleASTLeaf : ruleASTLeaf EOF ;
    public final void entryRuleASTLeaf() throws RecognitionException {
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:146:1: ( ruleASTLeaf EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:147:1: ruleASTLeaf EOF
            {
             before(grammarAccess.getASTLeafRule()); 
            pushFollow(FOLLOW_ruleASTLeaf_in_entryRuleASTLeaf241);
            ruleASTLeaf();
            _fsp--;

             after(grammarAccess.getASTLeafRule()); 
            match(input,EOF,FOLLOW_EOF_in_entryRuleASTLeaf248); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end entryRuleASTLeaf


    // $ANTLR start ruleASTLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:154:1: ruleASTLeaf : ( ( rule__ASTLeaf__Alternatives ) ) ;
    public final void ruleASTLeaf() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:158:2: ( ( ( rule__ASTLeaf__Alternatives ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:159:1: ( ( rule__ASTLeaf__Alternatives ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:159:1: ( ( rule__ASTLeaf__Alternatives ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:160:1: ( rule__ASTLeaf__Alternatives )
            {
             before(grammarAccess.getASTLeafAccess().getAlternatives()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:161:1: ( rule__ASTLeaf__Alternatives )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:161:2: rule__ASTLeaf__Alternatives
            {
            pushFollow(FOLLOW_rule__ASTLeaf__Alternatives_in_ruleASTLeaf274);
            rule__ASTLeaf__Alternatives();
            _fsp--;


            }

             after(grammarAccess.getASTLeafAccess().getAlternatives()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end ruleASTLeaf


    // $ANTLR start entryRuleIntLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:173:1: entryRuleIntLeaf : ruleIntLeaf EOF ;
    public final void entryRuleIntLeaf() throws RecognitionException {
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:174:1: ( ruleIntLeaf EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:175:1: ruleIntLeaf EOF
            {
             before(grammarAccess.getIntLeafRule()); 
            pushFollow(FOLLOW_ruleIntLeaf_in_entryRuleIntLeaf301);
            ruleIntLeaf();
            _fsp--;

             after(grammarAccess.getIntLeafRule()); 
            match(input,EOF,FOLLOW_EOF_in_entryRuleIntLeaf308); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end entryRuleIntLeaf


    // $ANTLR start ruleIntLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:182:1: ruleIntLeaf : ( ( rule__IntLeaf__Group__0 ) ) ;
    public final void ruleIntLeaf() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:186:2: ( ( ( rule__IntLeaf__Group__0 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:187:1: ( ( rule__IntLeaf__Group__0 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:187:1: ( ( rule__IntLeaf__Group__0 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:188:1: ( rule__IntLeaf__Group__0 )
            {
             before(grammarAccess.getIntLeafAccess().getGroup()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:189:1: ( rule__IntLeaf__Group__0 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:189:2: rule__IntLeaf__Group__0
            {
            pushFollow(FOLLOW_rule__IntLeaf__Group__0_in_ruleIntLeaf334);
            rule__IntLeaf__Group__0();
            _fsp--;


            }

             after(grammarAccess.getIntLeafAccess().getGroup()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end ruleIntLeaf


    // $ANTLR start entryRuleStringLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:201:1: entryRuleStringLeaf : ruleStringLeaf EOF ;
    public final void entryRuleStringLeaf() throws RecognitionException {
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:202:1: ( ruleStringLeaf EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:203:1: ruleStringLeaf EOF
            {
             before(grammarAccess.getStringLeafRule()); 
            pushFollow(FOLLOW_ruleStringLeaf_in_entryRuleStringLeaf361);
            ruleStringLeaf();
            _fsp--;

             after(grammarAccess.getStringLeafRule()); 
            match(input,EOF,FOLLOW_EOF_in_entryRuleStringLeaf368); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end entryRuleStringLeaf


    // $ANTLR start ruleStringLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:210:1: ruleStringLeaf : ( ( rule__StringLeaf__ValueAssignment ) ) ;
    public final void ruleStringLeaf() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:214:2: ( ( ( rule__StringLeaf__ValueAssignment ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:215:1: ( ( rule__StringLeaf__ValueAssignment ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:215:1: ( ( rule__StringLeaf__ValueAssignment ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:216:1: ( rule__StringLeaf__ValueAssignment )
            {
             before(grammarAccess.getStringLeafAccess().getValueAssignment()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:217:1: ( rule__StringLeaf__ValueAssignment )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:217:2: rule__StringLeaf__ValueAssignment
            {
            pushFollow(FOLLOW_rule__StringLeaf__ValueAssignment_in_ruleStringLeaf394);
            rule__StringLeaf__ValueAssignment();
            _fsp--;


            }

             after(grammarAccess.getStringLeafAccess().getValueAssignment()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end ruleStringLeaf


    // $ANTLR start entryRuleSymbolLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:229:1: entryRuleSymbolLeaf : ruleSymbolLeaf EOF ;
    public final void entryRuleSymbolLeaf() throws RecognitionException {
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:230:1: ( ruleSymbolLeaf EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:231:1: ruleSymbolLeaf EOF
            {
             before(grammarAccess.getSymbolLeafRule()); 
            pushFollow(FOLLOW_ruleSymbolLeaf_in_entryRuleSymbolLeaf421);
            ruleSymbolLeaf();
            _fsp--;

             after(grammarAccess.getSymbolLeafRule()); 
            match(input,EOF,FOLLOW_EOF_in_entryRuleSymbolLeaf428); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end entryRuleSymbolLeaf


    // $ANTLR start ruleSymbolLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:238:1: ruleSymbolLeaf : ( ( rule__SymbolLeaf__NameAssignment ) ) ;
    public final void ruleSymbolLeaf() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:242:2: ( ( ( rule__SymbolLeaf__NameAssignment ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:243:1: ( ( rule__SymbolLeaf__NameAssignment ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:243:1: ( ( rule__SymbolLeaf__NameAssignment ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:244:1: ( rule__SymbolLeaf__NameAssignment )
            {
             before(grammarAccess.getSymbolLeafAccess().getNameAssignment()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:245:1: ( rule__SymbolLeaf__NameAssignment )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:245:2: rule__SymbolLeaf__NameAssignment
            {
            pushFollow(FOLLOW_rule__SymbolLeaf__NameAssignment_in_ruleSymbolLeaf454);
            rule__SymbolLeaf__NameAssignment();
            _fsp--;


            }

             after(grammarAccess.getSymbolLeafAccess().getNameAssignment()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end ruleSymbolLeaf


    // $ANTLR start entryRuleFloatLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:257:1: entryRuleFloatLeaf : ruleFloatLeaf EOF ;
    public final void entryRuleFloatLeaf() throws RecognitionException {
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:258:1: ( ruleFloatLeaf EOF )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:259:1: ruleFloatLeaf EOF
            {
             before(grammarAccess.getFloatLeafRule()); 
            pushFollow(FOLLOW_ruleFloatLeaf_in_entryRuleFloatLeaf481);
            ruleFloatLeaf();
            _fsp--;

             after(grammarAccess.getFloatLeafRule()); 
            match(input,EOF,FOLLOW_EOF_in_entryRuleFloatLeaf488); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end entryRuleFloatLeaf


    // $ANTLR start ruleFloatLeaf
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:266:1: ruleFloatLeaf : ( ( rule__FloatLeaf__Group__0 ) ) ;
    public final void ruleFloatLeaf() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:270:2: ( ( ( rule__FloatLeaf__Group__0 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:271:1: ( ( rule__FloatLeaf__Group__0 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:271:1: ( ( rule__FloatLeaf__Group__0 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:272:1: ( rule__FloatLeaf__Group__0 )
            {
             before(grammarAccess.getFloatLeafAccess().getGroup()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:273:1: ( rule__FloatLeaf__Group__0 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:273:2: rule__FloatLeaf__Group__0
            {
            pushFollow(FOLLOW_rule__FloatLeaf__Group__0_in_ruleFloatLeaf514);
            rule__FloatLeaf__Group__0();
            _fsp--;


            }

             after(grammarAccess.getFloatLeafAccess().getGroup()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end ruleFloatLeaf


    // $ANTLR start rule__Node__Alternatives
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:285:1: rule__Node__Alternatives : ( ( ruleASTNode ) | ( ruleASTLeaf ) | ( ruleBuiltInNode ) );
    public final void rule__Node__Alternatives() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:289:1: ( ( ruleASTNode ) | ( ruleASTLeaf ) | ( ruleBuiltInNode ) )
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
                        new NoViableAltException("285:1: rule__Node__Alternatives : ( ( ruleASTNode ) | ( ruleASTLeaf ) | ( ruleBuiltInNode ) );", 1, 1, input);

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
                    new NoViableAltException("285:1: rule__Node__Alternatives : ( ( ruleASTNode ) | ( ruleASTLeaf ) | ( ruleBuiltInNode ) );", 1, 0, input);

                throw nvae;
            }

            switch (alt1) {
                case 1 :
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:290:1: ( ruleASTNode )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:290:1: ( ruleASTNode )
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:291:1: ruleASTNode
                    {
                     before(grammarAccess.getNodeAccess().getASTNodeParserRuleCall_0()); 
                    pushFollow(FOLLOW_ruleASTNode_in_rule__Node__Alternatives550);
                    ruleASTNode();
                    _fsp--;

                     after(grammarAccess.getNodeAccess().getASTNodeParserRuleCall_0()); 

                    }


                    }
                    break;
                case 2 :
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:296:6: ( ruleASTLeaf )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:296:6: ( ruleASTLeaf )
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:297:1: ruleASTLeaf
                    {
                     before(grammarAccess.getNodeAccess().getASTLeafParserRuleCall_1()); 
                    pushFollow(FOLLOW_ruleASTLeaf_in_rule__Node__Alternatives567);
                    ruleASTLeaf();
                    _fsp--;

                     after(grammarAccess.getNodeAccess().getASTLeafParserRuleCall_1()); 

                    }


                    }
                    break;
                case 3 :
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:302:6: ( ruleBuiltInNode )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:302:6: ( ruleBuiltInNode )
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:303:1: ruleBuiltInNode
                    {
                     before(grammarAccess.getNodeAccess().getBuiltInNodeParserRuleCall_2()); 
                    pushFollow(FOLLOW_ruleBuiltInNode_in_rule__Node__Alternatives584);
                    ruleBuiltInNode();
                    _fsp--;

                     after(grammarAccess.getNodeAccess().getBuiltInNodeParserRuleCall_2()); 

                    }


                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__Node__Alternatives


    // $ANTLR start rule__ASTLeaf__Alternatives
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:313:1: rule__ASTLeaf__Alternatives : ( ( ruleIntLeaf ) | ( ruleStringLeaf ) | ( ruleFloatLeaf ) | ( ruleSymbolLeaf ) );
    public final void rule__ASTLeaf__Alternatives() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:317:1: ( ( ruleIntLeaf ) | ( ruleStringLeaf ) | ( ruleFloatLeaf ) | ( ruleSymbolLeaf ) )
            int alt2=4;
            switch ( input.LA(1) ) {
            case 16:
                {
                int LA2_1 = input.LA(2);

                if ( (LA2_1==RULE_INT) ) {
                    int LA2_2 = input.LA(3);

                    if ( (LA2_2==15) ) {
                        alt2=3;
                    }
                    else if ( (LA2_2==EOF||(LA2_2>=13 && LA2_2<=14)) ) {
                        alt2=1;
                    }
                    else {
                        NoViableAltException nvae =
                            new NoViableAltException("313:1: rule__ASTLeaf__Alternatives : ( ( ruleIntLeaf ) | ( ruleStringLeaf ) | ( ruleFloatLeaf ) | ( ruleSymbolLeaf ) );", 2, 2, input);

                        throw nvae;
                    }
                }
                else if ( (LA2_1==15) ) {
                    alt2=3;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("313:1: rule__ASTLeaf__Alternatives : ( ( ruleIntLeaf ) | ( ruleStringLeaf ) | ( ruleFloatLeaf ) | ( ruleSymbolLeaf ) );", 2, 1, input);

                    throw nvae;
                }
                }
                break;
            case RULE_INT:
                {
                int LA2_2 = input.LA(2);

                if ( (LA2_2==15) ) {
                    alt2=3;
                }
                else if ( (LA2_2==EOF||(LA2_2>=13 && LA2_2<=14)) ) {
                    alt2=1;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("313:1: rule__ASTLeaf__Alternatives : ( ( ruleIntLeaf ) | ( ruleStringLeaf ) | ( ruleFloatLeaf ) | ( ruleSymbolLeaf ) );", 2, 2, input);

                    throw nvae;
                }
                }
                break;
            case RULE_STRING:
                {
                alt2=2;
                }
                break;
            case 15:
                {
                alt2=3;
                }
                break;
            case RULE_ID:
                {
                alt2=4;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("313:1: rule__ASTLeaf__Alternatives : ( ( ruleIntLeaf ) | ( ruleStringLeaf ) | ( ruleFloatLeaf ) | ( ruleSymbolLeaf ) );", 2, 0, input);

                throw nvae;
            }

            switch (alt2) {
                case 1 :
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:318:1: ( ruleIntLeaf )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:318:1: ( ruleIntLeaf )
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:319:1: ruleIntLeaf
                    {
                     before(grammarAccess.getASTLeafAccess().getIntLeafParserRuleCall_0()); 
                    pushFollow(FOLLOW_ruleIntLeaf_in_rule__ASTLeaf__Alternatives616);
                    ruleIntLeaf();
                    _fsp--;

                     after(grammarAccess.getASTLeafAccess().getIntLeafParserRuleCall_0()); 

                    }


                    }
                    break;
                case 2 :
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:324:6: ( ruleStringLeaf )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:324:6: ( ruleStringLeaf )
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:325:1: ruleStringLeaf
                    {
                     before(grammarAccess.getASTLeafAccess().getStringLeafParserRuleCall_1()); 
                    pushFollow(FOLLOW_ruleStringLeaf_in_rule__ASTLeaf__Alternatives633);
                    ruleStringLeaf();
                    _fsp--;

                     after(grammarAccess.getASTLeafAccess().getStringLeafParserRuleCall_1()); 

                    }


                    }
                    break;
                case 3 :
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:330:6: ( ruleFloatLeaf )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:330:6: ( ruleFloatLeaf )
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:331:1: ruleFloatLeaf
                    {
                     before(grammarAccess.getASTLeafAccess().getFloatLeafParserRuleCall_2()); 
                    pushFollow(FOLLOW_ruleFloatLeaf_in_rule__ASTLeaf__Alternatives650);
                    ruleFloatLeaf();
                    _fsp--;

                     after(grammarAccess.getASTLeafAccess().getFloatLeafParserRuleCall_2()); 

                    }


                    }
                    break;
                case 4 :
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:336:6: ( ruleSymbolLeaf )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:336:6: ( ruleSymbolLeaf )
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:337:1: ruleSymbolLeaf
                    {
                     before(grammarAccess.getASTLeafAccess().getSymbolLeafParserRuleCall_3()); 
                    pushFollow(FOLLOW_ruleSymbolLeaf_in_rule__ASTLeaf__Alternatives667);
                    ruleSymbolLeaf();
                    _fsp--;

                     after(grammarAccess.getASTLeafAccess().getSymbolLeafParserRuleCall_3()); 

                    }


                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTLeaf__Alternatives


    // $ANTLR start rule__FloatLeaf__Alternatives_1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:347:1: rule__FloatLeaf__Alternatives_1 : ( ( ( rule__FloatLeaf__Group_1_0__0 ) ) | ( ( rule__FloatLeaf__Group_1_1__0 ) ) );
    public final void rule__FloatLeaf__Alternatives_1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:351:1: ( ( ( rule__FloatLeaf__Group_1_0__0 ) ) | ( ( rule__FloatLeaf__Group_1_1__0 ) ) )
            int alt3=2;
            int LA3_0 = input.LA(1);

            if ( (LA3_0==RULE_INT) ) {
                alt3=1;
            }
            else if ( (LA3_0==15) ) {
                alt3=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("347:1: rule__FloatLeaf__Alternatives_1 : ( ( ( rule__FloatLeaf__Group_1_0__0 ) ) | ( ( rule__FloatLeaf__Group_1_1__0 ) ) );", 3, 0, input);

                throw nvae;
            }
            switch (alt3) {
                case 1 :
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:352:1: ( ( rule__FloatLeaf__Group_1_0__0 ) )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:352:1: ( ( rule__FloatLeaf__Group_1_0__0 ) )
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:353:1: ( rule__FloatLeaf__Group_1_0__0 )
                    {
                     before(grammarAccess.getFloatLeafAccess().getGroup_1_0()); 
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:354:1: ( rule__FloatLeaf__Group_1_0__0 )
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:354:2: rule__FloatLeaf__Group_1_0__0
                    {
                    pushFollow(FOLLOW_rule__FloatLeaf__Group_1_0__0_in_rule__FloatLeaf__Alternatives_1699);
                    rule__FloatLeaf__Group_1_0__0();
                    _fsp--;


                    }

                     after(grammarAccess.getFloatLeafAccess().getGroup_1_0()); 

                    }


                    }
                    break;
                case 2 :
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:358:6: ( ( rule__FloatLeaf__Group_1_1__0 ) )
                    {
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:358:6: ( ( rule__FloatLeaf__Group_1_1__0 ) )
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:359:1: ( rule__FloatLeaf__Group_1_1__0 )
                    {
                     before(grammarAccess.getFloatLeafAccess().getGroup_1_1()); 
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:360:1: ( rule__FloatLeaf__Group_1_1__0 )
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:360:2: rule__FloatLeaf__Group_1_1__0
                    {
                    pushFollow(FOLLOW_rule__FloatLeaf__Group_1_1__0_in_rule__FloatLeaf__Alternatives_1717);
                    rule__FloatLeaf__Group_1_1__0();
                    _fsp--;


                    }

                     after(grammarAccess.getFloatLeafAccess().getGroup_1_1()); 

                    }


                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Alternatives_1


    // $ANTLR start rule__ASTNode__Group__0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:371:1: rule__ASTNode__Group__0 : rule__ASTNode__Group__0__Impl rule__ASTNode__Group__1 ;
    public final void rule__ASTNode__Group__0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:375:1: ( rule__ASTNode__Group__0__Impl rule__ASTNode__Group__1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:376:2: rule__ASTNode__Group__0__Impl rule__ASTNode__Group__1
            {
            pushFollow(FOLLOW_rule__ASTNode__Group__0__Impl_in_rule__ASTNode__Group__0748);
            rule__ASTNode__Group__0__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__ASTNode__Group__1_in_rule__ASTNode__Group__0751);
            rule__ASTNode__Group__1();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group__0


    // $ANTLR start rule__ASTNode__Group__0__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:383:1: rule__ASTNode__Group__0__Impl : ( ( rule__ASTNode__NameAssignment_0 ) ) ;
    public final void rule__ASTNode__Group__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:387:1: ( ( ( rule__ASTNode__NameAssignment_0 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:388:1: ( ( rule__ASTNode__NameAssignment_0 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:388:1: ( ( rule__ASTNode__NameAssignment_0 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:389:1: ( rule__ASTNode__NameAssignment_0 )
            {
             before(grammarAccess.getASTNodeAccess().getNameAssignment_0()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:390:1: ( rule__ASTNode__NameAssignment_0 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:390:2: rule__ASTNode__NameAssignment_0
            {
            pushFollow(FOLLOW_rule__ASTNode__NameAssignment_0_in_rule__ASTNode__Group__0__Impl778);
            rule__ASTNode__NameAssignment_0();
            _fsp--;


            }

             after(grammarAccess.getASTNodeAccess().getNameAssignment_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group__0__Impl


    // $ANTLR start rule__ASTNode__Group__1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:400:1: rule__ASTNode__Group__1 : rule__ASTNode__Group__1__Impl rule__ASTNode__Group__2 ;
    public final void rule__ASTNode__Group__1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:404:1: ( rule__ASTNode__Group__1__Impl rule__ASTNode__Group__2 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:405:2: rule__ASTNode__Group__1__Impl rule__ASTNode__Group__2
            {
            pushFollow(FOLLOW_rule__ASTNode__Group__1__Impl_in_rule__ASTNode__Group__1808);
            rule__ASTNode__Group__1__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__ASTNode__Group__2_in_rule__ASTNode__Group__1811);
            rule__ASTNode__Group__2();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group__1


    // $ANTLR start rule__ASTNode__Group__1__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:412:1: rule__ASTNode__Group__1__Impl : ( '[' ) ;
    public final void rule__ASTNode__Group__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:416:1: ( ( '[' ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:417:1: ( '[' )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:417:1: ( '[' )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:418:1: '['
            {
             before(grammarAccess.getASTNodeAccess().getLeftSquareBracketKeyword_1()); 
            match(input,12,FOLLOW_12_in_rule__ASTNode__Group__1__Impl839); 
             after(grammarAccess.getASTNodeAccess().getLeftSquareBracketKeyword_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group__1__Impl


    // $ANTLR start rule__ASTNode__Group__2
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:431:1: rule__ASTNode__Group__2 : rule__ASTNode__Group__2__Impl rule__ASTNode__Group__3 ;
    public final void rule__ASTNode__Group__2() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:435:1: ( rule__ASTNode__Group__2__Impl rule__ASTNode__Group__3 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:436:2: rule__ASTNode__Group__2__Impl rule__ASTNode__Group__3
            {
            pushFollow(FOLLOW_rule__ASTNode__Group__2__Impl_in_rule__ASTNode__Group__2870);
            rule__ASTNode__Group__2__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__ASTNode__Group__3_in_rule__ASTNode__Group__2873);
            rule__ASTNode__Group__3();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group__2


    // $ANTLR start rule__ASTNode__Group__2__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:443:1: rule__ASTNode__Group__2__Impl : ( ( rule__ASTNode__Group_2__0 )? ) ;
    public final void rule__ASTNode__Group__2__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:447:1: ( ( ( rule__ASTNode__Group_2__0 )? ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:448:1: ( ( rule__ASTNode__Group_2__0 )? )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:448:1: ( ( rule__ASTNode__Group_2__0 )? )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:449:1: ( rule__ASTNode__Group_2__0 )?
            {
             before(grammarAccess.getASTNodeAccess().getGroup_2()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:450:1: ( rule__ASTNode__Group_2__0 )?
            int alt4=2;
            int LA4_0 = input.LA(1);

            if ( ((LA4_0>=RULE_ID && LA4_0<=RULE_STRING)||(LA4_0>=15 && LA4_0<=16)) ) {
                alt4=1;
            }
            switch (alt4) {
                case 1 :
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:450:2: rule__ASTNode__Group_2__0
                    {
                    pushFollow(FOLLOW_rule__ASTNode__Group_2__0_in_rule__ASTNode__Group__2__Impl900);
                    rule__ASTNode__Group_2__0();
                    _fsp--;


                    }
                    break;

            }

             after(grammarAccess.getASTNodeAccess().getGroup_2()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group__2__Impl


    // $ANTLR start rule__ASTNode__Group__3
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:460:1: rule__ASTNode__Group__3 : rule__ASTNode__Group__3__Impl ;
    public final void rule__ASTNode__Group__3() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:464:1: ( rule__ASTNode__Group__3__Impl )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:465:2: rule__ASTNode__Group__3__Impl
            {
            pushFollow(FOLLOW_rule__ASTNode__Group__3__Impl_in_rule__ASTNode__Group__3931);
            rule__ASTNode__Group__3__Impl();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group__3


    // $ANTLR start rule__ASTNode__Group__3__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:471:1: rule__ASTNode__Group__3__Impl : ( ']' ) ;
    public final void rule__ASTNode__Group__3__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:475:1: ( ( ']' ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:476:1: ( ']' )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:476:1: ( ']' )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:477:1: ']'
            {
             before(grammarAccess.getASTNodeAccess().getRightSquareBracketKeyword_3()); 
            match(input,13,FOLLOW_13_in_rule__ASTNode__Group__3__Impl959); 
             after(grammarAccess.getASTNodeAccess().getRightSquareBracketKeyword_3()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group__3__Impl


    // $ANTLR start rule__ASTNode__Group_2__0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:498:1: rule__ASTNode__Group_2__0 : rule__ASTNode__Group_2__0__Impl rule__ASTNode__Group_2__1 ;
    public final void rule__ASTNode__Group_2__0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:502:1: ( rule__ASTNode__Group_2__0__Impl rule__ASTNode__Group_2__1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:503:2: rule__ASTNode__Group_2__0__Impl rule__ASTNode__Group_2__1
            {
            pushFollow(FOLLOW_rule__ASTNode__Group_2__0__Impl_in_rule__ASTNode__Group_2__0998);
            rule__ASTNode__Group_2__0__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__ASTNode__Group_2__1_in_rule__ASTNode__Group_2__01001);
            rule__ASTNode__Group_2__1();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group_2__0


    // $ANTLR start rule__ASTNode__Group_2__0__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:510:1: rule__ASTNode__Group_2__0__Impl : ( ( rule__ASTNode__ChildrenAssignment_2_0 ) ) ;
    public final void rule__ASTNode__Group_2__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:514:1: ( ( ( rule__ASTNode__ChildrenAssignment_2_0 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:515:1: ( ( rule__ASTNode__ChildrenAssignment_2_0 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:515:1: ( ( rule__ASTNode__ChildrenAssignment_2_0 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:516:1: ( rule__ASTNode__ChildrenAssignment_2_0 )
            {
             before(grammarAccess.getASTNodeAccess().getChildrenAssignment_2_0()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:517:1: ( rule__ASTNode__ChildrenAssignment_2_0 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:517:2: rule__ASTNode__ChildrenAssignment_2_0
            {
            pushFollow(FOLLOW_rule__ASTNode__ChildrenAssignment_2_0_in_rule__ASTNode__Group_2__0__Impl1028);
            rule__ASTNode__ChildrenAssignment_2_0();
            _fsp--;


            }

             after(grammarAccess.getASTNodeAccess().getChildrenAssignment_2_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group_2__0__Impl


    // $ANTLR start rule__ASTNode__Group_2__1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:527:1: rule__ASTNode__Group_2__1 : rule__ASTNode__Group_2__1__Impl ;
    public final void rule__ASTNode__Group_2__1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:531:1: ( rule__ASTNode__Group_2__1__Impl )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:532:2: rule__ASTNode__Group_2__1__Impl
            {
            pushFollow(FOLLOW_rule__ASTNode__Group_2__1__Impl_in_rule__ASTNode__Group_2__11058);
            rule__ASTNode__Group_2__1__Impl();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group_2__1


    // $ANTLR start rule__ASTNode__Group_2__1__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:538:1: rule__ASTNode__Group_2__1__Impl : ( ( rule__ASTNode__Group_2_1__0 )* ) ;
    public final void rule__ASTNode__Group_2__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:542:1: ( ( ( rule__ASTNode__Group_2_1__0 )* ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:543:1: ( ( rule__ASTNode__Group_2_1__0 )* )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:543:1: ( ( rule__ASTNode__Group_2_1__0 )* )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:544:1: ( rule__ASTNode__Group_2_1__0 )*
            {
             before(grammarAccess.getASTNodeAccess().getGroup_2_1()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:545:1: ( rule__ASTNode__Group_2_1__0 )*
            loop5:
            do {
                int alt5=2;
                int LA5_0 = input.LA(1);

                if ( (LA5_0==14) ) {
                    alt5=1;
                }


                switch (alt5) {
            	case 1 :
            	    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:545:2: rule__ASTNode__Group_2_1__0
            	    {
            	    pushFollow(FOLLOW_rule__ASTNode__Group_2_1__0_in_rule__ASTNode__Group_2__1__Impl1085);
            	    rule__ASTNode__Group_2_1__0();
            	    _fsp--;


            	    }
            	    break;

            	default :
            	    break loop5;
                }
            } while (true);

             after(grammarAccess.getASTNodeAccess().getGroup_2_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group_2__1__Impl


    // $ANTLR start rule__ASTNode__Group_2_1__0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:559:1: rule__ASTNode__Group_2_1__0 : rule__ASTNode__Group_2_1__0__Impl rule__ASTNode__Group_2_1__1 ;
    public final void rule__ASTNode__Group_2_1__0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:563:1: ( rule__ASTNode__Group_2_1__0__Impl rule__ASTNode__Group_2_1__1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:564:2: rule__ASTNode__Group_2_1__0__Impl rule__ASTNode__Group_2_1__1
            {
            pushFollow(FOLLOW_rule__ASTNode__Group_2_1__0__Impl_in_rule__ASTNode__Group_2_1__01120);
            rule__ASTNode__Group_2_1__0__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__ASTNode__Group_2_1__1_in_rule__ASTNode__Group_2_1__01123);
            rule__ASTNode__Group_2_1__1();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group_2_1__0


    // $ANTLR start rule__ASTNode__Group_2_1__0__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:571:1: rule__ASTNode__Group_2_1__0__Impl : ( ',' ) ;
    public final void rule__ASTNode__Group_2_1__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:575:1: ( ( ',' ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:576:1: ( ',' )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:576:1: ( ',' )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:577:1: ','
            {
             before(grammarAccess.getASTNodeAccess().getCommaKeyword_2_1_0()); 
            match(input,14,FOLLOW_14_in_rule__ASTNode__Group_2_1__0__Impl1151); 
             after(grammarAccess.getASTNodeAccess().getCommaKeyword_2_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group_2_1__0__Impl


    // $ANTLR start rule__ASTNode__Group_2_1__1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:590:1: rule__ASTNode__Group_2_1__1 : rule__ASTNode__Group_2_1__1__Impl ;
    public final void rule__ASTNode__Group_2_1__1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:594:1: ( rule__ASTNode__Group_2_1__1__Impl )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:595:2: rule__ASTNode__Group_2_1__1__Impl
            {
            pushFollow(FOLLOW_rule__ASTNode__Group_2_1__1__Impl_in_rule__ASTNode__Group_2_1__11182);
            rule__ASTNode__Group_2_1__1__Impl();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group_2_1__1


    // $ANTLR start rule__ASTNode__Group_2_1__1__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:601:1: rule__ASTNode__Group_2_1__1__Impl : ( ( rule__ASTNode__ChildrenAssignment_2_1_1 ) ) ;
    public final void rule__ASTNode__Group_2_1__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:605:1: ( ( ( rule__ASTNode__ChildrenAssignment_2_1_1 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:606:1: ( ( rule__ASTNode__ChildrenAssignment_2_1_1 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:606:1: ( ( rule__ASTNode__ChildrenAssignment_2_1_1 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:607:1: ( rule__ASTNode__ChildrenAssignment_2_1_1 )
            {
             before(grammarAccess.getASTNodeAccess().getChildrenAssignment_2_1_1()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:608:1: ( rule__ASTNode__ChildrenAssignment_2_1_1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:608:2: rule__ASTNode__ChildrenAssignment_2_1_1
            {
            pushFollow(FOLLOW_rule__ASTNode__ChildrenAssignment_2_1_1_in_rule__ASTNode__Group_2_1__1__Impl1209);
            rule__ASTNode__ChildrenAssignment_2_1_1();
            _fsp--;


            }

             after(grammarAccess.getASTNodeAccess().getChildrenAssignment_2_1_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__Group_2_1__1__Impl


    // $ANTLR start rule__BuiltInNode__Group__0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:622:1: rule__BuiltInNode__Group__0 : rule__BuiltInNode__Group__0__Impl rule__BuiltInNode__Group__1 ;
    public final void rule__BuiltInNode__Group__0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:626:1: ( rule__BuiltInNode__Group__0__Impl rule__BuiltInNode__Group__1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:627:2: rule__BuiltInNode__Group__0__Impl rule__BuiltInNode__Group__1
            {
            pushFollow(FOLLOW_rule__BuiltInNode__Group__0__Impl_in_rule__BuiltInNode__Group__01243);
            rule__BuiltInNode__Group__0__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__BuiltInNode__Group__1_in_rule__BuiltInNode__Group__01246);
            rule__BuiltInNode__Group__1();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group__0


    // $ANTLR start rule__BuiltInNode__Group__0__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:634:1: rule__BuiltInNode__Group__0__Impl : ( ( rule__BuiltInNode__KeywordAssignment_0 ) ) ;
    public final void rule__BuiltInNode__Group__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:638:1: ( ( ( rule__BuiltInNode__KeywordAssignment_0 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:639:1: ( ( rule__BuiltInNode__KeywordAssignment_0 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:639:1: ( ( rule__BuiltInNode__KeywordAssignment_0 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:640:1: ( rule__BuiltInNode__KeywordAssignment_0 )
            {
             before(grammarAccess.getBuiltInNodeAccess().getKeywordAssignment_0()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:641:1: ( rule__BuiltInNode__KeywordAssignment_0 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:641:2: rule__BuiltInNode__KeywordAssignment_0
            {
            pushFollow(FOLLOW_rule__BuiltInNode__KeywordAssignment_0_in_rule__BuiltInNode__Group__0__Impl1273);
            rule__BuiltInNode__KeywordAssignment_0();
            _fsp--;


            }

             after(grammarAccess.getBuiltInNodeAccess().getKeywordAssignment_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group__0__Impl


    // $ANTLR start rule__BuiltInNode__Group__1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:651:1: rule__BuiltInNode__Group__1 : rule__BuiltInNode__Group__1__Impl rule__BuiltInNode__Group__2 ;
    public final void rule__BuiltInNode__Group__1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:655:1: ( rule__BuiltInNode__Group__1__Impl rule__BuiltInNode__Group__2 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:656:2: rule__BuiltInNode__Group__1__Impl rule__BuiltInNode__Group__2
            {
            pushFollow(FOLLOW_rule__BuiltInNode__Group__1__Impl_in_rule__BuiltInNode__Group__11303);
            rule__BuiltInNode__Group__1__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__BuiltInNode__Group__2_in_rule__BuiltInNode__Group__11306);
            rule__BuiltInNode__Group__2();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group__1


    // $ANTLR start rule__BuiltInNode__Group__1__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:663:1: rule__BuiltInNode__Group__1__Impl : ( '[' ) ;
    public final void rule__BuiltInNode__Group__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:667:1: ( ( '[' ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:668:1: ( '[' )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:668:1: ( '[' )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:669:1: '['
            {
             before(grammarAccess.getBuiltInNodeAccess().getLeftSquareBracketKeyword_1()); 
            match(input,12,FOLLOW_12_in_rule__BuiltInNode__Group__1__Impl1334); 
             after(grammarAccess.getBuiltInNodeAccess().getLeftSquareBracketKeyword_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group__1__Impl


    // $ANTLR start rule__BuiltInNode__Group__2
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:682:1: rule__BuiltInNode__Group__2 : rule__BuiltInNode__Group__2__Impl rule__BuiltInNode__Group__3 ;
    public final void rule__BuiltInNode__Group__2() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:686:1: ( rule__BuiltInNode__Group__2__Impl rule__BuiltInNode__Group__3 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:687:2: rule__BuiltInNode__Group__2__Impl rule__BuiltInNode__Group__3
            {
            pushFollow(FOLLOW_rule__BuiltInNode__Group__2__Impl_in_rule__BuiltInNode__Group__21365);
            rule__BuiltInNode__Group__2__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__BuiltInNode__Group__3_in_rule__BuiltInNode__Group__21368);
            rule__BuiltInNode__Group__3();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group__2


    // $ANTLR start rule__BuiltInNode__Group__2__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:694:1: rule__BuiltInNode__Group__2__Impl : ( ( rule__BuiltInNode__Group_2__0 )? ) ;
    public final void rule__BuiltInNode__Group__2__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:698:1: ( ( ( rule__BuiltInNode__Group_2__0 )? ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:699:1: ( ( rule__BuiltInNode__Group_2__0 )? )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:699:1: ( ( rule__BuiltInNode__Group_2__0 )? )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:700:1: ( rule__BuiltInNode__Group_2__0 )?
            {
             before(grammarAccess.getBuiltInNodeAccess().getGroup_2()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:701:1: ( rule__BuiltInNode__Group_2__0 )?
            int alt6=2;
            int LA6_0 = input.LA(1);

            if ( ((LA6_0>=RULE_ID && LA6_0<=RULE_STRING)||(LA6_0>=15 && LA6_0<=16)) ) {
                alt6=1;
            }
            switch (alt6) {
                case 1 :
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:701:2: rule__BuiltInNode__Group_2__0
                    {
                    pushFollow(FOLLOW_rule__BuiltInNode__Group_2__0_in_rule__BuiltInNode__Group__2__Impl1395);
                    rule__BuiltInNode__Group_2__0();
                    _fsp--;


                    }
                    break;

            }

             after(grammarAccess.getBuiltInNodeAccess().getGroup_2()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group__2__Impl


    // $ANTLR start rule__BuiltInNode__Group__3
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:711:1: rule__BuiltInNode__Group__3 : rule__BuiltInNode__Group__3__Impl ;
    public final void rule__BuiltInNode__Group__3() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:715:1: ( rule__BuiltInNode__Group__3__Impl )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:716:2: rule__BuiltInNode__Group__3__Impl
            {
            pushFollow(FOLLOW_rule__BuiltInNode__Group__3__Impl_in_rule__BuiltInNode__Group__31426);
            rule__BuiltInNode__Group__3__Impl();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group__3


    // $ANTLR start rule__BuiltInNode__Group__3__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:722:1: rule__BuiltInNode__Group__3__Impl : ( ']' ) ;
    public final void rule__BuiltInNode__Group__3__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:726:1: ( ( ']' ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:727:1: ( ']' )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:727:1: ( ']' )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:728:1: ']'
            {
             before(grammarAccess.getBuiltInNodeAccess().getRightSquareBracketKeyword_3()); 
            match(input,13,FOLLOW_13_in_rule__BuiltInNode__Group__3__Impl1454); 
             after(grammarAccess.getBuiltInNodeAccess().getRightSquareBracketKeyword_3()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group__3__Impl


    // $ANTLR start rule__BuiltInNode__Group_2__0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:749:1: rule__BuiltInNode__Group_2__0 : rule__BuiltInNode__Group_2__0__Impl rule__BuiltInNode__Group_2__1 ;
    public final void rule__BuiltInNode__Group_2__0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:753:1: ( rule__BuiltInNode__Group_2__0__Impl rule__BuiltInNode__Group_2__1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:754:2: rule__BuiltInNode__Group_2__0__Impl rule__BuiltInNode__Group_2__1
            {
            pushFollow(FOLLOW_rule__BuiltInNode__Group_2__0__Impl_in_rule__BuiltInNode__Group_2__01493);
            rule__BuiltInNode__Group_2__0__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__BuiltInNode__Group_2__1_in_rule__BuiltInNode__Group_2__01496);
            rule__BuiltInNode__Group_2__1();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group_2__0


    // $ANTLR start rule__BuiltInNode__Group_2__0__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:761:1: rule__BuiltInNode__Group_2__0__Impl : ( ( rule__BuiltInNode__ChildrenAssignment_2_0 ) ) ;
    public final void rule__BuiltInNode__Group_2__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:765:1: ( ( ( rule__BuiltInNode__ChildrenAssignment_2_0 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:766:1: ( ( rule__BuiltInNode__ChildrenAssignment_2_0 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:766:1: ( ( rule__BuiltInNode__ChildrenAssignment_2_0 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:767:1: ( rule__BuiltInNode__ChildrenAssignment_2_0 )
            {
             before(grammarAccess.getBuiltInNodeAccess().getChildrenAssignment_2_0()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:768:1: ( rule__BuiltInNode__ChildrenAssignment_2_0 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:768:2: rule__BuiltInNode__ChildrenAssignment_2_0
            {
            pushFollow(FOLLOW_rule__BuiltInNode__ChildrenAssignment_2_0_in_rule__BuiltInNode__Group_2__0__Impl1523);
            rule__BuiltInNode__ChildrenAssignment_2_0();
            _fsp--;


            }

             after(grammarAccess.getBuiltInNodeAccess().getChildrenAssignment_2_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group_2__0__Impl


    // $ANTLR start rule__BuiltInNode__Group_2__1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:778:1: rule__BuiltInNode__Group_2__1 : rule__BuiltInNode__Group_2__1__Impl ;
    public final void rule__BuiltInNode__Group_2__1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:782:1: ( rule__BuiltInNode__Group_2__1__Impl )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:783:2: rule__BuiltInNode__Group_2__1__Impl
            {
            pushFollow(FOLLOW_rule__BuiltInNode__Group_2__1__Impl_in_rule__BuiltInNode__Group_2__11553);
            rule__BuiltInNode__Group_2__1__Impl();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group_2__1


    // $ANTLR start rule__BuiltInNode__Group_2__1__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:789:1: rule__BuiltInNode__Group_2__1__Impl : ( ( rule__BuiltInNode__Group_2_1__0 )* ) ;
    public final void rule__BuiltInNode__Group_2__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:793:1: ( ( ( rule__BuiltInNode__Group_2_1__0 )* ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:794:1: ( ( rule__BuiltInNode__Group_2_1__0 )* )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:794:1: ( ( rule__BuiltInNode__Group_2_1__0 )* )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:795:1: ( rule__BuiltInNode__Group_2_1__0 )*
            {
             before(grammarAccess.getBuiltInNodeAccess().getGroup_2_1()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:796:1: ( rule__BuiltInNode__Group_2_1__0 )*
            loop7:
            do {
                int alt7=2;
                int LA7_0 = input.LA(1);

                if ( (LA7_0==14) ) {
                    alt7=1;
                }


                switch (alt7) {
            	case 1 :
            	    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:796:2: rule__BuiltInNode__Group_2_1__0
            	    {
            	    pushFollow(FOLLOW_rule__BuiltInNode__Group_2_1__0_in_rule__BuiltInNode__Group_2__1__Impl1580);
            	    rule__BuiltInNode__Group_2_1__0();
            	    _fsp--;


            	    }
            	    break;

            	default :
            	    break loop7;
                }
            } while (true);

             after(grammarAccess.getBuiltInNodeAccess().getGroup_2_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group_2__1__Impl


    // $ANTLR start rule__BuiltInNode__Group_2_1__0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:810:1: rule__BuiltInNode__Group_2_1__0 : rule__BuiltInNode__Group_2_1__0__Impl rule__BuiltInNode__Group_2_1__1 ;
    public final void rule__BuiltInNode__Group_2_1__0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:814:1: ( rule__BuiltInNode__Group_2_1__0__Impl rule__BuiltInNode__Group_2_1__1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:815:2: rule__BuiltInNode__Group_2_1__0__Impl rule__BuiltInNode__Group_2_1__1
            {
            pushFollow(FOLLOW_rule__BuiltInNode__Group_2_1__0__Impl_in_rule__BuiltInNode__Group_2_1__01615);
            rule__BuiltInNode__Group_2_1__0__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__BuiltInNode__Group_2_1__1_in_rule__BuiltInNode__Group_2_1__01618);
            rule__BuiltInNode__Group_2_1__1();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group_2_1__0


    // $ANTLR start rule__BuiltInNode__Group_2_1__0__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:822:1: rule__BuiltInNode__Group_2_1__0__Impl : ( ',' ) ;
    public final void rule__BuiltInNode__Group_2_1__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:826:1: ( ( ',' ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:827:1: ( ',' )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:827:1: ( ',' )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:828:1: ','
            {
             before(grammarAccess.getBuiltInNodeAccess().getCommaKeyword_2_1_0()); 
            match(input,14,FOLLOW_14_in_rule__BuiltInNode__Group_2_1__0__Impl1646); 
             after(grammarAccess.getBuiltInNodeAccess().getCommaKeyword_2_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group_2_1__0__Impl


    // $ANTLR start rule__BuiltInNode__Group_2_1__1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:841:1: rule__BuiltInNode__Group_2_1__1 : rule__BuiltInNode__Group_2_1__1__Impl ;
    public final void rule__BuiltInNode__Group_2_1__1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:845:1: ( rule__BuiltInNode__Group_2_1__1__Impl )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:846:2: rule__BuiltInNode__Group_2_1__1__Impl
            {
            pushFollow(FOLLOW_rule__BuiltInNode__Group_2_1__1__Impl_in_rule__BuiltInNode__Group_2_1__11677);
            rule__BuiltInNode__Group_2_1__1__Impl();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group_2_1__1


    // $ANTLR start rule__BuiltInNode__Group_2_1__1__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:852:1: rule__BuiltInNode__Group_2_1__1__Impl : ( ( rule__BuiltInNode__ChildrenAssignment_2_1_1 ) ) ;
    public final void rule__BuiltInNode__Group_2_1__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:856:1: ( ( ( rule__BuiltInNode__ChildrenAssignment_2_1_1 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:857:1: ( ( rule__BuiltInNode__ChildrenAssignment_2_1_1 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:857:1: ( ( rule__BuiltInNode__ChildrenAssignment_2_1_1 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:858:1: ( rule__BuiltInNode__ChildrenAssignment_2_1_1 )
            {
             before(grammarAccess.getBuiltInNodeAccess().getChildrenAssignment_2_1_1()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:859:1: ( rule__BuiltInNode__ChildrenAssignment_2_1_1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:859:2: rule__BuiltInNode__ChildrenAssignment_2_1_1
            {
            pushFollow(FOLLOW_rule__BuiltInNode__ChildrenAssignment_2_1_1_in_rule__BuiltInNode__Group_2_1__1__Impl1704);
            rule__BuiltInNode__ChildrenAssignment_2_1_1();
            _fsp--;


            }

             after(grammarAccess.getBuiltInNodeAccess().getChildrenAssignment_2_1_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__Group_2_1__1__Impl


    // $ANTLR start rule__IntLeaf__Group__0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:873:1: rule__IntLeaf__Group__0 : rule__IntLeaf__Group__0__Impl rule__IntLeaf__Group__1 ;
    public final void rule__IntLeaf__Group__0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:877:1: ( rule__IntLeaf__Group__0__Impl rule__IntLeaf__Group__1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:878:2: rule__IntLeaf__Group__0__Impl rule__IntLeaf__Group__1
            {
            pushFollow(FOLLOW_rule__IntLeaf__Group__0__Impl_in_rule__IntLeaf__Group__01738);
            rule__IntLeaf__Group__0__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__IntLeaf__Group__1_in_rule__IntLeaf__Group__01741);
            rule__IntLeaf__Group__1();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__IntLeaf__Group__0


    // $ANTLR start rule__IntLeaf__Group__0__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:885:1: rule__IntLeaf__Group__0__Impl : ( ( rule__IntLeaf__SignedAssignment_0 )? ) ;
    public final void rule__IntLeaf__Group__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:889:1: ( ( ( rule__IntLeaf__SignedAssignment_0 )? ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:890:1: ( ( rule__IntLeaf__SignedAssignment_0 )? )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:890:1: ( ( rule__IntLeaf__SignedAssignment_0 )? )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:891:1: ( rule__IntLeaf__SignedAssignment_0 )?
            {
             before(grammarAccess.getIntLeafAccess().getSignedAssignment_0()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:892:1: ( rule__IntLeaf__SignedAssignment_0 )?
            int alt8=2;
            int LA8_0 = input.LA(1);

            if ( (LA8_0==16) ) {
                alt8=1;
            }
            switch (alt8) {
                case 1 :
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:892:2: rule__IntLeaf__SignedAssignment_0
                    {
                    pushFollow(FOLLOW_rule__IntLeaf__SignedAssignment_0_in_rule__IntLeaf__Group__0__Impl1768);
                    rule__IntLeaf__SignedAssignment_0();
                    _fsp--;


                    }
                    break;

            }

             after(grammarAccess.getIntLeafAccess().getSignedAssignment_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__IntLeaf__Group__0__Impl


    // $ANTLR start rule__IntLeaf__Group__1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:902:1: rule__IntLeaf__Group__1 : rule__IntLeaf__Group__1__Impl ;
    public final void rule__IntLeaf__Group__1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:906:1: ( rule__IntLeaf__Group__1__Impl )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:907:2: rule__IntLeaf__Group__1__Impl
            {
            pushFollow(FOLLOW_rule__IntLeaf__Group__1__Impl_in_rule__IntLeaf__Group__11799);
            rule__IntLeaf__Group__1__Impl();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__IntLeaf__Group__1


    // $ANTLR start rule__IntLeaf__Group__1__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:913:1: rule__IntLeaf__Group__1__Impl : ( ( rule__IntLeaf__ValueAssignment_1 ) ) ;
    public final void rule__IntLeaf__Group__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:917:1: ( ( ( rule__IntLeaf__ValueAssignment_1 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:918:1: ( ( rule__IntLeaf__ValueAssignment_1 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:918:1: ( ( rule__IntLeaf__ValueAssignment_1 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:919:1: ( rule__IntLeaf__ValueAssignment_1 )
            {
             before(grammarAccess.getIntLeafAccess().getValueAssignment_1()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:920:1: ( rule__IntLeaf__ValueAssignment_1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:920:2: rule__IntLeaf__ValueAssignment_1
            {
            pushFollow(FOLLOW_rule__IntLeaf__ValueAssignment_1_in_rule__IntLeaf__Group__1__Impl1826);
            rule__IntLeaf__ValueAssignment_1();
            _fsp--;


            }

             after(grammarAccess.getIntLeafAccess().getValueAssignment_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__IntLeaf__Group__1__Impl


    // $ANTLR start rule__FloatLeaf__Group__0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:934:1: rule__FloatLeaf__Group__0 : rule__FloatLeaf__Group__0__Impl rule__FloatLeaf__Group__1 ;
    public final void rule__FloatLeaf__Group__0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:938:1: ( rule__FloatLeaf__Group__0__Impl rule__FloatLeaf__Group__1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:939:2: rule__FloatLeaf__Group__0__Impl rule__FloatLeaf__Group__1
            {
            pushFollow(FOLLOW_rule__FloatLeaf__Group__0__Impl_in_rule__FloatLeaf__Group__01860);
            rule__FloatLeaf__Group__0__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__FloatLeaf__Group__1_in_rule__FloatLeaf__Group__01863);
            rule__FloatLeaf__Group__1();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Group__0


    // $ANTLR start rule__FloatLeaf__Group__0__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:946:1: rule__FloatLeaf__Group__0__Impl : ( ( rule__FloatLeaf__SignedAssignment_0 )? ) ;
    public final void rule__FloatLeaf__Group__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:950:1: ( ( ( rule__FloatLeaf__SignedAssignment_0 )? ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:951:1: ( ( rule__FloatLeaf__SignedAssignment_0 )? )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:951:1: ( ( rule__FloatLeaf__SignedAssignment_0 )? )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:952:1: ( rule__FloatLeaf__SignedAssignment_0 )?
            {
             before(grammarAccess.getFloatLeafAccess().getSignedAssignment_0()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:953:1: ( rule__FloatLeaf__SignedAssignment_0 )?
            int alt9=2;
            int LA9_0 = input.LA(1);

            if ( (LA9_0==16) ) {
                alt9=1;
            }
            switch (alt9) {
                case 1 :
                    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:953:2: rule__FloatLeaf__SignedAssignment_0
                    {
                    pushFollow(FOLLOW_rule__FloatLeaf__SignedAssignment_0_in_rule__FloatLeaf__Group__0__Impl1890);
                    rule__FloatLeaf__SignedAssignment_0();
                    _fsp--;


                    }
                    break;

            }

             after(grammarAccess.getFloatLeafAccess().getSignedAssignment_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Group__0__Impl


    // $ANTLR start rule__FloatLeaf__Group__1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:963:1: rule__FloatLeaf__Group__1 : rule__FloatLeaf__Group__1__Impl ;
    public final void rule__FloatLeaf__Group__1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:967:1: ( rule__FloatLeaf__Group__1__Impl )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:968:2: rule__FloatLeaf__Group__1__Impl
            {
            pushFollow(FOLLOW_rule__FloatLeaf__Group__1__Impl_in_rule__FloatLeaf__Group__11921);
            rule__FloatLeaf__Group__1__Impl();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Group__1


    // $ANTLR start rule__FloatLeaf__Group__1__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:974:1: rule__FloatLeaf__Group__1__Impl : ( ( rule__FloatLeaf__Alternatives_1 ) ) ;
    public final void rule__FloatLeaf__Group__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:978:1: ( ( ( rule__FloatLeaf__Alternatives_1 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:979:1: ( ( rule__FloatLeaf__Alternatives_1 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:979:1: ( ( rule__FloatLeaf__Alternatives_1 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:980:1: ( rule__FloatLeaf__Alternatives_1 )
            {
             before(grammarAccess.getFloatLeafAccess().getAlternatives_1()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:981:1: ( rule__FloatLeaf__Alternatives_1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:981:2: rule__FloatLeaf__Alternatives_1
            {
            pushFollow(FOLLOW_rule__FloatLeaf__Alternatives_1_in_rule__FloatLeaf__Group__1__Impl1948);
            rule__FloatLeaf__Alternatives_1();
            _fsp--;


            }

             after(grammarAccess.getFloatLeafAccess().getAlternatives_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Group__1__Impl


    // $ANTLR start rule__FloatLeaf__Group_1_0__0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:995:1: rule__FloatLeaf__Group_1_0__0 : rule__FloatLeaf__Group_1_0__0__Impl rule__FloatLeaf__Group_1_0__1 ;
    public final void rule__FloatLeaf__Group_1_0__0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:999:1: ( rule__FloatLeaf__Group_1_0__0__Impl rule__FloatLeaf__Group_1_0__1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1000:2: rule__FloatLeaf__Group_1_0__0__Impl rule__FloatLeaf__Group_1_0__1
            {
            pushFollow(FOLLOW_rule__FloatLeaf__Group_1_0__0__Impl_in_rule__FloatLeaf__Group_1_0__01982);
            rule__FloatLeaf__Group_1_0__0__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__FloatLeaf__Group_1_0__1_in_rule__FloatLeaf__Group_1_0__01985);
            rule__FloatLeaf__Group_1_0__1();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Group_1_0__0


    // $ANTLR start rule__FloatLeaf__Group_1_0__0__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1007:1: rule__FloatLeaf__Group_1_0__0__Impl : ( ( rule__FloatLeaf__AAssignment_1_0_0 ) ) ;
    public final void rule__FloatLeaf__Group_1_0__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1011:1: ( ( ( rule__FloatLeaf__AAssignment_1_0_0 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1012:1: ( ( rule__FloatLeaf__AAssignment_1_0_0 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1012:1: ( ( rule__FloatLeaf__AAssignment_1_0_0 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1013:1: ( rule__FloatLeaf__AAssignment_1_0_0 )
            {
             before(grammarAccess.getFloatLeafAccess().getAAssignment_1_0_0()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1014:1: ( rule__FloatLeaf__AAssignment_1_0_0 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1014:2: rule__FloatLeaf__AAssignment_1_0_0
            {
            pushFollow(FOLLOW_rule__FloatLeaf__AAssignment_1_0_0_in_rule__FloatLeaf__Group_1_0__0__Impl2012);
            rule__FloatLeaf__AAssignment_1_0_0();
            _fsp--;


            }

             after(grammarAccess.getFloatLeafAccess().getAAssignment_1_0_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Group_1_0__0__Impl


    // $ANTLR start rule__FloatLeaf__Group_1_0__1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1024:1: rule__FloatLeaf__Group_1_0__1 : rule__FloatLeaf__Group_1_0__1__Impl rule__FloatLeaf__Group_1_0__2 ;
    public final void rule__FloatLeaf__Group_1_0__1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1028:1: ( rule__FloatLeaf__Group_1_0__1__Impl rule__FloatLeaf__Group_1_0__2 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1029:2: rule__FloatLeaf__Group_1_0__1__Impl rule__FloatLeaf__Group_1_0__2
            {
            pushFollow(FOLLOW_rule__FloatLeaf__Group_1_0__1__Impl_in_rule__FloatLeaf__Group_1_0__12042);
            rule__FloatLeaf__Group_1_0__1__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__FloatLeaf__Group_1_0__2_in_rule__FloatLeaf__Group_1_0__12045);
            rule__FloatLeaf__Group_1_0__2();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Group_1_0__1


    // $ANTLR start rule__FloatLeaf__Group_1_0__1__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1036:1: rule__FloatLeaf__Group_1_0__1__Impl : ( '.' ) ;
    public final void rule__FloatLeaf__Group_1_0__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1040:1: ( ( '.' ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1041:1: ( '.' )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1041:1: ( '.' )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1042:1: '.'
            {
             before(grammarAccess.getFloatLeafAccess().getFullStopKeyword_1_0_1()); 
            match(input,15,FOLLOW_15_in_rule__FloatLeaf__Group_1_0__1__Impl2073); 
             after(grammarAccess.getFloatLeafAccess().getFullStopKeyword_1_0_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Group_1_0__1__Impl


    // $ANTLR start rule__FloatLeaf__Group_1_0__2
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1055:1: rule__FloatLeaf__Group_1_0__2 : rule__FloatLeaf__Group_1_0__2__Impl ;
    public final void rule__FloatLeaf__Group_1_0__2() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1059:1: ( rule__FloatLeaf__Group_1_0__2__Impl )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1060:2: rule__FloatLeaf__Group_1_0__2__Impl
            {
            pushFollow(FOLLOW_rule__FloatLeaf__Group_1_0__2__Impl_in_rule__FloatLeaf__Group_1_0__22104);
            rule__FloatLeaf__Group_1_0__2__Impl();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Group_1_0__2


    // $ANTLR start rule__FloatLeaf__Group_1_0__2__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1066:1: rule__FloatLeaf__Group_1_0__2__Impl : ( ( rule__FloatLeaf__BAssignment_1_0_2 ) ) ;
    public final void rule__FloatLeaf__Group_1_0__2__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1070:1: ( ( ( rule__FloatLeaf__BAssignment_1_0_2 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1071:1: ( ( rule__FloatLeaf__BAssignment_1_0_2 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1071:1: ( ( rule__FloatLeaf__BAssignment_1_0_2 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1072:1: ( rule__FloatLeaf__BAssignment_1_0_2 )
            {
             before(grammarAccess.getFloatLeafAccess().getBAssignment_1_0_2()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1073:1: ( rule__FloatLeaf__BAssignment_1_0_2 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1073:2: rule__FloatLeaf__BAssignment_1_0_2
            {
            pushFollow(FOLLOW_rule__FloatLeaf__BAssignment_1_0_2_in_rule__FloatLeaf__Group_1_0__2__Impl2131);
            rule__FloatLeaf__BAssignment_1_0_2();
            _fsp--;


            }

             after(grammarAccess.getFloatLeafAccess().getBAssignment_1_0_2()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Group_1_0__2__Impl


    // $ANTLR start rule__FloatLeaf__Group_1_1__0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1089:1: rule__FloatLeaf__Group_1_1__0 : rule__FloatLeaf__Group_1_1__0__Impl rule__FloatLeaf__Group_1_1__1 ;
    public final void rule__FloatLeaf__Group_1_1__0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1093:1: ( rule__FloatLeaf__Group_1_1__0__Impl rule__FloatLeaf__Group_1_1__1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1094:2: rule__FloatLeaf__Group_1_1__0__Impl rule__FloatLeaf__Group_1_1__1
            {
            pushFollow(FOLLOW_rule__FloatLeaf__Group_1_1__0__Impl_in_rule__FloatLeaf__Group_1_1__02167);
            rule__FloatLeaf__Group_1_1__0__Impl();
            _fsp--;

            pushFollow(FOLLOW_rule__FloatLeaf__Group_1_1__1_in_rule__FloatLeaf__Group_1_1__02170);
            rule__FloatLeaf__Group_1_1__1();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Group_1_1__0


    // $ANTLR start rule__FloatLeaf__Group_1_1__0__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1101:1: rule__FloatLeaf__Group_1_1__0__Impl : ( '.' ) ;
    public final void rule__FloatLeaf__Group_1_1__0__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1105:1: ( ( '.' ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1106:1: ( '.' )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1106:1: ( '.' )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1107:1: '.'
            {
             before(grammarAccess.getFloatLeafAccess().getFullStopKeyword_1_1_0()); 
            match(input,15,FOLLOW_15_in_rule__FloatLeaf__Group_1_1__0__Impl2198); 
             after(grammarAccess.getFloatLeafAccess().getFullStopKeyword_1_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Group_1_1__0__Impl


    // $ANTLR start rule__FloatLeaf__Group_1_1__1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1120:1: rule__FloatLeaf__Group_1_1__1 : rule__FloatLeaf__Group_1_1__1__Impl ;
    public final void rule__FloatLeaf__Group_1_1__1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1124:1: ( rule__FloatLeaf__Group_1_1__1__Impl )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1125:2: rule__FloatLeaf__Group_1_1__1__Impl
            {
            pushFollow(FOLLOW_rule__FloatLeaf__Group_1_1__1__Impl_in_rule__FloatLeaf__Group_1_1__12229);
            rule__FloatLeaf__Group_1_1__1__Impl();
            _fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Group_1_1__1


    // $ANTLR start rule__FloatLeaf__Group_1_1__1__Impl
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1131:1: rule__FloatLeaf__Group_1_1__1__Impl : ( ( rule__FloatLeaf__BAssignment_1_1_1 ) ) ;
    public final void rule__FloatLeaf__Group_1_1__1__Impl() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1135:1: ( ( ( rule__FloatLeaf__BAssignment_1_1_1 ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1136:1: ( ( rule__FloatLeaf__BAssignment_1_1_1 ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1136:1: ( ( rule__FloatLeaf__BAssignment_1_1_1 ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1137:1: ( rule__FloatLeaf__BAssignment_1_1_1 )
            {
             before(grammarAccess.getFloatLeafAccess().getBAssignment_1_1_1()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1138:1: ( rule__FloatLeaf__BAssignment_1_1_1 )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1138:2: rule__FloatLeaf__BAssignment_1_1_1
            {
            pushFollow(FOLLOW_rule__FloatLeaf__BAssignment_1_1_1_in_rule__FloatLeaf__Group_1_1__1__Impl2256);
            rule__FloatLeaf__BAssignment_1_1_1();
            _fsp--;


            }

             after(grammarAccess.getFloatLeafAccess().getBAssignment_1_1_1()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__Group_1_1__1__Impl


    // $ANTLR start rule__ASTNode__NameAssignment_0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1153:1: rule__ASTNode__NameAssignment_0 : ( RULE_ID ) ;
    public final void rule__ASTNode__NameAssignment_0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1157:1: ( ( RULE_ID ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1158:1: ( RULE_ID )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1158:1: ( RULE_ID )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1159:1: RULE_ID
            {
             before(grammarAccess.getASTNodeAccess().getNameIDTerminalRuleCall_0_0()); 
            match(input,RULE_ID,FOLLOW_RULE_ID_in_rule__ASTNode__NameAssignment_02295); 
             after(grammarAccess.getASTNodeAccess().getNameIDTerminalRuleCall_0_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__NameAssignment_0


    // $ANTLR start rule__ASTNode__ChildrenAssignment_2_0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1168:1: rule__ASTNode__ChildrenAssignment_2_0 : ( ruleNode ) ;
    public final void rule__ASTNode__ChildrenAssignment_2_0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1172:1: ( ( ruleNode ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1173:1: ( ruleNode )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1173:1: ( ruleNode )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1174:1: ruleNode
            {
             before(grammarAccess.getASTNodeAccess().getChildrenNodeParserRuleCall_2_0_0()); 
            pushFollow(FOLLOW_ruleNode_in_rule__ASTNode__ChildrenAssignment_2_02326);
            ruleNode();
            _fsp--;

             after(grammarAccess.getASTNodeAccess().getChildrenNodeParserRuleCall_2_0_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__ChildrenAssignment_2_0


    // $ANTLR start rule__ASTNode__ChildrenAssignment_2_1_1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1183:1: rule__ASTNode__ChildrenAssignment_2_1_1 : ( ruleNode ) ;
    public final void rule__ASTNode__ChildrenAssignment_2_1_1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1187:1: ( ( ruleNode ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1188:1: ( ruleNode )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1188:1: ( ruleNode )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1189:1: ruleNode
            {
             before(grammarAccess.getASTNodeAccess().getChildrenNodeParserRuleCall_2_1_1_0()); 
            pushFollow(FOLLOW_ruleNode_in_rule__ASTNode__ChildrenAssignment_2_1_12357);
            ruleNode();
            _fsp--;

             after(grammarAccess.getASTNodeAccess().getChildrenNodeParserRuleCall_2_1_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__ASTNode__ChildrenAssignment_2_1_1


    // $ANTLR start rule__BuiltInNode__KeywordAssignment_0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1198:1: rule__BuiltInNode__KeywordAssignment_0 : ( RULE_KEYWORD ) ;
    public final void rule__BuiltInNode__KeywordAssignment_0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1202:1: ( ( RULE_KEYWORD ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1203:1: ( RULE_KEYWORD )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1203:1: ( RULE_KEYWORD )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1204:1: RULE_KEYWORD
            {
             before(grammarAccess.getBuiltInNodeAccess().getKeywordKeyWordTerminalRuleCall_0_0()); 
            match(input,RULE_KEYWORD,FOLLOW_RULE_KEYWORD_in_rule__BuiltInNode__KeywordAssignment_02388); 
             after(grammarAccess.getBuiltInNodeAccess().getKeywordKeyWordTerminalRuleCall_0_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__KeywordAssignment_0


    // $ANTLR start rule__BuiltInNode__ChildrenAssignment_2_0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1213:1: rule__BuiltInNode__ChildrenAssignment_2_0 : ( ruleNode ) ;
    public final void rule__BuiltInNode__ChildrenAssignment_2_0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1217:1: ( ( ruleNode ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1218:1: ( ruleNode )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1218:1: ( ruleNode )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1219:1: ruleNode
            {
             before(grammarAccess.getBuiltInNodeAccess().getChildrenNodeParserRuleCall_2_0_0()); 
            pushFollow(FOLLOW_ruleNode_in_rule__BuiltInNode__ChildrenAssignment_2_02419);
            ruleNode();
            _fsp--;

             after(grammarAccess.getBuiltInNodeAccess().getChildrenNodeParserRuleCall_2_0_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__ChildrenAssignment_2_0


    // $ANTLR start rule__BuiltInNode__ChildrenAssignment_2_1_1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1228:1: rule__BuiltInNode__ChildrenAssignment_2_1_1 : ( ruleNode ) ;
    public final void rule__BuiltInNode__ChildrenAssignment_2_1_1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1232:1: ( ( ruleNode ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1233:1: ( ruleNode )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1233:1: ( ruleNode )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1234:1: ruleNode
            {
             before(grammarAccess.getBuiltInNodeAccess().getChildrenNodeParserRuleCall_2_1_1_0()); 
            pushFollow(FOLLOW_ruleNode_in_rule__BuiltInNode__ChildrenAssignment_2_1_12450);
            ruleNode();
            _fsp--;

             after(grammarAccess.getBuiltInNodeAccess().getChildrenNodeParserRuleCall_2_1_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__BuiltInNode__ChildrenAssignment_2_1_1


    // $ANTLR start rule__IntLeaf__SignedAssignment_0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1243:1: rule__IntLeaf__SignedAssignment_0 : ( ( '-' ) ) ;
    public final void rule__IntLeaf__SignedAssignment_0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1247:1: ( ( ( '-' ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1248:1: ( ( '-' ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1248:1: ( ( '-' ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1249:1: ( '-' )
            {
             before(grammarAccess.getIntLeafAccess().getSignedHyphenMinusKeyword_0_0()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1250:1: ( '-' )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1251:1: '-'
            {
             before(grammarAccess.getIntLeafAccess().getSignedHyphenMinusKeyword_0_0()); 
            match(input,16,FOLLOW_16_in_rule__IntLeaf__SignedAssignment_02486); 
             after(grammarAccess.getIntLeafAccess().getSignedHyphenMinusKeyword_0_0()); 

            }

             after(grammarAccess.getIntLeafAccess().getSignedHyphenMinusKeyword_0_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__IntLeaf__SignedAssignment_0


    // $ANTLR start rule__IntLeaf__ValueAssignment_1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1266:1: rule__IntLeaf__ValueAssignment_1 : ( RULE_INT ) ;
    public final void rule__IntLeaf__ValueAssignment_1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1270:1: ( ( RULE_INT ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1271:1: ( RULE_INT )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1271:1: ( RULE_INT )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1272:1: RULE_INT
            {
             before(grammarAccess.getIntLeafAccess().getValueINTTerminalRuleCall_1_0()); 
            match(input,RULE_INT,FOLLOW_RULE_INT_in_rule__IntLeaf__ValueAssignment_12525); 
             after(grammarAccess.getIntLeafAccess().getValueINTTerminalRuleCall_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__IntLeaf__ValueAssignment_1


    // $ANTLR start rule__StringLeaf__ValueAssignment
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1281:1: rule__StringLeaf__ValueAssignment : ( RULE_STRING ) ;
    public final void rule__StringLeaf__ValueAssignment() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1285:1: ( ( RULE_STRING ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1286:1: ( RULE_STRING )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1286:1: ( RULE_STRING )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1287:1: RULE_STRING
            {
             before(grammarAccess.getStringLeafAccess().getValueSTRINGTerminalRuleCall_0()); 
            match(input,RULE_STRING,FOLLOW_RULE_STRING_in_rule__StringLeaf__ValueAssignment2556); 
             after(grammarAccess.getStringLeafAccess().getValueSTRINGTerminalRuleCall_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__StringLeaf__ValueAssignment


    // $ANTLR start rule__SymbolLeaf__NameAssignment
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1296:1: rule__SymbolLeaf__NameAssignment : ( RULE_ID ) ;
    public final void rule__SymbolLeaf__NameAssignment() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1300:1: ( ( RULE_ID ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1301:1: ( RULE_ID )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1301:1: ( RULE_ID )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1302:1: RULE_ID
            {
             before(grammarAccess.getSymbolLeafAccess().getNameIDTerminalRuleCall_0()); 
            match(input,RULE_ID,FOLLOW_RULE_ID_in_rule__SymbolLeaf__NameAssignment2587); 
             after(grammarAccess.getSymbolLeafAccess().getNameIDTerminalRuleCall_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__SymbolLeaf__NameAssignment


    // $ANTLR start rule__FloatLeaf__SignedAssignment_0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1311:1: rule__FloatLeaf__SignedAssignment_0 : ( ( '-' ) ) ;
    public final void rule__FloatLeaf__SignedAssignment_0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1315:1: ( ( ( '-' ) ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1316:1: ( ( '-' ) )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1316:1: ( ( '-' ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1317:1: ( '-' )
            {
             before(grammarAccess.getFloatLeafAccess().getSignedHyphenMinusKeyword_0_0()); 
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1318:1: ( '-' )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1319:1: '-'
            {
             before(grammarAccess.getFloatLeafAccess().getSignedHyphenMinusKeyword_0_0()); 
            match(input,16,FOLLOW_16_in_rule__FloatLeaf__SignedAssignment_02623); 
             after(grammarAccess.getFloatLeafAccess().getSignedHyphenMinusKeyword_0_0()); 

            }

             after(grammarAccess.getFloatLeafAccess().getSignedHyphenMinusKeyword_0_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__SignedAssignment_0


    // $ANTLR start rule__FloatLeaf__AAssignment_1_0_0
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1334:1: rule__FloatLeaf__AAssignment_1_0_0 : ( RULE_INT ) ;
    public final void rule__FloatLeaf__AAssignment_1_0_0() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1338:1: ( ( RULE_INT ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1339:1: ( RULE_INT )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1339:1: ( RULE_INT )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1340:1: RULE_INT
            {
             before(grammarAccess.getFloatLeafAccess().getAINTTerminalRuleCall_1_0_0_0()); 
            match(input,RULE_INT,FOLLOW_RULE_INT_in_rule__FloatLeaf__AAssignment_1_0_02662); 
             after(grammarAccess.getFloatLeafAccess().getAINTTerminalRuleCall_1_0_0_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__AAssignment_1_0_0


    // $ANTLR start rule__FloatLeaf__BAssignment_1_0_2
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1349:1: rule__FloatLeaf__BAssignment_1_0_2 : ( RULE_INT ) ;
    public final void rule__FloatLeaf__BAssignment_1_0_2() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1353:1: ( ( RULE_INT ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1354:1: ( RULE_INT )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1354:1: ( RULE_INT )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1355:1: RULE_INT
            {
             before(grammarAccess.getFloatLeafAccess().getBINTTerminalRuleCall_1_0_2_0()); 
            match(input,RULE_INT,FOLLOW_RULE_INT_in_rule__FloatLeaf__BAssignment_1_0_22693); 
             after(grammarAccess.getFloatLeafAccess().getBINTTerminalRuleCall_1_0_2_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__BAssignment_1_0_2


    // $ANTLR start rule__FloatLeaf__BAssignment_1_1_1
    // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1364:1: rule__FloatLeaf__BAssignment_1_1_1 : ( RULE_INT ) ;
    public final void rule__FloatLeaf__BAssignment_1_1_1() throws RecognitionException {

        		int stackSize = keepStackSize();
            
        try {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1368:1: ( ( RULE_INT ) )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1369:1: ( RULE_INT )
            {
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1369:1: ( RULE_INT )
            // ../fr.irisa.cairn.model.mathematica.xtext.ui/src-gen/fr/irisa/cairn/model/ui/contentassist/antlr/internal/InternalMathematica.g:1370:1: RULE_INT
            {
             before(grammarAccess.getFloatLeafAccess().getBINTTerminalRuleCall_1_1_1_0()); 
            match(input,RULE_INT,FOLLOW_RULE_INT_in_rule__FloatLeaf__BAssignment_1_1_12724); 
             after(grammarAccess.getFloatLeafAccess().getBINTTerminalRuleCall_1_1_1_0()); 

            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {

            	restoreStackSize(stackSize);

        }
        return ;
    }
    // $ANTLR end rule__FloatLeaf__BAssignment_1_1_1


 

    public static final BitSet FOLLOW_ruleNode_in_entryRuleNode61 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleNode68 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__Node__Alternatives_in_ruleNode94 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleASTNode_in_entryRuleASTNode121 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleASTNode128 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__ASTNode__Group__0_in_ruleASTNode154 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleBuiltInNode_in_entryRuleBuiltInNode181 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleBuiltInNode188 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group__0_in_ruleBuiltInNode214 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleASTLeaf_in_entryRuleASTLeaf241 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleASTLeaf248 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__ASTLeaf__Alternatives_in_ruleASTLeaf274 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleIntLeaf_in_entryRuleIntLeaf301 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleIntLeaf308 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__IntLeaf__Group__0_in_ruleIntLeaf334 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleStringLeaf_in_entryRuleStringLeaf361 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleStringLeaf368 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__StringLeaf__ValueAssignment_in_ruleStringLeaf394 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleSymbolLeaf_in_entryRuleSymbolLeaf421 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleSymbolLeaf428 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__SymbolLeaf__NameAssignment_in_ruleSymbolLeaf454 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleFloatLeaf_in_entryRuleFloatLeaf481 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_entryRuleFloatLeaf488 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Group__0_in_ruleFloatLeaf514 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleASTNode_in_rule__Node__Alternatives550 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleASTLeaf_in_rule__Node__Alternatives567 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleBuiltInNode_in_rule__Node__Alternatives584 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleIntLeaf_in_rule__ASTLeaf__Alternatives616 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleStringLeaf_in_rule__ASTLeaf__Alternatives633 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleFloatLeaf_in_rule__ASTLeaf__Alternatives650 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleSymbolLeaf_in_rule__ASTLeaf__Alternatives667 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Group_1_0__0_in_rule__FloatLeaf__Alternatives_1699 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Group_1_1__0_in_rule__FloatLeaf__Alternatives_1717 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__ASTNode__Group__0__Impl_in_rule__ASTNode__Group__0748 = new BitSet(new long[]{0x0000000000001000L});
    public static final BitSet FOLLOW_rule__ASTNode__Group__1_in_rule__ASTNode__Group__0751 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__ASTNode__NameAssignment_0_in_rule__ASTNode__Group__0__Impl778 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__ASTNode__Group__1__Impl_in_rule__ASTNode__Group__1808 = new BitSet(new long[]{0x000000000001A0F0L});
    public static final BitSet FOLLOW_rule__ASTNode__Group__2_in_rule__ASTNode__Group__1811 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_12_in_rule__ASTNode__Group__1__Impl839 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__ASTNode__Group__2__Impl_in_rule__ASTNode__Group__2870 = new BitSet(new long[]{0x0000000000002000L});
    public static final BitSet FOLLOW_rule__ASTNode__Group__3_in_rule__ASTNode__Group__2873 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__ASTNode__Group_2__0_in_rule__ASTNode__Group__2__Impl900 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__ASTNode__Group__3__Impl_in_rule__ASTNode__Group__3931 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_13_in_rule__ASTNode__Group__3__Impl959 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__ASTNode__Group_2__0__Impl_in_rule__ASTNode__Group_2__0998 = new BitSet(new long[]{0x0000000000004002L});
    public static final BitSet FOLLOW_rule__ASTNode__Group_2__1_in_rule__ASTNode__Group_2__01001 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__ASTNode__ChildrenAssignment_2_0_in_rule__ASTNode__Group_2__0__Impl1028 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__ASTNode__Group_2__1__Impl_in_rule__ASTNode__Group_2__11058 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__ASTNode__Group_2_1__0_in_rule__ASTNode__Group_2__1__Impl1085 = new BitSet(new long[]{0x0000000000004002L});
    public static final BitSet FOLLOW_rule__ASTNode__Group_2_1__0__Impl_in_rule__ASTNode__Group_2_1__01120 = new BitSet(new long[]{0x00000000000180F0L});
    public static final BitSet FOLLOW_rule__ASTNode__Group_2_1__1_in_rule__ASTNode__Group_2_1__01123 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_14_in_rule__ASTNode__Group_2_1__0__Impl1151 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__ASTNode__Group_2_1__1__Impl_in_rule__ASTNode__Group_2_1__11182 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__ASTNode__ChildrenAssignment_2_1_1_in_rule__ASTNode__Group_2_1__1__Impl1209 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group__0__Impl_in_rule__BuiltInNode__Group__01243 = new BitSet(new long[]{0x0000000000001000L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group__1_in_rule__BuiltInNode__Group__01246 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__KeywordAssignment_0_in_rule__BuiltInNode__Group__0__Impl1273 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group__1__Impl_in_rule__BuiltInNode__Group__11303 = new BitSet(new long[]{0x000000000001A0F0L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group__2_in_rule__BuiltInNode__Group__11306 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_12_in_rule__BuiltInNode__Group__1__Impl1334 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group__2__Impl_in_rule__BuiltInNode__Group__21365 = new BitSet(new long[]{0x0000000000002000L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group__3_in_rule__BuiltInNode__Group__21368 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group_2__0_in_rule__BuiltInNode__Group__2__Impl1395 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group__3__Impl_in_rule__BuiltInNode__Group__31426 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_13_in_rule__BuiltInNode__Group__3__Impl1454 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group_2__0__Impl_in_rule__BuiltInNode__Group_2__01493 = new BitSet(new long[]{0x0000000000004002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group_2__1_in_rule__BuiltInNode__Group_2__01496 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__ChildrenAssignment_2_0_in_rule__BuiltInNode__Group_2__0__Impl1523 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group_2__1__Impl_in_rule__BuiltInNode__Group_2__11553 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group_2_1__0_in_rule__BuiltInNode__Group_2__1__Impl1580 = new BitSet(new long[]{0x0000000000004002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group_2_1__0__Impl_in_rule__BuiltInNode__Group_2_1__01615 = new BitSet(new long[]{0x00000000000180F0L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group_2_1__1_in_rule__BuiltInNode__Group_2_1__01618 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_14_in_rule__BuiltInNode__Group_2_1__0__Impl1646 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__Group_2_1__1__Impl_in_rule__BuiltInNode__Group_2_1__11677 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__BuiltInNode__ChildrenAssignment_2_1_1_in_rule__BuiltInNode__Group_2_1__1__Impl1704 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__IntLeaf__Group__0__Impl_in_rule__IntLeaf__Group__01738 = new BitSet(new long[]{0x0000000000000040L});
    public static final BitSet FOLLOW_rule__IntLeaf__Group__1_in_rule__IntLeaf__Group__01741 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__IntLeaf__SignedAssignment_0_in_rule__IntLeaf__Group__0__Impl1768 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__IntLeaf__Group__1__Impl_in_rule__IntLeaf__Group__11799 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__IntLeaf__ValueAssignment_1_in_rule__IntLeaf__Group__1__Impl1826 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Group__0__Impl_in_rule__FloatLeaf__Group__01860 = new BitSet(new long[]{0x0000000000008040L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Group__1_in_rule__FloatLeaf__Group__01863 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__SignedAssignment_0_in_rule__FloatLeaf__Group__0__Impl1890 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Group__1__Impl_in_rule__FloatLeaf__Group__11921 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Alternatives_1_in_rule__FloatLeaf__Group__1__Impl1948 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Group_1_0__0__Impl_in_rule__FloatLeaf__Group_1_0__01982 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Group_1_0__1_in_rule__FloatLeaf__Group_1_0__01985 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__AAssignment_1_0_0_in_rule__FloatLeaf__Group_1_0__0__Impl2012 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Group_1_0__1__Impl_in_rule__FloatLeaf__Group_1_0__12042 = new BitSet(new long[]{0x0000000000000040L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Group_1_0__2_in_rule__FloatLeaf__Group_1_0__12045 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_15_in_rule__FloatLeaf__Group_1_0__1__Impl2073 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Group_1_0__2__Impl_in_rule__FloatLeaf__Group_1_0__22104 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__BAssignment_1_0_2_in_rule__FloatLeaf__Group_1_0__2__Impl2131 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Group_1_1__0__Impl_in_rule__FloatLeaf__Group_1_1__02167 = new BitSet(new long[]{0x0000000000000040L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Group_1_1__1_in_rule__FloatLeaf__Group_1_1__02170 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_15_in_rule__FloatLeaf__Group_1_1__0__Impl2198 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__Group_1_1__1__Impl_in_rule__FloatLeaf__Group_1_1__12229 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_rule__FloatLeaf__BAssignment_1_1_1_in_rule__FloatLeaf__Group_1_1__1__Impl2256 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RULE_ID_in_rule__ASTNode__NameAssignment_02295 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleNode_in_rule__ASTNode__ChildrenAssignment_2_02326 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleNode_in_rule__ASTNode__ChildrenAssignment_2_1_12357 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RULE_KEYWORD_in_rule__BuiltInNode__KeywordAssignment_02388 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleNode_in_rule__BuiltInNode__ChildrenAssignment_2_02419 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ruleNode_in_rule__BuiltInNode__ChildrenAssignment_2_1_12450 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_16_in_rule__IntLeaf__SignedAssignment_02486 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RULE_INT_in_rule__IntLeaf__ValueAssignment_12525 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RULE_STRING_in_rule__StringLeaf__ValueAssignment2556 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RULE_ID_in_rule__SymbolLeaf__NameAssignment2587 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_16_in_rule__FloatLeaf__SignedAssignment_02623 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RULE_INT_in_rule__FloatLeaf__AAssignment_1_0_02662 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RULE_INT_in_rule__FloatLeaf__BAssignment_1_0_22693 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RULE_INT_in_rule__FloatLeaf__BAssignment_1_1_12724 = new BitSet(new long[]{0x0000000000000002L});

}