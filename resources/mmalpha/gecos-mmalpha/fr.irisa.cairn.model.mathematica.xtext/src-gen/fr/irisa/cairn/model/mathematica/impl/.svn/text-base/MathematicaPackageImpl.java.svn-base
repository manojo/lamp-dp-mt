/**
 * <copyright>
 * </copyright>
 *
 */
package fr.irisa.cairn.model.mathematica.impl;

import fr.irisa.cairn.model.mathematica.ASTLeaf;
import fr.irisa.cairn.model.mathematica.ASTNode;
import fr.irisa.cairn.model.mathematica.BuiltInNode;
import fr.irisa.cairn.model.mathematica.FloatLeaf;
import fr.irisa.cairn.model.mathematica.IntLeaf;
import fr.irisa.cairn.model.mathematica.MathematicaFactory;
import fr.irisa.cairn.model.mathematica.MathematicaPackage;
import fr.irisa.cairn.model.mathematica.Node;
import fr.irisa.cairn.model.mathematica.StringLeaf;
import fr.irisa.cairn.model.mathematica.SymbolLeaf;

import org.eclipse.emf.ecore.EAttribute;
import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.EReference;

import org.eclipse.emf.ecore.impl.EPackageImpl;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model <b>Package</b>.
 * <!-- end-user-doc -->
 * @generated
 */
public class MathematicaPackageImpl extends EPackageImpl implements MathematicaPackage
{
  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  private EClass nodeEClass = null;

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  private EClass astNodeEClass = null;

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  private EClass builtInNodeEClass = null;

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  private EClass astLeafEClass = null;

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  private EClass intLeafEClass = null;

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  private EClass stringLeafEClass = null;

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  private EClass symbolLeafEClass = null;

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  private EClass floatLeafEClass = null;

