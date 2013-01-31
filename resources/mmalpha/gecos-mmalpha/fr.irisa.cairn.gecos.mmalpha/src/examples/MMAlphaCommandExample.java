package examples;

import java.io.IOException;

import com.wolfram.jlink.MathLinkException;

import fr.irisa.cairn.gecos.bindings.mathematica.MathematicaASTPrinter;
import fr.irisa.cairn.gecos.bindings.mathematica.MathematicaKernel;
import fr.irisa.cairn.model.mathematica.Node;

public class MMAlphaCommandExample {
	
	public static void main(String[] args) throws MathLinkException, IOException {
		MathematicaKernel kernel = new MathematicaKernel();
		Node res = kernel.execute("load[\"/home/sderrien/workspace-helios/fr.irisa.cairn.gecos.mmalpha/Examples/MV1.alpha\"]");
		kernel.saveResultAsXML("Examples/MV1_alpha.mathematica");
		System.out.println(MathematicaASTPrinter.getPrinter().printTree(res));
	}

}
