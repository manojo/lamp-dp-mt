package examples;

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

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl;
import org.eclipse.xtext.ISetup;
import org.eclipse.xtext.resource.IResourceFactory;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.resource.XtextResourceSet;

import com.google.inject.Injector;
import com.wolfram.jlink.KernelLink;
import com.wolfram.jlink.MathLinkException;
import com.wolfram.jlink.MathLinkFactory;

import fr.irisa.cairn.gecos.bindings.mathematica.MathematicaASTPrinter;
import fr.irisa.cairn.model.MathematicaStandaloneSetup;
import fr.irisa.cairn.model.mathematica.MathematicaPackage;
import fr.irisa.cairn.model.mathematica.Node;

public class SampleProgram {

		
	private static Node parse(String ast) throws IOException {
		InputStream in = new ByteArrayInputStream(ast.getBytes());

		ISetup instance = new MathematicaStandaloneSetup();
		Injector injector = instance.createInjectorAndDoEMFRegistration();

		XtextResourceSet rs = injector.getInstance(XtextResourceSet.class);
		IResourceFactory factory = injector.getInstance(IResourceFactory.class);
		XtextResource r = (XtextResource) factory.createResource(URI
				.createURI("internal.test"));
		rs.getResources().add(r);
		r.load(in, null);
		EcoreUtil.resolveAll(r);

		EObject root = r.getParseResult().getRootASTElement();
		Node toplevel = (Node) root;
		return toplevel;
	}

	public static void saveAsXML(Node seq, String modelfilename)
			throws IOException {
		ResourceSet resourceSet = new ResourceSetImpl();
		resourceSet.getResourceFactoryRegistry().getExtensionToFactoryMap()
				.put(Resource.Factory.Registry.DEFAULT_EXTENSION,
						new XMIResourceFactoryImpl());

		resourceSet.getPackageRegistry().put(MathematicaPackage.eNS_URI,
				MathematicaPackage.eINSTANCE);

		Resource resource = resourceSet.createResource(URI
				.createFileURI(modelfilename));
		resource.getContents().add(seq);
		resource.save(null);
	}

	static final String mathematica = "-linkmode launch -linkname '/mntd/opt/mathematica7/Executables/math -mathlink'";

	public static void main(String[] argv)  {

		KernelLink ml = null;

		try {
			// must make sure that the system environment 
			// variable MMALPHA is set in Eclipse (run configuration)
			ml = MathLinkFactory.createKernelLink(mathematica);

		} catch (MathLinkException e) {
			System.out.println("Fatal error opening link: " + e.getMessage());
			return;
		} try {
			// Get rid of the initial InputNamePacket the kernel will send
			// when it is launched.
			ml.discardAnswer();
			//String string = "FullForm[load[\"/home/sderrien/workspace/fr.irisa.cairn.gecos.mmalpha/Examples/MV1.alpha\"]]";
			//String string =  ;//"Needs[\"Alpha`Options`\"];Needs[\"Alpha`Domlib`\"];Needs[\"Alpha`\"];";
			//String string =  "Directory[]";//FullForm[ readDom[\"{i,j|0<=i;j>=0}\"]]";
			String string = "FullForm[Integrate[x^2+x+Log[x],x]]";
			String output = ml.evaluateToOutputForm(string, 0);
			System.out.println(string + "= " + output);
			try {
				Node ast= parse(output);
				System.out.println(MathematicaASTPrinter.getPrinter().printTree(ast));
				saveAsXML(ast, "test.xmi");

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			ml.evaluate("<<MyPackage.m");
			ml.discardAnswer();

			ml.evaluate("2+2");
			ml.waitForAnswer();
			int result = ml.getInteger();
			System.out.println("2 + 2 = " + result);

			// Heres how to send the same input, but not as a string:
			ml.putFunction("EvaluatePacket", 1);
			ml.putFunction("Plus", 2);
			ml.put(3);
			ml.put(3);
			ml.endPacket();
			ml.waitForAnswer();
			result = ml.getInteger();
			System.out.println("3 + 3 = " + result);

			// If you want the result back as a string, use evaluateToInputForm or
			// evaluateToOutputForm. The second arg for either is the requested page
			// width for formatting the string. Pass 0 for PageWidth->Infinity.
			// These methods get the result in one step--no need to call waitForAnswer.
			String strResult = ml.evaluateToOutputForm("4+4", 0);
			System.out.println("4 + 4 = " + strResult);

		} catch (MathLinkException e) {
			System.out.println("MathLinkException occurred: " + e.getMessage());
		} finally {
			ml.close();
		}
//		KernelLink ml = null;
//
//		try {
//			ml = MathLinkFactory.createKernelLink(mathematica);
//		} catch (MathLinkException e) {
//			System.out.println("Fatal error opening link: " + e.getMessage());
//			return;
//		}
//
//		try {
//			String string = "FullForm[2+3]";
//			String output = ml.evaluateToOutputForm(string, 0);
//			System.out.println(string + "= " + output);
//			//Node ast= parse(output);
//			//ASTPrettyPrinter pp =new ASTPrettyPrinter(ast);
//			//pp.print();
//			//saveAsXML(ast, "test.xmi");
//			System.out.println("done");
//
//		} catch (MathException e) {
//			System.out.println("Exception occurred: " + e.getMessage());
//		} finally {
//			ml.close();
//		}
	}
}
