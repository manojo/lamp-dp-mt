/**
 * <copyright>
 * </copyright>
 *
 */
package fr.irisa.cairn.model.mathematica.impl;

import fr.irisa.cairn.model.mathematica.FloatLeaf;
import fr.irisa.cairn.model.mathematica.MathematicaPackage;

import org.eclipse.emf.common.notify.Notification;

import org.eclipse.emf.ecore.EClass;

import org.eclipse.emf.ecore.impl.ENotificationImpl;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Float Leaf</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link fr.irisa.cairn.model.mathematica.impl.FloatLeafImpl#getSigned <em>Signed</em>}</li>
 *   <li>{@link fr.irisa.cairn.model.mathematica.impl.FloatLeafImpl#getA <em>A</em>}</li>
 *   <li>{@link fr.irisa.cairn.model.mathematica.impl.FloatLeafImpl#getB <em>B</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public class FloatLeafImpl extends ASTLeafImpl implements FloatLeaf
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
   * The default value of the '{@link #getA() <em>A</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getA()
   * @generated
   * @ordered
   */
  protected static final int A_EDEFAULT = 0;

  /**
   * The cached value of the '{@link #getA() <em>A</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getA()
   * @generated
   * @ordered
   */
  protected int a = A_EDEFAULT;

  /**
   * The default value of the '{@link #getB() <em>B</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getB()
   * @generated
   * @ordered
   */
  protected static final int B_EDEFAULT = 0;

  /**
   * The cached value of the '{@link #getB() <em>B</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getB()
   * @generated
   * @ordered
   */
  protected int b = B_EDEFAULT;

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  protected FloatLeafImpl()
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
    return MathematicaPackage.Literals.FLOAT_LEAF;
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
      eNotify(new ENotificationImpl(this, Notification.SET, MathematicaPackage.FLOAT_LEAF__SIGNED, oldSigned, signed));
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public int getA()
  {
    return a;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public void setA(int newA)
  {
    int oldA = a;
    a = newA;
    if (eNotificationRequired())
      eNotify(new ENotificationImpl(this, Notification.SET, MathematicaPackage.FLOAT_LEAF__A, oldA, a));
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public int getB()
  {
    return b;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public void setB(int newB)
  {
    int oldB = b;
    b = newB;
    if (eNotificationRequired())
      eNotify(new ENotificationImpl(this, Notification.SET, MathematicaPackage.FLOAT_LEAF__B, oldB, b));
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
      case MathematicaPackage.FLOAT_LEAF__SIGNED:
        return getSigned();
      case MathematicaPackage.FLOAT_LEAF__A:
        return getA();
      case MathematicaPackage.FLOAT_LEAF__B:
        return getB();
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
      case MathematicaPackage.FLOAT_LEAF__SIGNED:
        setSigned((String)newValue);
        return;
      case MathematicaPackage.FLOAT_LEAF__A:
        setA((Integer)newValue);
        return;
      case MathematicaPackage.FLOAT_LEAF__B:
        setB((Integer)newValue);
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
      case MathematicaPackage.FLOAT_LEAF__SIGNED:
        setSigned(SIGNED_EDEFAULT);
        return;
      case MathematicaPackage.FLOAT_LEAF__A:
        setA(A_EDEFAULT);
        return;
      case MathematicaPackage.FLOAT_LEAF__B:
        setB(B_EDEFAULT);
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
      case MathematicaPackage.FLOAT_LEAF__SIGNED:
        return SIGNED_EDEFAULT == null ? signed != null : !SIGNED_EDEFAULT.equals(signed);
      case MathematicaPackage.FLOAT_LEAF__A:
        return a != A_EDEFAULT;
      case MathematicaPackage.FLOAT_LEAF__B:
        return b != B_EDEFAULT;
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
    result.append(", a: ");
    result.append(a);
    result.append(", b: ");
    result.append(b);
    result.append(')');
    return result.toString();
  }

} //FloatLeafImpl
