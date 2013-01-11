package lms

import scala.virtualization.lms.common._
import java.io.{PrintWriter,StringWriter,FileOutputStream}

object TestCGen extends App {
  trait DSL extends ScalaOpsPkg with TupledFunctions with UncheckedOps with LiftPrimitives with LiftString with LiftVariables with TupleOps {
    // keep track of top level functions
    abstract class TopLevel[A,R]
    case class TopLevel1[A,R](name: String, mA: Manifest[A], mB:Manifest[R], f: Rep[A] => Rep[R]) extends TopLevel[A,R]
    case class TopLevel2[A,B,R](name:String, mA: Manifest[A], mB:Manifest[B], mR: Manifest[R], f: (Rep[A], Rep[B]) => Rep[R]) extends TopLevel[(A,B),R]
    case class TopLevel3[A,B,C,R](name:String, mA: Manifest[A], mB:Manifest[B], mC:Manifest[C], mR: Manifest[R], f: (Rep[A], Rep[B], Rep[C]) => Rep[R]) extends TopLevel[(A,B,C),R]

    val rec = new scala.collection.mutable.HashMap[String,TopLevel[_,_]]
    def toplevel[A:Manifest,B:Manifest](name: String)(f: Rep[A] => Rep[B]): Rep[A] => Rep[B] = {
      val g = (x: Rep[A]) => unchecked[B](name,"(",x,")")
      rec.getOrElseUpdate(name, TopLevel1(name, manifest[A], manifest[B], f))
      g
    }

    //functions with two arguments
    def toplevel2[A:Manifest,B:Manifest, R:Manifest](name: String)(f: (Rep[A], Rep[B]) => Rep[R]): (Rep[A], Rep[B]) => Rep[R] = {
      val g = (x1: Rep[A], x2: Rep[B]) => unchecked[R](name,"(",x1,x2,")")
      rec.getOrElseUpdate(name, TopLevel2(name, manifest[A], manifest[B], manifest[R], f))
      g
    }

    //functions with three arguments
    def toplevel3[A:Manifest,B:Manifest, C:Manifest, R:Manifest](name: String)(f: (Rep[A], Rep[B], Rep[C]) => Rep[R]): (Rep[A], Rep[B], Rep[C]) => Rep[R] = {
      val g = (x1: Rep[A], x2: Rep[B], x3: Rep[C]) => unchecked[R](name,"(",x1,x2,x3,")")
      rec.getOrElseUpdate(name, TopLevel3(name, manifest[A], manifest[B], manifest[C], manifest[R], f))
      g
    }
  }

  trait Impl extends DSL with ScalaOpsPkgExp with TupledFunctionsRecursiveExp with UncheckedOpsExp with TupleOpsExp{ self =>
    val codegen = new CCodeGenPkg with CGenVariables with CGenTupledFunctions with CGenUncheckedOps with CLikeGenTupleOps{
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

      import java.io.ByteArrayOutputStream

      val os = new ByteArrayOutputStream();
      val stream = new PrintWriter(os)

      for ((_,v) <- rec) { v match {
        case TopLevel1(name, mA, mR, _) => codegen.emitForwardDef(mtype(mA)::Nil, name, stream)(mtype(mR))
        case TopLevel2(name, mA, mB, mR, _) => codegen.emitForwardDef(mtype(mA)::mtype(mB)::Nil, name, stream)(mtype(mR))
        case TopLevel3(name, mA, mB, mC, mR, _) => codegen.emitForwardDef(mtype(mA)::mtype(mB)::mtype(mC)::Nil, name, stream)(mtype(mR))
        case _ => {}
      }}


      rec.foreach { case (k,x) =>
        x match {
          case TopLevel1(name, mA, mB, f) => codegen.emitSource(f, name, stream)(mtype(mA), mtype(mB))
          case TopLevel2(name, mA, mB, mR, f) => codegen.emitSource2(f, name, stream)(mtype(mA), mtype(mB), mtype(mR))
          case TopLevel3(name, mA, mB, mC, mR, f) => codegen.emitSource3(f, name, stream)(mtype(mA), mtype(mB), mtype(mC), mtype(mR))
          case _ => ()
        }
      }

      val methods = os.toString("UTF-8")
      //stream.clear
      os.reset
      codegen.emitDataStructures(stream)
      val structs = os.toString("UTF-8")

      System.out.println(structs + methods)

      os.close
      stream.close
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

    val test2Params = toplevel2("test2Params") {(x: Rep[Int], y: Rep[Int]) =>
      y
    }

    type Answer = (Int,Int)
    val mult = toplevel2("testTuples") {(x: Rep[Answer], y: Rep[Answer]) =>
      (x._1 ,y._2)
    }

    //val test3 = toplevel("test3") { x: Rep[(Int,Int)] => x._1 * x._2 }
  }
  val p = new Prog with Impl
//  def q:Int=>Int = p.main.asInstanceOf[Int=>Int]
//  println(q(3))

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
