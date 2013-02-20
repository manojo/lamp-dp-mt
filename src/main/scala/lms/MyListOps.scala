package lms

import java.io.PrintWriter

import scala.virtualization.lms.common._
import scala.virtualization.lms.internal.{GenericNestedCodegen, GenerationFailedException}
import scala.reflect.SourceContext

trait MyListOps extends ListOps with SeqOps with HackyRangeOps with LiftVariables{
  def list_minby[A:Ordering:Manifest, B:Ordering:Manifest](xs: Rep[List[A]], f: Rep[A] => Rep[B])(implicit pos: SourceContext): Rep[A]
  def list_fold[A:Manifest,B:Manifest](xs:Rep[List[A]], z:Rep[B], f: (Rep[B], Rep[A]) => Rep[B])(implicit pos: SourceContext): Rep[B]
}

trait MyListOpsExp extends MyListOps with ListOpsExp with SeqOpsExp with HackyRangeOpsExp{

  case class ListMinBy[A:Ordering:Manifest, B:Ordering:Manifest](xs: Exp[List[A]], x: Sym[A], block: Block[B]) extends Def[A]

  def list_minby[A:Ordering:Manifest, B:Ordering:Manifest](xs: Exp[List[A]], f: Exp[A] => Exp[B])(implicit pos: SourceContext) = {
    val a = fresh[A]
    val b = reifyEffects(f(a))
    reflectEffect(ListMinBy(xs, a, b), summarizeEffects(b).star)
  }

  //writing this as a for loop
  //with ranges
  def list_fold[A:Manifest,B:Manifest](xs:Rep[List[A]], z:Rep[B], f: (Rep[B], Rep[A]) => Rep[B])(implicit pos: SourceContext): Rep[B] = {
    var startTerm = z
    val seq = xs.toSeq
    range_foreach(range_until(unit(0),seq.length),{i: Rep[Int] =>
      startTerm = f(startTerm, xs(i))
    })

    startTerm
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

trait MyListOpsExpOpt extends MyListOpsExp {

  override def list_map[A:Manifest, B:Manifest](l: Exp[List[A]], f: Exp[A] => Exp[B])(implicit pos: SourceContext) =
  l match {
    case Def(ListMap(l2, x, b)) => b match {
      case Block(Def(a)) =>
        //l2.map(y => f(b))
        //l2.map(y => f(a))
        ListMap(l2,x,reifyEffects(f(a)))
      case _ => super.list_map(l,f)
    }
    case _ => super.list_map(l,f)
  }
}

trait ScalaGenMyListOps extends ScalaGenListOps with ScalaGenSeqOps
  with ScalaGenHackyRangeOps with ScalaGenVariables{
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