package fr.irisa.cairn.gecos.bindings.mathematica;

import fr.irisa.cairn.model.mathematica.ASTNode;
import fr.irisa.cairn.model.mathematica.BuiltInNode;
import fr.irisa.cairn.model.mathematica.Node;

public class TomUtils {

	static Node add(Node node, Node value) {
		if (node instanceof BuiltInNode) {
			((BuiltInNode) node).getChildren().add(value);
			return node;
		}
		if (node instanceof ASTNode) {
			((ASTNode) node).getChildren().add(value);
			return node;
		}
		throw new UnsupportedOperationException("Not yet implemented");
	}
}
