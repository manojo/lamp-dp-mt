package lms

import java.io.PrintWriter

import scala.virtualization.lms.common._
import scala.virtualization.lms.internal.{GenericNestedCodegen, GenerationFailedException}
import scala.reflect.SourceContext

trait HackyRangeOps extends RangeOps {
  def infix_toList(r: Rep[Range])(implicit pos: SourceContext) = range_toList(r)
  def range_toList(r: Rep[Range])(implicit pos: SourceContext) : Rep[List[Int]]
}

trait HackyRangeOpsExp extends HackyRangeOps with RangeOpsExp {

  case class RangetoList(r: Exp[Range]) extends Def[List[Int]]

  def range_toList(r: Rep[Range])(implicit pos: SourceContext) = RangetoList(r)

}

trait ScalaGenHackyRangeOps extends ScalaGenRangeOps {
  val IR: HackyRangeOpsExp
  import IR._

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case RangetoList(r) => emitValDef(sym, quote(r) + ".toList")
    case _ => super.emitNode(sym, rhs)
  }
}

trait CudaGenHackyRangeOps extends CudaGenRangeOps {
  val IR: HackyRangeOpsExp
  import IR._

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case RangetoList(r) => emitValDef(sym, quote(r) + ".toList")
    case _ => super.emitNode(sym, rhs)
  }
}