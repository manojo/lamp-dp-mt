
/*
 * generated by Xtext
 */
 
package fr.irisa.cairn.model.ui;

import org.eclipse.xtext.ui.guice.AbstractGuiceAwareExecutableExtensionFactory;
import org.osgi.framework.Bundle;

import com.google.inject.Injector;

/**
 *@generated
 */
public class MathematicaExecutableExtensionFactory extends AbstractGuiceAwareExecutableExtensionFactory {

	@Override
	protected Bundle getBundle() {
		return fr.irisa.cairn.model.ui.internal.MathematicaActivator.getInstance().getBundle();
	}
	
	@Override
	protected Injector getInjector() {
		return fr.irisa.cairn.model.ui.internal.MathematicaActivator.getInstance().getInjector("fr.irisa.cairn.model.Mathematica");
	}
	
}
