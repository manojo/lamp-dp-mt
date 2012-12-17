package lms

import scala.virtualization.lms.common._
import java.io.{PrintWriter,StringWriter,FileOutputStream}

object TestCGen extends App {
  trait DSL extends ScalaOpsPkg with TupledFunctions with UncheckedOps with LiftPrimitives with LiftString with LiftVariables {
    // keep track of top level functions
    case class TopLevel[A,B](name: String, mA: Manifest[A], mB:Manifest[B], f: Rep[A] => Rep[B])
    val rec = new scala.collection.mutable.HashMap[String,TopLevel[_,_]]
    def toplevel[A:Manifest,B:Manifest](name: String)(f: Rep[A] => Rep[B]): Rep[A] => Rep[B] = {
      val g = (x: Rep[A]) => unchecked[B](name,"(",x,")")
      rec.getOrElseUpdate(name, TopLevel(name, manifest[A], manifest[B], f))
      g
    }
  }

  trait Impl2 extends DSL with ScalaOpsPkgExp with TupledFunctionsRecursiveExp with UncheckedOpsExp { self =>
    val codegen = new ScalaCodeGenPkg with ScalaGenVariables with ScalaGenTupledFunctions with ScalaGenUncheckedOps {
      val IR: self.type = self
    }
  }

  trait Impl extends DSL with ScalaOpsPkgExp with TupledFunctionsRecursiveExp with UncheckedOpsExp { self =>
    val codegen = new CCodeGenPkg with CGenVariables with CGenTupledFunctions with CGenUncheckedOps {
      val IR: self.type = self
      override def emitSource[A:Manifest](args: List[Sym[_]], body: Block[A], functionName: String, out: PrintWriter) = {
        val sA = remap(manifest[A])
        withStream(out) {
          stream.println(sA+" "+functionName+"("+args.map(a => remap(a.tp)+" "+quote(a)).mkString(", ")+") {")
          emitBlock(body)

          val y = getBlockResult(body)
          if (remap(y.tp) != "void") stream.println("return " + quote(y) + ";")

          stream.println("}")
        }
        Nil
      }
    }
    def emitAll(): Unit = {
      assert(codegen ne null) //careful about initialization order
      val stream = new PrintWriter(System.out)
      for ((_,v) <- rec) codegen.emitForwardDef(mtype(v.mA)::Nil, v.name, stream)(mtype(v.mB))
      rec.foreach { case (k,x) => codegen.emitSource(x.f, x.name, stream)(mtype(x.mA), mtype(x.mB)) }
    }
    emitAll()
  }

  trait Prog extends DSL {
    val main = toplevel("main") { x: Rep[Int] =>
      var i = 0
      while (i < 10) {
        printf("Hello, world! %d\n", i)
        i = i + 1
      }
      printf("Hello, world: main\n")
      test1(x)
      0 //test3(unit((3,2)))
    }
    val test1 = toplevel("test1") { x: Rep[Int] =>
      printf("Hello, world: test1\n")
      test2(x)
    }
    val test2 = toplevel("test2") { x: Rep[Int] =>
      printf("Hello, world: test2\n")
      x
    }
    //val test3 = toplevel("test3") { x: Rep[(Int,Int)] => x._1 * x._2 }
  }
  val p = new Prog with Impl2
  def q:Int=>Int = p.main.asInstanceOf[Int=>Int]
  println(q(3))

}


/*
import scala.virtualization.lms.common._

abstract class TypedFunction[T,U] extends Function1[T,U] {
  def body:String // with a single arg that is '_arg'
  def types:Map[String,String] // struct_body -> name
  val typeIn: String // a primitive or declared type
  val typeOut: String // a primitive or declared type
}

class CGen extends App {
// Note that the conversion could be done :
// 1) by macros
// 2) through LMS (interpreter for scala, codegen for C)
// 3) manually (providing types and body)

  def convert[T,U](f:Rep[T] => Rep[U]):TypedFunction[T,U] = {
    // XXX: use interpreter to get scala version
    // XXX: use c code generator to get C version
  }

}
*/
