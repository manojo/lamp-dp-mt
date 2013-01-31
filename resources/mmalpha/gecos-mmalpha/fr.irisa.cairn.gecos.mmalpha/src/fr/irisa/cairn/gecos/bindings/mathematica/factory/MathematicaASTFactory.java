package fr.irisa.cairn.gecos.bindings.mathematica.factory;

import fr.irisa.cairn.model.mathematica.ASTNode;
import fr.irisa.cairn.model.mathematica.FloatLeaf;
import fr.irisa.cairn.model.mathematica.IntLeaf;
import fr.irisa.cairn.model.mathematica.Node;
import fr.irisa.cairn.model.mathematica.SymbolLeaf;
import fr.irisa.cairn.model.mathematica.impl.MathematicaFactoryImpl;


public class MathematicaASTFactory  {
	static MathematicaFactoryImpl internal = new MathematicaFactoryImpl();

	public static Node namedNode(String name, Node... children) {
		ASTNode node = internal.createASTNode();
		node.setName(name);
		for (Node child: children) {
			node.getChildren().add(child);
		}
		return node;
	}
	
	public static Node List(Node... children) {
		return namedNode("List", children);
	}

	public static Node domain(int nbdim, Node indices, Node ... children) {
		return namedNode("List", children);
	}
	public static Node pol(int a, int b, int c, int d, Node... children) {
		return namedNode("pol", List(Int(a),Int(b),Int(c),Int(d)),List(children));
	}

	public static Node Int(int value) {
		IntLeaf node = internal.createIntLeaf();
		node.setValue(value);
		return node;
	}

	public static Node Symbol(String name) {
		SymbolLeaf node = internal.createSymbolLeaf();
		node.setName(name);
		return node;
	}

	public static Node Float(double value) {
		FloatLeaf node = internal.createFloatLeaf();
		node.setA((int)value);
		node.setB((int) (value - (int)value));
		return node;
	}
}