  /**
   * Creates an instance of the model <b>Package</b>, registered with
   * {@link org.eclipse.emf.ecore.EPackage.Registry EPackage.Registry} by the package
   * package URI value.
   * <p>Note: the correct way to create the package is via the static
   * factory method {@link #init init()}, which also performs
   * initialization of the package, or returns the registered package,
   * if one already exists.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see org.eclipse.emf.ecore.EPackage.Registry
   * @see fr.irisa.cairn.model.mathematica.MathematicaPackage#eNS_URI
   * @see #init()
   * @generated
   */
  private MathematicaPackageImpl()
  {
    super(eNS_URI, MathematicaFactory.eINSTANCE);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  private static boolean isInited = false;

  /**
   * Creates, registers, and initializes the <b>Package</b> for this model, and for any others upon which it depends.
   * 
   * <p>This method is used to initialize {@link MathematicaPackage#eINSTANCE} when that field is accessed.
   * Clients should not invoke it directly. Instead, they should simply access that field to obtain the package.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #eNS_URI
   * @see #createPackageContents()
   * @see #initializePackageContents()
   * @generated
   */
  public static MathematicaPackage init()
  {
    if (isInited) return (MathematicaPackage)EPackage.Registry.INSTANCE.getEPackage(MathematicaPackage.eNS_URI);

    // Obtain or create and register package
    MathematicaPackageImpl theMathematicaPackage = (MathematicaPackageImpl)(EPackage.Registry.INSTANCE.get(eNS_URI) instanceof MathematicaPackageImpl ? EPackage.Registry.INSTANCE.get(eNS_URI) : new MathematicaPackageImpl());

    isInited = true;

    // Create package meta-data objects
    theMathematicaPackage.createPackageContents();

    // Initialize created meta-data
    theMathematicaPackage.initializePackageContents();

    // Mark meta-data to indicate it can't be changed
    theMathematicaPackage.freeze();

  
    // Update the registry and return the package
    EPackage.Registry.INSTANCE.put(MathematicaPackage.eNS_URI, theMathematicaPackage);
    return theMathematicaPackage;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EClass getNode()
  {
    return nodeEClass;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EClass getASTNode()
  {
    return astNodeEClass;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EAttribute getASTNode_Name()
  {
    return (EAttribute)astNodeEClass.getEStructuralFeatures().get(0);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EReference getASTNode_Children()
  {
    return (EReference)astNodeEClass.getEStructuralFeatures().get(1);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EClass getBuiltInNode()
  {
    return builtInNodeEClass;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EAttribute getBuiltInNode_Keyword()
  {
    return (EAttribute)builtInNodeEClass.getEStructuralFeatures().get(0);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EReference getBuiltInNode_Children()
  {
    return (EReference)builtInNodeEClass.getEStructuralFeatures().get(1);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EClass getASTLeaf()
  {
    return astLeafEClass;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EClass getIntLeaf()
  {
    return intLeafEClass;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EAttribute getIntLeaf_Signed()
  {
    return (EAttribute)intLeafEClass.getEStructuralFeatures().get(0);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EAttribute getIntLeaf_Value()
  {
    return (EAttribute)intLeafEClass.getEStructuralFeatures().get(1);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EClass getStringLeaf()
  {
    return stringLeafEClass;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EAttribute getStringLeaf_Value()
  {
    return (EAttribute)stringLeafEClass.getEStructuralFeatures().get(0);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EClass getSymbolLeaf()
  {
    return symbolLeafEClass;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EAttribute getSymbolLeaf_Name()
  {
    return (EAttribute)symbolLeafEClass.getEStructuralFeatures().get(0);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EClass getFloatLeaf()
  {
    return floatLeafEClass;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EAttribute getFloatLeaf_Signed()
  {
    return (EAttribute)floatLeafEClass.getEStructuralFeatures().get(0);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EAttribute getFloatLeaf_A()
  {
    return (EAttribute)floatLeafEClass.getEStructuralFeatures().get(1);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EAttribute getFloatLeaf_B()
  {
    return (EAttribute)floatLeafEClass.getEStructuralFeatures().get(2);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public MathematicaFactory getMathematicaFactory()
  {
    return (MathematicaFactory)getEFactoryInstance();
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  private boolean isCreated = false;

  /**
   * Creates the meta-model objects for the package.  This method is
   * guarded to have no affect on any invocation but its first.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public void createPackageContents()
  {
    if (isCreated) return;
    isCreated = true;

    // Create classes and their features
    nodeEClass = createEClass(NODE);

    astNodeEClass = createEClass(AST_NODE);
    createEAttribute(astNodeEClass, AST_NODE__NAME);
    createEReference(astNodeEClass, AST_NODE__CHILDREN);

    builtInNodeEClass = createEClass(BUILT_IN_NODE);
    createEAttribute(builtInNodeEClass, BUILT_IN_NODE__KEYWORD);
    createEReference(builtInNodeEClass, BUILT_IN_NODE__CHILDREN);

    astLeafEClass = createEClass(AST_LEAF);

    intLeafEClass = createEClass(INT_LEAF);
    createEAttribute(intLeafEClass, INT_LEAF__SIGNED);
    createEAttribute(intLeafEClass, INT_LEAF__VALUE);

    stringLeafEClass = createEClass(STRING_LEAF);
    createEAttribute(stringLeafEClass, STRING_LEAF__VALUE);

    symbolLeafEClass = createEClass(SYMBOL_LEAF);
    createEAttribute(symbolLeafEClass, SYMBOL_LEAF__NAME);

    floatLeafEClass = createEClass(FLOAT_LEAF);
    createEAttribute(floatLeafEClass, FLOAT_LEAF__SIGNED);
    createEAttribute(floatLeafEClass, FLOAT_LEAF__A);
    createEAttribute(floatLeafEClass, FLOAT_LEAF__B);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  private boolean isInitialized = false;

  /**
   * Complete the initialization of the package and its meta-model.  This
   * method is guarded to have no affect on any invocation but its first.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public void initializePackageContents()
  {
    if (isInitialized) return;
    isInitialized = true;

    // Initialize package
    setName(eNAME);
    setNsPrefix(eNS_PREFIX);
    setNsURI(eNS_URI);

    // Create type parameters

    // Set bounds for type parameters

    // Add supertypes to classes
    astNodeEClass.getESuperTypes().add(this.getNode());
    builtInNodeEClass.getESuperTypes().add(this.getNode());
    astLeafEClass.getESuperTypes().add(this.getNode());
    intLeafEClass.getESuperTypes().add(this.getASTLeaf());
    stringLeafEClass.getESuperTypes().add(this.getASTLeaf());
    symbolLeafEClass.getESuperTypes().add(this.getASTLeaf());
    floatLeafEClass.getESuperTypes().add(this.getASTLeaf());

    // Initialize classes and features; add operations and parameters
    initEClass(nodeEClass, Node.class, "Node", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);

    initEClass(astNodeEClass, ASTNode.class, "ASTNode", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
    initEAttribute(getASTNode_Name(), ecorePackage.getEString(), "name", null, 0, 1, ASTNode.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
    initEReference(getASTNode_Children(), this.getNode(), null, "children", null, 0, -1, ASTNode.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, IS_COMPOSITE, !IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

    initEClass(builtInNodeEClass, BuiltInNode.class, "BuiltInNode", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
    initEAttribute(getBuiltInNode_Keyword(), ecorePackage.getEString(), "keyword", null, 0, 1, BuiltInNode.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
    initEReference(getBuiltInNode_Children(), this.getNode(), null, "children", null, 0, -1, BuiltInNode.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, IS_COMPOSITE, !IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

    initEClass(astLeafEClass, ASTLeaf.class, "ASTLeaf", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);

    initEClass(intLeafEClass, IntLeaf.class, "IntLeaf", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
    initEAttribute(getIntLeaf_Signed(), ecorePackage.getEString(), "signed", null, 0, 1, IntLeaf.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
    initEAttribute(getIntLeaf_Value(), ecorePackage.getEInt(), "value", null, 0, 1, IntLeaf.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

    initEClass(stringLeafEClass, StringLeaf.class, "StringLeaf", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
    initEAttribute(getStringLeaf_Value(), ecorePackage.getEString(), "value", null, 0, 1, StringLeaf.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

    initEClass(symbolLeafEClass, SymbolLeaf.class, "SymbolLeaf", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
    initEAttribute(getSymbolLeaf_Name(), ecorePackage.getEString(), "name", null, 0, 1, SymbolLeaf.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

    initEClass(floatLeafEClass, FloatLeaf.class, "FloatLeaf", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
    initEAttribute(getFloatLeaf_Signed(), ecorePackage.getEString(), "signed", null, 0, 1, FloatLeaf.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
    initEAttribute(getFloatLeaf_A(), ecorePackage.getEInt(), "a", null, 0, 1, FloatLeaf.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
    initEAttribute(getFloatLeaf_B(), ecorePackage.getEInt(), "b", null, 0, 1, FloatLeaf.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

    // Create resource
    createResource(eNS_URI);
  }

} //MathematicaPackageImpl
