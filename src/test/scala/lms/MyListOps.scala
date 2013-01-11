package lms

import java.io.PrintWriter

import scala.virtualization.lms.common._
import scala.virtualization.lms.internal.{GenericNestedCodegen, GenerationFailedException}
import scala.reflect.SourceContext

trait MyListOps extends ListOps {
  def list_minby[A:Ordering:Manifest, B:Ordering:Manifest](xs: Rep[List[A]], f: Rep[A] => Rep[B])(implicit pos: SourceContext): Rep[A]
}

trait MyListOpsExp extends MyListOps with ListOpsExp {

  case class ListMinBy[A:Ordering:Manifest, B:Ordering:Manifest](xs: Exp[List[A]], x: Sym[A], block: Block[B]) extends Def[A]

  def list_minby[A:Ordering:Manifest, B:Ordering:Manifest](xs: Exp[List[A]], f: Exp[A] => Exp[B])(implicit pos: SourceContext) = {
    val a = fresh[A]
    val b = reifyEffects(f(a))
    reflectEffect(ListMinBy(xs, a, b), summarizeEffects(b).star)
  }

  //following pattern of ListSortBy for ListMinBy
  override def syms(e: Any): List[Sym[Any]] = e match {
    case ListMinBy(a, x, body) => syms(a):::syms(body)
    case _ => super.syms(e)
  }

  override def boundSyms(e: Any): List[Sym[Any]] = e match {
    case ListMinBy(a, x, body) => x :: effectSyms(body)
    case _ => super.boundSyms(e)
  }

  override def symsFreq(e: Any): List[(Sym[Any], Double)] = e match {
    case ListMinBy(a, x, body) => freqNormal(a):::freqHot(body)
    case _ => super.symsFreq(e)
  }

}

trait ScalaGenMyListOps extends ScalaGenListOps {
  val IR: MyListOpsExp
  import IR._

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case ListMinBy(l,x,blk) =>
         stream.println("val " + quote(sym) + " = " + quote(l) + ".minBy{")
         stream.println(quote(x) + " => ")
         emitBlock(blk)
         stream.println(quote(getBlockResult(blk)))
         stream.println("}")
    case _ => super.emitNode(sym, rhs)
  }
}

/*trait CudaGenHackyRangeOps extends CudaGenRangeOps {
  val IR: HackyRangeOpsExp
  import IR._

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case RangetoList(r) => emitValDef(sym, quote(r) + ".toList")
    case _ => super.emitNode(sym, rhs)
  }
}*/