package lms

import java.io.PrintWriter

import scala.virtualization.lms.common._
import scala.virtualization.lms.internal.{GenericNestedCodegen, GenerationFailedException}
import scala.reflect.SourceContext

trait MyRangeOps extends RangeOps {
  def infix_toList(r: Rep[Range])(implicit pos: SourceContext) = range_toList(r)
  def range_toList(r: Rep[Range])(implicit pos: SourceContext) : Rep[List[Int]]
}

trait MyRangeOpsExp extends MyRangeOps with RangeOpsExp {

  case class RangetoList(r: Exp[Range]) extends Def[List[Int]]

  def range_toList(r: Rep[Range])(implicit pos: SourceContext) = RangetoList(r)

}

trait ScalaGenMyRangeOps extends ScalaGenRangeOps {
  val IR: MyRangeOpsExp
  import IR._

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case RangetoList(r) => emitValDef(sym, quote(r) + ".toList")
    case _ => super.emitNode(sym, rhs)
  }
}

trait CGenMyRangeOps extends CGenRangeOps

trait CudaGenMyRangeOps extends CudaGenRangeOps {
  val IR: MyRangeOpsExp
  import IR._

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case RangetoList(r) => emitValDef(sym, quote(r) + ".toList")
    case _ => super.emitNode(sym, rhs)
  }
}