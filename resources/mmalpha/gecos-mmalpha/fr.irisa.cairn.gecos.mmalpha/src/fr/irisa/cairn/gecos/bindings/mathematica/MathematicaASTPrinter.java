package fr.irisa.cairn.gecos.bindings.mathematica;

import fr.irisa.cairn.model.mathematica.ASTNode;
import fr.irisa.cairn.model.mathematica.BuiltInNode;
import fr.irisa.cairn.model.mathematica.FloatLeaf;
import fr.irisa.cairn.model.mathematica.IntLeaf;
import fr.irisa.cairn.model.mathematica.Node;
import fr.irisa.cairn.model.mathematica.StringLeaf;
import fr.irisa.cairn.model.mathematica.SymbolLeaf;
import fr.irisa.cairn.model.mathematica.util.MathematicaSwitch;

public class MathematicaASTPrinter extends MathematicaSwitch {
	
	private static MathematicaASTPrinter singleton;
	private int depth=0;
	private String indentString="";
	
	boolean treeOutput=false;
	
	private String updateIdent() {
		indentString ="";
		for(int i=0;i<depth;i++) indentString= indentString+"    ";
		return indentString;
	}
	
	private void Indent() {
		depth++;
		updateIdent();
	}

	private String newline() {
		if (treeOutput) return "\n"; else return "";
	}

	private String line(String text) {
		return indentString+text;
	}

	private void UnIndent() {
		depth--;
		updateIdent();
	}
	
	private MathematicaASTPrinter() {
	}

	public static MathematicaASTPrinter getPrinter() {
		if (singleton==null) {
			singleton = new MathematicaASTPrinter();
		}
		return singleton; 
	}
	
	public String printTree(Node root) {
		try {
			treeOutput=true;
			return (String) doSwitch(root);
		} catch (Exception e) {
			return "? error ";
		}
	}
	
	public String print(Node root) {
		try {
			treeOutput=false;
			return (String) doSwitch(root);
		} catch (Exception e) {
			return "? error ";
		}
	}

	
	@Override
	public Object caseASTNode(ASTNode object) {
		StringBuffer res = new StringBuffer();
		res.append(line(object.getName()+"["+newline()));
		int offset = object.getChildren().size()-1;
		
		Indent();
		for (Node node : object.getChildren()) {
			res.append(doSwitch(node));
			if((offset--)>0) res.append(',');
			res.append(newline());
		}
		res.append(line("]"));
		UnIndent();
		return res.toString();
	}

	@Override
	public Object caseFloatLeaf(FloatLeaf object) {
		return line(object.getA()+"."+object.getB());
	}

	@Override
	public Object caseIntLeaf(IntLeaf object) {
		//object.getSigned().equals("-")?"-":""
		return line(""+object.getValue());
	}

	@Override
	public Object caseStringLeaf(StringLeaf object) {
		return line(object.getValue());
	}

	@Override
	public Object caseSymbolLeaf(SymbolLeaf object) {
		return line(object.getName());
	}

	@Override
	public Object caseBuiltInNode(BuiltInNode object) {
		StringBuffer res = new StringBuffer();
		res.append(line(object.getKeyword()+"["+newline()));
		int offset = object.getChildren().size()-1;
		
		Indent();
		for (Node node : object.getChildren()) {
			res.append(doSwitch(node));
			if((offset--)>0) res.append(',');
			res.append(newline());
		}
		res.append(line("]"));
		UnIndent();
		return res.toString();
	}


	
}
