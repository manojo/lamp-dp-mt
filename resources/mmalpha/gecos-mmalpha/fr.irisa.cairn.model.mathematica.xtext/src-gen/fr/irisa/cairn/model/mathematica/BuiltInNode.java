/**
 * <copyright>
 * </copyright>
 *
 */
package fr.irisa.cairn.model.mathematica;

import org.eclipse.emf.common.util.EList;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Built In Node</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link fr.irisa.cairn.model.mathematica.BuiltInNode#getKeyword <em>Keyword</em>}</li>
 *   <li>{@link fr.irisa.cairn.model.mathematica.BuiltInNode#getChildren <em>Children</em>}</li>
 * </ul>
 * </p>
 *
 * @see fr.irisa.cairn.model.mathematica.MathematicaPackage#getBuiltInNode()
 * @model
 * @generated
 */
public interface BuiltInNode extends Node
{
  /**
   * Returns the value of the '<em><b>Keyword</b></em>' attribute.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Keyword</em>' attribute isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Keyword</em>' attribute.
   * @see #setKeyword(String)
   * @see fr.irisa.cairn.model.mathematica.MathematicaPackage#getBuiltInNode_Keyword()
   * @model
   * @generated
   */
  String getKeyword();

  /**
   * Sets the value of the '{@link fr.irisa.cairn.model.mathematica.BuiltInNode#getKeyword <em>Keyword</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>Keyword</em>' attribute.
   * @see #getKeyword()
   * @generated
   */
  void setKeyword(String value);

  /**
   * Returns the value of the '<em><b>Children</b></em>' containment reference list.
   * The list contents are of type {@link fr.irisa.cairn.model.mathematica.Node}.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Children</em>' containment reference list isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Children</em>' containment reference list.
   * @see fr.irisa.cairn.model.mathematica.MathematicaPackage#getBuiltInNode_Children()
   * @model containment="true"
   * @generated
   */
  EList<Node> getChildren();

} // BuiltInNode
