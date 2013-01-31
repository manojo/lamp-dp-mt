/**
 * <copyright>
 * </copyright>
 *
 */
package fr.irisa.cairn.model.mathematica;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Symbol Leaf</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link fr.irisa.cairn.model.mathematica.SymbolLeaf#getName <em>Name</em>}</li>
 * </ul>
 * </p>
 *
 * @see fr.irisa.cairn.model.mathematica.MathematicaPackage#getSymbolLeaf()
 * @model
 * @generated
 */
public interface SymbolLeaf extends ASTLeaf
{
  /**
   * Returns the value of the '<em><b>Name</b></em>' attribute.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Name</em>' attribute isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Name</em>' attribute.
   * @see #setName(String)
   * @see fr.irisa.cairn.model.mathematica.MathematicaPackage#getSymbolLeaf_Name()
   * @model
   * @generated
   */
  String getName();

  /**
   * Sets the value of the '{@link fr.irisa.cairn.model.mathematica.SymbolLeaf#getName <em>Name</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>Name</em>' attribute.
   * @see #getName()
   * @generated
   */
  void setName(String value);

} // SymbolLeaf
