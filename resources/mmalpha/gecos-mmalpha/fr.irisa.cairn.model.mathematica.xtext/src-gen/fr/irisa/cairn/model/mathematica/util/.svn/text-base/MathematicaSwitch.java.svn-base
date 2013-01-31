/**
 * <copyright>
 * </copyright>
 *
 */
package fr.irisa.cairn.model.mathematica.util;

import fr.irisa.cairn.model.mathematica.*;

import java.util.List;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * The <b>Switch</b> for the model's inheritance hierarchy.
 * It supports the call {@link #doSwitch(EObject) doSwitch(object)}
 * to invoke the <code>caseXXX</code> method for each class of the model,
 * starting with the actual class of the object
 * and proceeding up the inheritance hierarchy
 * until a non-null result is returned,
 * which is the result of the switch.
 * <!-- end-user-doc -->
 * @see fr.irisa.cairn.model.mathematica.MathematicaPackage
 * @generated
 */
public class MathematicaSwitch<T>
{
  /**
   * The cached model package
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  protected static MathematicaPackage modelPackage;

  /**
   * Creates an instance of the switch.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public MathematicaSwitch()
  {
    if (modelPackage == null)
    {
      modelPackage = MathematicaPackage.eINSTANCE;
    }
  }

  /**
   * Calls <code>caseXXX</code> for each class of the model until one returns a non null result; it yields that result.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @return the first non-null result returned by a <code>caseXXX</code> call.
   * @generated
   */
  public T doSwitch(EObject theEObject)
  {
    return doSwitch(theEObject.eClass(), theEObject);
  }

  /**
   * Calls <code>caseXXX</code> for each class of the model until one returns a non null result; it yields that result.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @return the first non-null result returned by a <code>caseXXX</code> call.
   * @generated
   */
  protected T doSwitch(EClass theEClass, EObject theEObject)
  {
    if (theEClass.eContainer() == modelPackage)
    {
      return doSwitch(theEClass.getClassifierID(), theEObject);
    }
    else
    {
      List<EClass> eSuperTypes = theEClass.getESuperTypes();
      return
        eSuperTypes.isEmpty() ?
          defaultCase(theEObject) :
          doSwitch(eSuperTypes.get(0), theEObject);
    }
  }

  /**
   * Calls <code>caseXXX</code> for each class of the model until one returns a non null result; it yields that result.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @return the first non-null result returned by a <code>caseXXX</code> call.
   * @generated
   */
  protected T doSwitch(int classifierID, EObject theEObject)
  {
    switch (classifierID)
    {
      case MathematicaPackage.NODE:
      {
        Node node = (Node)theEObject;
        T result = caseNode(node);
        if (result == null) result = defaultCase(theEObject);
        return result;
      }
      case MathematicaPackage.AST_NODE:
      {
        ASTNode astNode = (ASTNode)theEObject;
        T result = caseASTNode(astNode);
        if (result == null) result = caseNode(astNode);
        if (result == null) result = defaultCase(theEObject);
        return result;
      }
      case MathematicaPackage.BUILT_IN_NODE:
      {
        BuiltInNode builtInNode = (BuiltInNode)theEObject;
        T result = caseBuiltInNode(builtInNode);
        if (result == null) result = caseNode(builtInNode);
        if (result == null) result = defaultCase(theEObject);
        return result;
      }
      case MathematicaPackage.AST_LEAF:
      {
        ASTLeaf astLeaf = (ASTLeaf)theEObject;
        T result = caseASTLeaf(astLeaf);
        if (result == null) result = caseNode(astLeaf);
        if (result == null) result = defaultCase(theEObject);
        return result;
      }
      case MathematicaPackage.INT_LEAF:
      {
        IntLeaf intLeaf = (IntLeaf)theEObject;
        T result = caseIntLeaf(intLeaf);
        if (result == null) result = caseASTLeaf(intLeaf);
        if (result == null) result = caseNode(intLeaf);
        if (result == null) result = defaultCase(theEObject);
        return result;
      }
      case MathematicaPackage.STRING_LEAF:
      {
        StringLeaf stringLeaf = (StringLeaf)theEObject;
        T result = caseStringLeaf(stringLeaf);
        if (result == null) result = caseASTLeaf(stringLeaf);
        if (result == null) result = caseNode(stringLeaf);
        if (result == null) result = defaultCase(theEObject);
        return result;
      }
      case MathematicaPackage.SYMBOL_LEAF:
      {
        SymbolLeaf symbolLeaf = (SymbolLeaf)theEObject;
        T result = caseSymbolLeaf(symbolLeaf);
        if (result == null) result = caseASTLeaf(symbolLeaf);
        if (result == null) result = caseNode(symbolLeaf);
        if (result == null) result = defaultCase(theEObject);
        return result;
      }
      case MathematicaPackage.FLOAT_LEAF:
      {
        FloatLeaf floatLeaf = (FloatLeaf)theEObject;
        T result = caseFloatLeaf(floatLeaf);
        if (result == null) result = caseASTLeaf(floatLeaf);
        if (result == null) result = caseNode(floatLeaf);
        if (result == null) result = defaultCase(theEObject);
        return result;
      }
      default: return defaultCase(theEObject);
    }
  }

  /**
   * Returns the result of interpreting the object as an instance of '<em>Node</em>'.
   * <!-- begin-user-doc -->
   * This implementation returns null;
   * returning a non-null result will terminate the switch.
   * <!-- end-user-doc -->
   * @param object the target of the switch.
   * @return the result of interpreting the object as an instance of '<em>Node</em>'.
   * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
   * @generated
   */
  public T caseNode(Node object)
  {
    return null;
  }

  /**
   * Returns the result of interpreting the object as an instance of '<em>AST Node</em>'.
   * <!-- begin-user-doc -->
   * This implementation returns null;
   * returning a non-null result will terminate the switch.
   * <!-- end-user-doc -->
   * @param object the target of the switch.
   * @return the result of interpreting the object as an instance of '<em>AST Node</em>'.
   * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
   * @generated
   */
  public T caseASTNode(ASTNode object)
  {
    return null;
  }

  /**
   * Returns the result of interpreting the object as an instance of '<em>Built In Node</em>'.
   * <!-- begin-user-doc -->
   * This implementation returns null;
   * returning a non-null result will terminate the switch.
   * <!-- end-user-doc -->
   * @param object the target of the switch.
   * @return the result of interpreting the object as an instance of '<em>Built In Node</em>'.
   * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
   * @generated
   */
  public T caseBuiltInNode(BuiltInNode object)
  {
    return null;
  }

  /**
   * Returns the result of interpreting the object as an instance of '<em>AST Leaf</em>'.
   * <!-- begin-user-doc -->
   * This implementation returns null;
   * returning a non-null result will terminate the switch.
   * <!-- end-user-doc -->
   * @param object the target of the switch.
   * @return the result of interpreting the object as an instance of '<em>AST Leaf</em>'.
   * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
   * @generated
   */
  public T caseASTLeaf(ASTLeaf object)
  {
    return null;
  }

  /**
   * Returns the result of interpreting the object as an instance of '<em>Int Leaf</em>'.
   * <!-- begin-user-doc -->
   * This implementation returns null;
   * returning a non-null result will terminate the switch.
   * <!-- end-user-doc -->
   * @param object the target of the switch.
   * @return the result of interpreting the object as an instance of '<em>Int Leaf</em>'.
   * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
   * @generated
   */
  public T caseIntLeaf(IntLeaf object)
  {
    return null;
  }

  /**
   * Returns the result of interpreting the object as an instance of '<em>String Leaf</em>'.
   * <!-- begin-user-doc -->
   * This implementation returns null;
   * returning a non-null result will terminate the switch.
   * <!-- end-user-doc -->
   * @param object the target of the switch.
   * @return the result of interpreting the object as an instance of '<em>String Leaf</em>'.
   * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
   * @generated
   */
  public T caseStringLeaf(StringLeaf object)
  {
    return null;
  }

  /**
   * Returns the result of interpreting the object as an instance of '<em>Symbol Leaf</em>'.
   * <!-- begin-user-doc -->
   * This implementation returns null;
   * returning a non-null result will terminate the switch.
   * <!-- end-user-doc -->
   * @param object the target of the switch.
   * @return the result of interpreting the object as an instance of '<em>Symbol Leaf</em>'.
   * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
   * @generated
   */
  public T caseSymbolLeaf(SymbolLeaf object)
  {
    return null;
  }

  /**
   * Returns the result of interpreting the object as an instance of '<em>Float Leaf</em>'.
   * <!-- begin-user-doc -->
   * This implementation returns null;
   * returning a non-null result will terminate the switch.
   * <!-- end-user-doc -->
   * @param object the target of the switch.
   * @return the result of interpreting the object as an instance of '<em>Float Leaf</em>'.
   * @see #doSwitch(org.eclipse.emf.ecore.EObject) doSwitch(EObject)
   * @generated
   */
  public T caseFloatLeaf(FloatLeaf object)
  {
    return null;
  }

  /**
   * Returns the result of interpreting the object as an instance of '<em>EObject</em>'.
   * <!-- begin-user-doc -->
   * This implementation returns null;
   * returning a non-null result will terminate the switch, but this is the last case anyway.
   * <!-- end-user-doc -->
   * @param object the target of the switch.
   * @return the result of interpreting the object as an instance of '<em>EObject</em>'.
   * @see #doSwitch(org.eclipse.emf.ecore.EObject)
   * @generated
   */
  public T defaultCase(EObject object)
  {
    return null;
  }

} //MathematicaSwitch
