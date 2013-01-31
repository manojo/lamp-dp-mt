package  fr.irisa.cairn.gecos.bindings.mathematica;
import fr.irisa.cairn.model.mathematica.BuiltInNode;
import fr.irisa.cairn.model.mathematica.IntLeaf;
import fr.irisa.cairn.model.mathematica.Node;

public class TomPatternMatchingExample{

	%include{MathematicaAST.tom}
 
	public static boolean isBuiltIn(Node node, String type) {
		if (node instanceof BuiltInNode) {
	 		BuiltInNode bnode = (BuiltInNode ) node;
			if (bnode.getKeyword().equals(type)) return true;
		}
		return false; 
	}
 
	public static void main(String[] args) {
		 

	    Node c1 = `Set(Int(4),Int(2));
	    Node c2 = `List(Int(6),Sym("pol"),Int(1));
	    Node c3 = `Module(Int(1),Int(-1),Int(6),Int(1));
	  
	    %match (c1) {
		      Set(Int(a),Int(b)) -> { 
		        System.out.println("this operation computes " + 
		        		(`a)  +"+"+ (`b) +"="+(`Int(a+b))); 
		      }
		    }
	    %match (c2) {
		      List(Int(a),_*,Int(b)) -> { 
		        System.out.println("this List has two constant integer as elements"); 
		      }
		    }
	    %match (c3) {
		      Module(Int(_),_*,Int(_)) -> { 
		        System.out.println("this Module node has at leats int constant operands"); 
		      }
		    }

	}
}