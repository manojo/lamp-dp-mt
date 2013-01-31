package examples;

import java.io.IOException;

import com.wolfram.jlink.MathLinkException;

import fr.irisa.cairn.gecos.bindings.mathematica.MathematicaASTPrinter;
import fr.irisa.cairn.gecos.bindings.mathematica.MathematicaKernel;
import fr.irisa.cairn.model.mathematica.Node;

public class MathematicaCommandExample {
	
	public static void main(String[] args) throws MathLinkException, IOException {
		MathematicaKernel kernel = new MathematicaKernel();
		// Simple mathematica command
		Node res = kernel.execute("Integrate[x^2+x+Log[x],x]");
		// Print resulting Mathematica AST
		System.out.println(MathematicaASTPrinter.getPrinter().printTree(res));
		// save AST as Xmi 
		kernel.saveResultAsXML("simple_command.mathematica");
	}

}
