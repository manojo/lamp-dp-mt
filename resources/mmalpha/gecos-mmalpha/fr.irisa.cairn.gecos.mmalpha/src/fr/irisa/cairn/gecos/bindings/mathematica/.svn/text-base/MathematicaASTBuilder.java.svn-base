package fr.irisa.cairn.gecos.bindings.mathematica;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.xtext.ISetup;
import org.eclipse.xtext.resource.IResourceFactory;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.resource.XtextResourceSet;

import com.google.inject.Injector;

import fr.irisa.cairn.model.MathematicaStandaloneSetup;
import fr.irisa.cairn.model.mathematica.Node;

public class MathematicaASTBuilder {

	public static Node buildASTFromString(String ast) throws IOException {
		if (ast.length()==0) {
			throw new RuntimeException("Error, cannot parse empty string");
		}
			
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
		
		if (toplevel==null) {
			throw new RuntimeException("Error, this is not a valid Mathematica AST");
		}
		return toplevel;
	}


//	public MyWeb load() {
//		// Initialize the model
//		WebsitePackage.eINSTANCE.eClass();
//		
//		// Register the XMI resource factory for the .website extension
//
//		Resource.Factory.Registry reg = Resource.Factory.Registry.INSTANCE;
//		Map<String, Object> m = reg.getExtensionToFactoryMap();
//		m.put("website", new XMIResourceFactoryImpl());
//
//		// Obtain a new resource set
//		ResourceSet resSet = new ResourceSetImpl();
//
//		// Get the resource
//		Resource resource = resSet.getResource(URI
//				.createURI("website/My.website"), true);
//		// Get the first model element and cast it to the right type, in my
//		// example everything is hierarchical included in this first node
//		MyWeb myWeb = (MyWeb) resource.getContents().get(0);
//		return myWeb;
//	}

}
