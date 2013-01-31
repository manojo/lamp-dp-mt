/**
 * <copyright>
 * </copyright>
 *
 */
package fr.irisa.cairn.model.mathematica;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Int Leaf</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link fr.irisa.cairn.model.mathematica.IntLeaf#getSigned <em>Signed</em>}</li>
 *   <li>{@link fr.irisa.cairn.model.mathematica.IntLeaf#getValue <em>Value</em>}</li>
 * </ul>
 * </p>
 *
 * @see fr.irisa.cairn.model.mathematica.MathematicaPackage#getIntLeaf()
 * @model
 * @generated
 */
public interface IntLeaf extends ASTLeaf
{
  /**
   * Returns the value of the '<em><b>Signed</b></em>' attribute.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Signed</em>' attribute isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Signed</em>' attribute.
   * @see #setSigned(String)
   * @see fr.irisa.cairn.model.mathematica.MathematicaPackage#getIntLeaf_Signed()
   * @model
   * @generated
   */
  String getSigned();

  /**
   * Sets the value of the '{@link fr.irisa.cairn.model.mathematica.IntLeaf#getSigned <em>Signed</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>Signed</em>' attribute.
   * @see #getSigned()
   * @generated
   */
  void setSigned(String value);

  /**
   * Returns the value of the '<em><b>Value</b></em>' attribute.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Value</em>' attribute isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Value</em>' attribute.
   * @see #setValue(int)
   * @see fr.irisa.cairn.model.mathematica.MathematicaPackage#getIntLeaf_Value()
   * @model
   * @generated
   */
  int getValue();

  /**
   * Sets the value of the '{@link fr.irisa.cairn.model.mathematica.IntLeaf#getValue <em>Value</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>Value</em>' attribute.
   * @see #getValue()
   * @generated
   */
  void setValue(int value);

} // IntLeaf
