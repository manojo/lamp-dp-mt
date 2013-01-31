/**
 * <copyright>
 * </copyright>
 *
 */
package fr.irisa.cairn.model.mathematica.impl;

import fr.irisa.cairn.model.mathematica.IntLeaf;
import fr.irisa.cairn.model.mathematica.MathematicaPackage;

import org.eclipse.emf.common.notify.Notification;

import org.eclipse.emf.ecore.EClass;

import org.eclipse.emf.ecore.impl.ENotificationImpl;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Int Leaf</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link fr.irisa.cairn.model.mathematica.impl.IntLeafImpl#getSigned <em>Signed</em>}</li>
 *   <li>{@link fr.irisa.cairn.model.mathematica.impl.IntLeafImpl#getValue <em>Value</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public class IntLeafImpl extends ASTLeafImpl implements IntLeaf
{
  /**
   * The default value of the '{@link #getSigned() <em>Signed</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getSigned()
   * @generated
   * @ordered
   */
  protected static final String SIGNED_EDEFAULT = null;

  /**
   * The cached value of the '{@link #getSigned() <em>Signed</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getSigned()
   * @generated
   * @ordered
   */
  protected String signed = SIGNED_EDEFAULT;

  /**
   * The default value of the '{@link #getValue() <em>Value</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getValue()
   * @generated
   * @ordered
   */
  protected static final int VALUE_EDEFAULT = 0;

  /**
   * The cached value of the '{@link #getValue() <em>Value</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getValue()
   * @generated
   * @ordered
   */
  protected int value = VALUE_EDEFAULT;

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  protected IntLeafImpl()
  {
    super();
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  protected EClass eStaticClass()
  {
    return MathematicaPackage.Literals.INT_LEAF;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public String getSigned()
  {
    return signed;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public void setSigned(String newSigned)
  {
    String oldSigned = signed;
    signed = newSigned;
    if (eNotificationRequired())
      eNotify(new ENotificationImpl(this, Notification.SET, MathematicaPackage.INT_LEAF__SIGNED, oldSigned, signed));
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public int getValue()
  {
    return value;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public void setValue(int newValue)
  {
    int oldValue = value;
    value = newValue;
    if (eNotificationRequired())
      eNotify(new ENotificationImpl(this, Notification.SET, MathematicaPackage.INT_LEAF__VALUE, oldValue, value));
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public Object eGet(int featureID, boolean resolve, boolean coreType)
  {
    switch (featureID)
    {
      case MathematicaPackage.INT_LEAF__SIGNED:
        return getSigned();
      case MathematicaPackage.INT_LEAF__VALUE:
        return getValue();
    }
    return super.eGet(featureID, resolve, coreType);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public void eSet(int featureID, Object newValue)
  {
    switch (featureID)
    {
      case MathematicaPackage.INT_LEAF__SIGNED:
        setSigned((String)newValue);
        return;
      case MathematicaPackage.INT_LEAF__VALUE:
        setValue((Integer)newValue);
        return;
    }
    super.eSet(featureID, newValue);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public void eUnset(int featureID)
  {
    switch (featureID)
    {
      case MathematicaPackage.INT_LEAF__SIGNED:
        setSigned(SIGNED_EDEFAULT);
        return;
      case MathematicaPackage.INT_LEAF__VALUE:
        setValue(VALUE_EDEFAULT);
        return;
    }
    super.eUnset(featureID);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public boolean eIsSet(int featureID)
  {
    switch (featureID)
    {
      case MathematicaPackage.INT_LEAF__SIGNED:
        return SIGNED_EDEFAULT == null ? signed != null : !SIGNED_EDEFAULT.equals(signed);
      case MathematicaPackage.INT_LEAF__VALUE:
        return value != VALUE_EDEFAULT;
    }
    return super.eIsSet(featureID);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public String toString()
  {
    if (eIsProxy()) return super.toString();

    StringBuffer result = new StringBuffer(super.toString());
    result.append(" (signed: ");
    result.append(signed);
    result.append(", value: ");
    result.append(value);
    result.append(')');
    return result.toString();
  }

} //IntLeafImpl
