package examples;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;

import com.wolfram.jlink.MathLinkException;

import fr.irisa.cairn.gecos.bindings.mathematica.MathematicaKernel;
import fr.irisa.cairn.model.mathematica.Node;

public class MathematicaParser {

	static MathematicaKernel kernel;
	public static void main(String[] args) throws MathLinkException,
			IOException {
		File dir = new File("Examples/MMAlpha");
		
		if (dir.isDirectory()) {
			File[] files = dir.listFiles(new FileFilter() {
				public boolean accept(File arg0) {
					if (arg0.getName().endsWith(".m"))
						return true;
					return false;
				}
			});
			
			for (File file : files) {
				System.out.println("File :"+file.getAbsolutePath());
				parseMathematicaSource(file);
			}

		}
	}

	private static void parseMathematicaSource(File file) throws MathLinkException, IOException {
		kernel = new MathematicaKernel();
		Node res = kernel.executeProtected(file);
		String newname = file.getAbsolutePath()+ ".mathematica";
		System.out.println("Saving AST as :"+newname);
		kernel.saveResultAsXML(newname);
		//System.out.println(MathematicaASTPrinter.getPrinter().printTree(res));
	}

}
