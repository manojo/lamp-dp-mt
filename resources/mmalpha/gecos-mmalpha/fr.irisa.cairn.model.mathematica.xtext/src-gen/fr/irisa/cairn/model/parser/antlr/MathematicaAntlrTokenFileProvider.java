/*
* generated by Xtext
*/
package fr.irisa.cairn.model.parser.antlr;

import java.io.InputStream;
import org.eclipse.xtext.parser.antlr.IAntlrTokenFileProvider;

public class MathematicaAntlrTokenFileProvider implements IAntlrTokenFileProvider {
	
	public InputStream getAntlrTokenFile() {
		ClassLoader classLoader = getClass().getClassLoader();
    	return classLoader.getResourceAsStream("fr/irisa/cairn/model/parser/antlr/internal/InternalMathematica.tokens");
	}
}