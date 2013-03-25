package lms

import java.io.PrintWriter

import scala.virtualization.lms.common._
import scala.virtualization.lms.internal.{GenericNestedCodegen, GenerationFailedException}
import scala.reflect.SourceContext

trait MyCGenArrayOps extends CGenArrayOps {
  val IR: ArrayOpsExp
  import IR._

  def emitArrayNew[T:Manifest](sym: Sym[Any], rhs: Def[Any]): Unit = rhs match {
    case ArrayNew(n) => stream.println(remap(sym.tp) + " " + quote(sym) + "[" + quote(n) + "];")
  }

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = {
    rhs match {
      case a@ArrayNew(n) => emitArrayNew(sym, a)
      case ArrayLength(x) =>
      /*val x1 = x match {
        case Def(Reflect(d, _, _)) => d
        case Def(d) => d
        case _ => None
      }*/
      x match {
        case Def(y) => println("and sooo!") ; println(y)
        case _ =>
      }
      case ArrayApply(x,n) => emitValDef(sym, quote(x) + "[" + quote(n) + "]")
      case ArrayUpdate(x,n,y) =>  emitAssignment(quote(x)+"["+quote(n)+"]", quote(y))
      case _ => super.emitNode(sym, rhs)
    }
  }

  override def remap[A](m: Manifest[A]) : String = {
    if(m.toString startsWith "Array"){
      val arrayType = remap(m.typeArguments.head)
      arrayType //+ "[]"
    }else{
      super.remap(m)
    }
  }

}