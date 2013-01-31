/**
 * <copyright>
 * </copyright>
 *
 */
package fr.irisa.cairn.model.mathematica;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Float Leaf</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link fr.irisa.cairn.model.mathematica.FloatLeaf#getSigned <em>Signed</em>}</li>
 *   <li>{@link fr.irisa.cairn.model.mathematica.FloatLeaf#getA <em>A</em>}</li>
 *   <li>{@link fr.irisa.cairn.model.mathematica.FloatLeaf#getB <em>B</em>}</li>
 * </ul>
 * </p>
 *
 * @see fr.irisa.cairn.model.mathematica.MathematicaPackage#getFloatLeaf()
 * @model
 * @generated
 */
public interface FloatLeaf extends ASTLeaf
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
   * @see fr.irisa.cairn.model.mathematica.MathematicaPackage#getFloatLeaf_Signed()
   * @model
   * @generated
   */
  String getSigned();

  /**
   * Sets the value of the '{@link fr.irisa.cairn.model.mathematica.FloatLeaf#getSigned <em>Signed</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>Signed</em>' attribute.
   * @see #getSigned()
   * @generated
   */
  void setSigned(String value);

  /**
   * Returns the value of the '<em><b>A</b></em>' attribute.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>A</em>' attribute isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>A</em>' attribute.
   * @see #setA(int)
   * @see fr.irisa.cairn.model.mathematica.MathematicaPackage#getFloatLeaf_A()
   * @model
   * @generated
   */
  int getA();

  /**
   * Sets the value of the '{@link fr.irisa.cairn.model.mathematica.FloatLeaf#getA <em>A</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>A</em>' attribute.
   * @see #getA()
   * @generated
   */
  void setA(int value);

  /**
   * Returns the value of the '<em><b>B</b></em>' attribute.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>B</em>' attribute isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>B</em>' attribute.
   * @see #setB(int)
   * @see fr.irisa.cairn.model.mathematica.MathematicaPackage#getFloatLeaf_B()
   * @model
   * @generated
   */
  int getB();

  /**
   * Sets the value of the '{@link fr.irisa.cairn.model.mathematica.FloatLeaf#getB <em>B</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>B</em>' attribute.
   * @see #getB()
   * @generated
   */
  void setB(int value);

} // FloatLeaf
