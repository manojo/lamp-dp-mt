package lms

import scala.virtualization.lms.common._
import scala.virtualization.lms.internal._
import java.io._

import scala.tools.nsc._
import scala.tools.nsc.util._
import scala.tools.nsc.reporters._
import scala.tools.nsc.io._

import scala.tools.nsc.interpreter.AbstractFileClassLoader
import v4._

trait FunctionGen extends BaseExp with MyScalaCompile{

  override val codegen: ScalaCodegen { val IR: FunctionGen.this.type }
  val cCodegen: CCodegen{ val IR: FunctionGen.this.type }

  def gen[A,B](f: Exp[A] => Exp[B])(implicit mA: Manifest[A], mB: Manifest[B]) = {
    val s = fresh[A]
    val bdy = cCodegen.reifyBlock(f(s))

    new (A => B) with CFun{
      def apply(a: A) = {
        val temp = compile(f)
        temp(a)
      }

      val args = (cCodegen.quote(s), s.tp.toString)::Nil
      val body: String = {
        import java.io.ByteArrayOutputStream
        val os = new ByteArrayOutputStream
        val stream = new PrintWriter(os)

        cCodegen.withStream(stream){
          cCodegen.emitBlock(bdy)
          val y = cCodegen.getBlockResult(bdy)
          if(cCodegen.remap(y.tp) != "void") stream.println("return "+ cCodegen.quote(y))
        }

        val temp = os.toString("UTF-8")
        os.close
        stream.close
        temp
      }

      val tpe: String = manifest[B].toString
    }

  }

  def gen2[A,B,R](f: (Exp[A], Exp[B]) => Exp[R])(implicit mA: Manifest[A], mB: Manifest[B], mR: Manifest[R])= {
    val a = fresh[A]; val b = fresh[B]
    val bdy = cCodegen.reifyBlock(f(a,b))

    new ((A,B) => R) with CFun {
      def apply(a: A, b: B) = {
        val temp = compile2(f)
        temp(a,b)
      }

      val args = (cCodegen.quote(a), a.tp.toString)::
                 (cCodegen.quote(b), b.tp.toString)::Nil

      val body: String = {
        import java.io.ByteArrayOutputStream
        val os = new ByteArrayOutputStream
        val stream = new PrintWriter(os)

        cCodegen.withStream(stream){
          cCodegen.emitBlock(bdy)
          val y = cCodegen.getBlockResult(bdy)
          if(cCodegen.remap(y.tp) != "void") stream.println("return "+ cCodegen.quote(y))
        }

        val temp = os.toString("UTF-8")
        os.close
        stream.close
        temp
      }

      val tpe: String = manifest[R].toString
    }
  }

  def gen3[A,B,C,R](f: (Exp[A], Exp[B], Exp[C]) => Exp[R])(implicit mA: Manifest[A], mB: Manifest[B], mC: Manifest[C], mR: Manifest[R])= {
    val a = fresh[A]; val b = fresh[B]; val c = fresh[C]
    val bdy = cCodegen.reifyBlock(f(a,b,c))

    new ((A,B,C) => R) with CFun {
      def apply(a: A, b: B, c: C) = {
        val temp = compile3(f)
        temp(a,b,c)
      }

      val args = (cCodegen.quote(a), a.tp.toString)::
                 (cCodegen.quote(b), b.tp.toString)::
                 (cCodegen.quote(c), c.tp.toString)::Nil

      val body: String = {
        import java.io.ByteArrayOutputStream
        val os = new ByteArrayOutputStream
        val stream = new PrintWriter(os)

        cCodegen.withStream(stream){
          cCodegen.emitBlock(bdy)
          val y = cCodegen.getBlockResult(bdy)
          if(cCodegen.remap(y.tp) != "void") stream.println("return "+ cCodegen.quote(y))
        }

        val temp = os.toString("UTF-8")
        os.close
        stream.close
        temp
      }

      val tpe: String = manifest[R].toString
    }
  }

}