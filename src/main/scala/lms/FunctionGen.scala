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

  def getBody(bdy:cCodegen.Block[_]):String = {
    import java.io.ByteArrayOutputStream
    val os = new ByteArrayOutputStream
    val stream = new PrintWriter(os)
    cCodegen.withStream(stream) {
      cCodegen.emitBlock(bdy)
      val y = cCodegen.getBlockResult(bdy)
      if(cCodegen.remap(y.tp) != "void") stream.println("return "+ cCodegen.quote(y)+";")
    }
    val temp = os.toString("UTF-8")
    os.close; stream.close; temp
  }

  def getArgs(as:List[FunctionGen.this.Sym[_]]) = as.map{x=>(cCodegen.quote(x), x.tp.toString) }

  def gen[A,R](f: Exp[A] => Exp[R])(implicit mA: Manifest[A], mR: Manifest[R]) = {
    val s = fresh[A]
    val bdy = cCodegen.reifyBlock(f(s))

    new (A => R) with CFun {
      private val temp = compile(f)
      def apply(a: A) = temp(a)
      val args = getArgs(List(s))
      val body = getBody(bdy)
      val tpe = manifest[R].toString
    }
  }

  def gen2[A,B,R](f: (Exp[A], Exp[B]) => Exp[R])(implicit mA: Manifest[A], mB: Manifest[B], mR: Manifest[R])= {
    val a = fresh[A]; val b = fresh[B]
    val bdy = cCodegen.reifyBlock(f(a,b))

    new ((A,B) => R) with CFun {
      private val temp = compile2(f)
      def apply(a: A, b: B) = temp(a,b)
      val args = getArgs(List(a,b))
      val body = getBody(bdy)
      val tpe = manifest[R].toString
    }
  }

  def gen3[A,B,C,R](f: (Exp[A], Exp[B], Exp[C]) => Exp[R])(implicit mA: Manifest[A], mB: Manifest[B], mC: Manifest[C], mR: Manifest[R])= {
    val a = fresh[A]; val b = fresh[B]; val c = fresh[C]
    val bdy = cCodegen.reifyBlock(f(a,b,c))

    new ((A,B,C) => R) with CFun {
      private val temp = compile3(f)
      def apply(a: A, b: B, c: C) = temp(a,b,c)
      val args = getArgs(List(a,b,c))
      val body = getBody(bdy)
      val tpe = manifest[R].toString
    }
  }

  def gen4[A,B,C,D,R](f: (Exp[A], Exp[B], Exp[C], Exp[D]) => Exp[R])(implicit mA: Manifest[A], mB: Manifest[B], mC: Manifest[C], mD: Manifest[D], mR: Manifest[R])= {
    val a = fresh[A]; val b = fresh[B]; val c = fresh[C]; val d = fresh[D]
    val bdy = cCodegen.reifyBlock(f(a,b,c,d))

    new ((A,B,C,D) => R) with CFun {
      private val temp = compile4(f)
      def apply(a: A, b: B, c: C, d: D) = temp(a,b,c,d)
      val args = getArgs(List(a,b,c,d))
      val body = getBody(bdy)
      val tpe = manifest[R].toString
    }
  }

  def gen5[A,B,C,D,E,R](f: (Exp[A], Exp[B], Exp[C], Exp[D], Exp[E]) => Exp[R])(implicit mA: Manifest[A], mB: Manifest[B], mC: Manifest[C], mD: Manifest[D], mE: Manifest[E], mR: Manifest[R])= {
    val a = fresh[A]; val b = fresh[B]; val c = fresh[C]; val d = fresh[D]; val e = fresh[E]
    val bdy = cCodegen.reifyBlock(f(a,b,c,d,e))
    new ((A,B,C,D,E) => R) with CFun {
      private val temp = compile5(f)
      def apply(a: A, b: B, c: C, d: D, e: E) = temp(a,b,c,d,e)
      val args = getArgs(List(a,b,c,d,e))
      val body = getBody(bdy)
      val tpe = manifest[R].toString
    }
  }


}