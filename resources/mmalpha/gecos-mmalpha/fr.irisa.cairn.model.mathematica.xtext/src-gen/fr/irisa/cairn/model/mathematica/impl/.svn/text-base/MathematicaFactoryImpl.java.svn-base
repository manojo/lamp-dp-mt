/**
 * <copyright>
 * </copyright>
 *
 */
package fr.irisa.cairn.model.mathematica.impl;

import fr.irisa.cairn.model.mathematica.*;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EPackage;

import org.eclipse.emf.ecore.impl.EFactoryImpl;

import org.eclipse.emf.ecore.plugin.EcorePlugin;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model <b>Factory</b>.
 * <!-- end-user-doc -->
 * @generated
 */
public class MathematicaFactoryImpl extends EFactoryImpl implements MathematicaFactory
{
  /**
   * Creates the default factory implementation.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public static MathematicaFactory init()
  {
    try
    {
      MathematicaFactory theMathematicaFactory = (MathematicaFactory)EPackage.Registry.INSTANCE.getEFactory("http://www.irisa.fr/cairn/model/Mathematica"); 
      if (theMathematicaFactory != null)
      {
        return theMathematicaFactory;
      }
    }
    catch (Exception exception)
    {
      EcorePlugin.INSTANCE.log(exception);
    }
    return new MathematicaFactoryImpl();
  }

  /**
   * Creates an instance of the factory.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public MathematicaFactoryImpl()
  {
    super();
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public EObject create(EClass eClass)
  {
    switch (eClass.getClassifierID())
    {
      case MathematicaPackage.NODE: return createNode();
      case MathematicaPackage.AST_NODE: return createASTNode();
      case MathematicaPackage.BUILT_IN_NODE: return createBuiltInNode();
      case MathematicaPackage.AST_LEAF: return createASTLeaf();
      case MathematicaPackage.INT_LEAF: return createIntLeaf();
      case MathematicaPackage.STRING_LEAF: return createStringLeaf();
      case MathematicaPackage.SYMBOL_LEAF: return createSymbolLeaf();
      case MathematicaPackage.FLOAT_LEAF: return createFloatLeaf();
      default:
        throw new IllegalArgumentException("The class '" + eClass.getName() + "' is not a valid classifier");
    }
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public Node createNode()
  {
    NodeImpl node = new NodeImpl();
    return node;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public ASTNode createASTNode()
  {
    ASTNodeImpl astNode = new ASTNodeImpl();
    return astNode;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public BuiltInNode createBuiltInNode()
  {
    BuiltInNodeImpl builtInNode = new BuiltInNodeImpl();
    return builtInNode;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public ASTLeaf createASTLeaf()
  {
    ASTLeafImpl astLeaf = new ASTLeafImpl();
    return astLeaf;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public IntLeaf createIntLeaf()
  {
    IntLeafImpl intLeaf = new IntLeafImpl();
    return intLeaf;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public StringLeaf createStringLeaf()
  {
    StringLeafImpl stringLeaf = new StringLeafImpl();
    return stringLeaf;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public SymbolLeaf createSymbolLeaf()
  {
    SymbolLeafImpl symbolLeaf = new SymbolLeafImpl();
    return symbolLeaf;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public FloatLeaf createFloatLeaf()
  {
    FloatLeafImpl floatLeaf = new FloatLeafImpl();
    return floatLeaf;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public MathematicaPackage getMathematicaPackage()
  {
    return (MathematicaPackage)getEPackage();
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @deprecated
   * @generated
   */
  @Deprecated
  public static MathematicaPackage getPackage()
  {
    return MathematicaPackage.eINSTANCE;
  }

} //MathematicaFactoryImpl
