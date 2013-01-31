package fr.irisa.cairn.gecos.bindings.mathematica;

/********************************************************

 SampleProgram.java

 Code for the simple J/Link example program presented in section 2.3 of
 the J/Link User Guide.

 To compile or run this program, you need to make sure that JLink.jar is in the
 class path. You can do this by setting the CLASSPATH environment variable or
 by specifying the path to JLink.jar using the -classpath option on the command
 line. The examples below use the -classpath option. You can leave this out if
 your CLASSPATH environment variable includes the full path to JLink.jar.
 Consult your Java documentation or the J/Link User Guide for more information.

 To run this program, go to a shell or DOS window and change to the directory in
 which SampleProgram.class resides. Then use a line like:

 (Windows)
 java -classpath ".;\path\to\JLink.jar" SampleProgram -linkmode launch -linkname "c:/program files/wolfram research/mathematica/5.2/mathkernel.exe"

 (Unix)
 java -classpath .:/path/to/JLink.jar SampleProgram -linkmode launch -linkname 'math -mathlink'

 (Mac OS X from a terminal window)
 java -classpath .:/path/to/JLink.jar SampleProgram -linkmode launch -linkname '"/Applications/Mathematica 5.2.app/Contents/MacOS/MathKernel" -mathlink'



 If you wish to compile this program, use a line like this:

 (Windows)
 javac -classpath ".;\path\to\JLink.jar" SampleProgram.java

 (Unix, or Mac OS X from a terminal window)
 javac -classpath .:/path/to/JLink.jar SampleProgram.java


 ************************************************************/

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl;

import com.wolfram.jlink.KernelLink;
import com.wolfram.jlink.MathLinkException;
import com.wolfram.jlink.MathLinkFactory;

import fr.irisa.cairn.model.mathematica.MathematicaPackage;
import fr.irisa.cairn.model.mathematica.Node;

public class MathematicaKernel {

	static final String mathematicaExecPath = "/mntb/opt/mathematica7/Executables/math";

	KernelLink ml ;

	private Node result;

	public MathematicaKernel() throws MathLinkException {

		ml = MathLinkFactory
				.createKernelLink("-linkmode launch -linkname '"
						+ mathematicaExecPath + " -mathlink'");
		
		if (ml==null) {
			throw new RuntimeException("Mathematic link error");
		}

	}


	public void saveResultAsXML(String modelfilename)
			throws IOException {
		if (result!=null) {
		ResourceSet resourceSet = new ResourceSetImpl();
		resourceSet.getResourceFactoryRegistry().getExtensionToFactoryMap()
				.put(Resource.Factory.Registry.DEFAULT_EXTENSION,
						new XMIResourceFactoryImpl());

		resourceSet.getPackageRegistry().put(MathematicaPackage.eNS_URI,
				MathematicaPackage.eINSTANCE);

		Resource resource = resourceSet.createResource(URI
				.createFileURI(modelfilename));
		resource.getContents().add(result);
		resource.save(null);
		} else {
			throw new UnsupportedOperationException("No result to save");
		}
	}


	public Node execute(Node input) throws MathLinkException, IOException {
		if (ml!=null) {
			ml.discardAnswer();
			String inputCommand = "FullForm[" + MathematicaASTPrinter.getPrinter().print(input) + "]";
			String resultString = ml.evaluateToOutputForm(inputCommand, 0);
			 result = MathematicaASTBuilder.buildASTFromString(resultString);
			
			return result;
		} else {
			throw new RuntimeException("Lost link ...");
		}
	}

	public Node execute(String txt) throws MathLinkException, IOException {
		ml.discardAnswer();
		String inputCommand = "FullForm[" + txt + "]";
		String resultString = ml.evaluateToOutputForm(inputCommand, 0);
		result = MathematicaASTBuilder.buildASTFromString(resultString);
		if (result==null) {
			throw new RuntimeException("Mathematica command did not return any result");
		}
		return result;
	}

	private static String readFile(File file) throws IOException {
	    Reader in = new BufferedReader(new FileReader(file));

	    StringBuilder sb = new StringBuilder();
	    char[] chars = new char[1 << 16];
	    int length;
	    
	    while ((length = in.read(chars)) > 0) {
	      sb.append(chars, 0, length);
	    }

	    return sb.toString();
	  }

	public Node executeProtected(File file) throws MathLinkException, IOException {
		return executeProtected(readFile(file));
	}
	
	public Node execute(File file) throws MathLinkException, IOException {
		return execute(readFile(file));
	}

	public Node executeProtected(String txt) throws MathLinkException, IOException {
		ml.discardAnswer();
		String inputCommand = "FullForm[Protect[" + txt + "]]";
		String resultString = ml.evaluateToOutputForm(inputCommand, 0);
		 result = MathematicaASTBuilder.buildASTFromString(resultString);
		if (result==null) {
			throw new RuntimeException("Mathematica command did not return any result");
		}
		
		return result;
	}
	
	protected void finalize() {
		ml.close();
	}

}
