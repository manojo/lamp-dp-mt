
package fr.irisa.cairn.model;

/**
 * Initialization support for running Xtext languages 
 * without equinox extension registry
 */
public class MathematicaStandaloneSetup extends MathematicaStandaloneSetupGenerated{

	public static void doSetup() {
		new MathematicaStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
}

