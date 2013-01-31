package fr.irisa.cairn.gecos.bindings.mathematica;

import fr.irisa.cairn.model.mathematica.ASTNode;
import fr.irisa.cairn.model.mathematica.BuiltInNode;
import fr.irisa.cairn.model.mathematica.FloatLeaf;
import fr.irisa.cairn.model.mathematica.IntLeaf;
import fr.irisa.cairn.model.mathematica.MathematicaFactory;
import fr.irisa.cairn.model.mathematica.Node;
import fr.irisa.cairn.model.mathematica.StringLeaf;
import fr.irisa.cairn.model.mathematica.SymbolLeaf;

public class TomFactory {
	private static  MathematicaFactory f = MathematicaFactory.eINSTANCE;
	
	public static BuiltInNode makeBuiltInNode(String name, Node ... children) {
		BuiltInNode res =f.createBuiltInNode();
		res.setKeyword(name);
		for (Node node : children) {
			res.getChildren().add(node);
		}
		return res;
	}

	public static ASTNode makeUserNode(String name, Node ... children) {
		ASTNode res =f.createASTNode();
		res.setName(name);
		for (Node node : children) {
			res.getChildren().add(node);
		}
		return res;
	}
	
	public static BuiltInNode makeBuiltInNode(String name) {
		BuiltInNode res =f.createBuiltInNode();
		res.setKeyword(name);
		return res;
	}

	public static ASTNode makeUserNode(String name) {
		ASTNode res =f.createASTNode();
		res.setName(name);
		return res;
	}

	
	public static IntLeaf makeInt(int value) {
		IntLeaf res =f.createIntLeaf();
		res.setValue(value);
		return res;
	}

	public static StringLeaf makeString(String value) {
		StringLeaf res =f.createStringLeaf();
		res.setValue(value);
		return res;
	}
	
	public static FloatLeaf makeFloat(double value) {
		FloatLeaf res =f.createFloatLeaf();
		throw new UnsupportedOperationException("Not yet implemented");
		//return res;
	}
	
	public static SymbolLeaf makeSymbol(String value) {
		SymbolLeaf res =f.createSymbolLeaf();
		res.setName(value);
		return res;
	}
	
}
