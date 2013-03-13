package lms

import java.io.PrintWriter

import scala.virtualization.lms.common._
import scala.virtualization.lms.internal.{GenericNestedCodegen, GenerationFailedException}
import scala.reflect.SourceContext

trait MyListOps extends ListOps with SeqOps with MyRangeOps /*with LiftVariables*/ {
  def list_minby[A:Ordering:Manifest, B:Ordering:Manifest](xs: Rep[List[A]], f: Rep[A] => Rep[B])(implicit pos: SourceContext): Rep[A]
  def list_fold[A:Manifest,B:Manifest](xs:Rep[List[A]], z:Rep[B], f: (Rep[B], Rep[A]) => Rep[B])(implicit pos: SourceContext): Rep[B]

  // Tehcnically, z is not used but necessary for conversion to Generators
  def list_reduce[A:Manifest](xs:Rep[List[A]], f: (Rep[A], Rep[A]) => Rep[A], z:Rep[A])(implicit pos: SourceContext): Rep[List[A]]

}

trait MyListOpsExp extends MyListOps with ListOpsExp with SeqOpsExp with MyRangeOpsExp{

  case class ListReduce[A:Manifest](l: Exp[List[A]], a: Sym[A], b: Sym[A], block: Block[A], z:Rep[A]) extends Def[List[A]]
  def list_reduce[A:Manifest](xs:Rep[List[A]], f: (Rep[A], Rep[A]) => Rep[A], z:Rep[A])(implicit pos: SourceContext) = {
    val a = fresh[A]
    val b = fresh[A]
    val blk = reifyEffects(f(a,b))
    reflectEffect(ListReduce(xs, a, b, blk, z), summarizeEffects(blk).star)
  }

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
    case ListReduce(a, b, x, body, z) => syms(a):::syms(b):::syms(body)
    case ListMinBy(a, x, body) => syms(a):::syms(body)
    case _ => super.syms(e)
  }

  override def boundSyms(e: Any): List[Sym[Any]] = e match {
    case ListReduce(l, a, b, body, z) => a::b::effectSyms(body)
    case ListMinBy(a, x, body) => x :: effectSyms(body)
    case _ => super.boundSyms(e)
  }

  override def symsFreq(e: Any): List[(Sym[Any], Double)] = e match {
    case ListReduce(a, b, x, body, z) => freqNormal(a):::freqNormal(b):::freqHot(body)
    case ListMinBy(a, x, body) => freqNormal(a):::freqHot(body)
    case _ => super.symsFreq(e)
  }

  //my own list map node
  case class MyListMap[A:Manifest,B:Manifest](l: Exp[List[A]], f: Exp[A] => Exp[B] ) extends Def[List[B]]
  /*override def list_map[A:Manifest, B:Manifest](l: Exp[List[A]], f: Exp[A] => Exp[B])(implicit pos: SourceContext) =
    MyListMap(l, f)
  */
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

trait ModListOpsExp extends MyListOpsExp{
  case class MyListFlatMap[A:Manifest,B:Manifest](l: Exp[List[A]], f: Exp[A] => Exp[List[B]] ) extends Def[List[B]]
  override def list_flatMap[A : Manifest, B : Manifest](f: Rep[A] => Rep[List[B]])(xs: Rep[List[A]])(implicit pos: SourceContext) =
    MyListFlatMap(xs, f)
}

trait ScalaGenMyListOps extends ScalaGenListOps with ScalaGenSeqOps
  with ScalaGenMyRangeOps with ScalaGenVariables {
  val IR: MyListOpsExp
  import IR._

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case ListReduce(l,a,b,blk, z) => // val result = if (l.isEmpty) l else List(l.tail.foldLeft(l.head){(a,b)=>blk})
      stream.println("val " + quote(sym) + " = if ("+quote(l)+".isEmpty) "+quote(l)+" else {")
      stream.println("  List("+quote(l)+".tail.foldLeft("+quote(l)+".head) { ("+quote(a)+","+quote(b)+") =>")
      emitBlock(blk)
      stream.println(quote(getBlockResult(blk)))
      stream.println("  })")
      stream.println("}")
    case ListMinBy(l,x,blk) =>
      stream.println("val " + quote(sym) + " = " + quote(l) + ".minBy{")
      stream.println(quote(x) + " => ")
      emitBlock(blk)
      stream.println(quote(getBlockResult(blk)))
      stream.println("}")
    case _ => super.emitNode(sym, rhs)
  }
}