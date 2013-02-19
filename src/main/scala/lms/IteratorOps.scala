package lms

import scala.virtualization.lms.common._

import java.io.PrintWriter
import scala.virtualization.lms.internal.GenericNestedCodegen
import scala.reflect.SourceContext

trait IteratorOps extends Variables with While with LiftVariables with TupleOps
  with NumericOps with OrderingOps with IfThenElse with EmbeddedControls{

  /* Ideally should be a function of Rep[Unit] => Rep[T] */
  /* fix with some LMS knowledge */
  abstract class Iterator[T:Manifest] extends (Rep[T] => Rep[T]) {self =>
    def size: Rep[Int]
    def seed: Rep[T]
    //def hasNext(i: Rep[Int]) : Rep[Boolean]
    def next(i: Rep[Int]): Rep[T]
    def apply(begin: Rep[T]): Rep[T] = {
      var i = 0
      var s = seed
      while(i <= size){
        s = next(i)
        i = i+1
      }
      s
    }

    def map[U:Manifest](g: Rep[T] => Rep[U]) = new Iterator[U]{
      def size = self.size
      def seed = g(self.seed)
      def next(i: Rep[Int]) = g(self.next(i))
    }

    def fold(z:Rep[T], f: (Rep[T], Rep[T]) => Rep[T]) = new Iterator[T]{
      def size = self.size
      def seed = self.seed
      def next(i : Rep[Int]) = self.next(i)
      override def apply(begin: Rep[T]): Rep[T] = {
        var i = 0
        var s = z
        while(i <= size){
          s = f(s,next(i))
          i = i+1
        }
        s
      }

    }
  }

  def range(start: Rep[Int], end: Rep[Int]) : Iterator[Int] = new Iterator[Int]{
    def size = end - start
    def seed = start
    //def hasNext(i:Rep[Int]) = (i < end)
    def next(t: Rep[Int]) = t+unit(1)
  }



  //case class SimpleLoop[A](val size: Exp[Int], val v: Sym[Int], val body: Def[A]) extends AbstractLoop[A]

  //def simpleLoop[A:Manifest](size: Exp[Int], v: Sym[Int], body: Def[A]): Exp[A] = SimpleLoop(size, v, body)

/*  class IteratorOpsCls[A:Manifest](l: Rep[Iterator[A]]) {
    //def map[B:Manifest](f: Rep[A] => Rep[B]) = iterator_map(l,f)
    //def flatMap[B : Manifest](f: Rep[A] => Rep[Iterator[B]]) = iterator_flatMap(f)(l)
    //def filter(f: Rep[A] => Rep[Boolean]) = iterator_filter(l, f)
    //foldLeft
    //def fold[B:Manifest](z:Rep[B])(f: (Rep[B], Rep[A]) => Rep[B]) = iterator_fold(z,l,f)
    //def ++ (l2: Rep[Iterator[A]]) = iterator_concat(l, l2)

    //the real iterator ops ya know!
    //def isEmpty : Rep[Boolean] = iterator_isEmpty(l)
    //def next: Rep[A] = iterator_next(l)

  }*/

//  implicit def varToListOps[T:Manifest](x: Var[List[T]]) = new ListOpsCls(readVar(x)) // FIXME: dep on var is not nice
//  implicit def repToListOps[T:Manifest](a: Rep[List[T]]) = new ListOpsCls(a)
//  implicit def listToListOps[T:Manifest](a: List[T]) = new ListOpsCls(unit(a))



  def iterator_new[A:Manifest](start: Rep[A], hasNext: => Rep[Boolean],
      next: => Rep[Unit] )(implicit pos: SourceContext): Rep[Unit]
  //def list_fromseq[A:Manifest](xs: Rep[Seq[A]])(implicit pos: SourceContext): Rep[List[A]]
  //def iterator_map[A:Manifest,B:Manifest](l: Rep[Iterator[A]], f: Rep[A] => Rep[B])(implicit pos: SourceContext): Rep[Iterator[B]]
  //def iterator_flatMap[A : Manifest, B : Manifest](f: Rep[A] => Rep[Iterator[B]])(xs: Rep[Iterator[A]])(implicit pos: SourceContext): Rep[Iterator[B]]
  //def iterator_filter[A : Manifest](l: Rep[List[A]], f: Rep[A] => Rep[Boolean])(implicit pos: SourceContext): Rep[List[A]]
  //def iterator_concat[A:Manifest](xs: Rep[List[A]], ys: Rep[List[A]])(implicit pos: SourceContext) : Rep[Iterator[A]]

  //def iterator_isEmpty[A:Manifest](xs: Rep[List[A]])(implicit pos: SourceContext): Rep[Boolean]
  //der
}

trait IteratorOpsExp extends IteratorOps with EffectExp with VariablesExp with TupleOpsExp
  with WhileExp with NumericOpsExp with OrderingOpsExp with IfThenElseExp{
/*  case class ListNew[A:Manifest](xs: Seq[Rep[A]]) extends Def[List[A]]
  case class ListFromSeq[A:Manifest](xs: Rep[Seq[A]]) extends Def[List[A]]
  case class ListMap[A:Manifest,B:Manifest](l: Exp[List[A]], x: Sym[A], block: Block[B]) extends Def[List[B]]
  case class ListFlatMap[A:Manifest, B:Manifest](l: Exp[List[A]], x: Sym[A], block: Block[List[B]]) extends Def[List[B]]
  case class ListFilter[A : Manifest](l: Exp[List[A]], x: Sym[A], block: Block[Boolean]) extends Def[List[A]]
  case class ListSortBy[A:Manifest,B:Manifest:Ordering](l: Exp[List[A]], x: Sym[A], block: Block[B]) extends Def[List[A]]
  case class ListPrepend[A:Manifest](x: Exp[List[A]], e: Exp[A]) extends Def[List[A]]
  case class ListToArray[A:Manifest](x: Exp[List[A]]) extends Def[Array[A]]
  case class ListToSeq[A:Manifest](x: Exp[List[A]]) extends Def[Seq[A]]
  case class ListConcat[A:Manifest](xs: Rep[List[A]], ys: Rep[List[A]]) extends Def[List[A]]
  case class ListCons[A:Manifest](x: Rep[A], xs: Rep[List[A]]) extends Def[List[A]]
  case class ListMkString[A:Manifest](l: Exp[List[A]]) extends Def[String]
  case class ListHead[A:Manifest](xs: Rep[List[A]]) extends Def[A]
  case class ListTail[A:Manifest](xs: Rep[List[A]]) extends Def[List[A]]
  case class ListIsEmpty[A:Manifest](xs: Rep[List[A]]) extends Def[Boolean]
*/
  def iterator_new[A:Manifest](start: Rep[A], hasNext: => Exp[Boolean],
      next: => Exp[Unit])(implicit pos: SourceContext): Rep[Unit] = {
    var s = start
    while( hasNext){
      next
    }
  }

  //def iterator_map[A:Manifest,B:Manifest](l: Rep[Iterator[A]], f: Rep[A] => Rep[B])(implicit pos: SourceContext): Rep[Iterator[B]]
  //def iterator_flatMap[A : Manifest, B : Manifest](f: Rep[A] => Rep[Iterator[B]])(xs: Rep[Iterator[A]])(implicit pos: SourceContext): Rep[Iterator[B]]
  //def iterator_filter[A : Manifest](l: Rep[List[A]], f: Rep[A] => Rep[Boolean])(implicit pos: SourceContext): Rep[List[A]]
  //def iterator_concat[A:Manifest](xs: Rep[List[A]], ys: Rep[List[A]])(implicit pos: SourceContext) : Rep[Iterator[A]]

  //def iterator_isEmpty[A:Manifest](xs: Rep[List[A]])(implicit pos: SourceContext): Rep[Boolean]

  /*def list_map[A:Manifest,B:Manifest](l: Exp[List[A]], f: Exp[A] => Exp[B])(implicit pos: SourceContext) = {
    val a = fresh[A]
    val b = reifyEffects(f(a))
    reflectEffect(ListMap(l, a, b), summarizeEffects(b).star)
  }
  def list_flatMap[A:Manifest, B:Manifest](f: Exp[A] => Exp[List[B]])(l: Exp[List[A]])(implicit pos: SourceContext) = {
    val a = fresh[A]
    val b = reifyEffects(f(a))
    reflectEffect(ListFlatMap(l, a, b), summarizeEffects(b).star)
  }
  def list_filter[A : Manifest](l: Exp[List[A]], f: Exp[A] => Exp[Boolean])(implicit pos: SourceContext) = {
    val a = fresh[A]
    val b = reifyEffects(f(a))
    reflectEffect(ListFilter(l, a, b), summarizeEffects(b).star)
  }*/

/*  def list_toarray[A:Manifest](l: Exp[List[A]])(implicit pos: SourceContext) = ListToArray(l)
  def list_toseq[A:Manifest](l: Exp[List[A]])(implicit pos: SourceContext) = ListToSeq(l)
  def list_prepend[A:Manifest](l: Exp[List[A]], e: Exp[A])(implicit pos: SourceContext) = ListPrepend(l,e)
  def list_concat[A:Manifest](xs: Rep[List[A]], ys: Rep[List[A]])(implicit pos: SourceContext) = ListConcat(xs,ys)
  def list_cons[A:Manifest](x: Rep[A], xs: Rep[List[A]])(implicit pos: SourceContext) = ListCons(x,xs)
  def list_mkString[A:Manifest](l: Exp[List[A]])(implicit pos: SourceContext) = ListMkString(l)
  def list_head[A:Manifest](xs: Rep[List[A]])(implicit pos: SourceContext) = ListHead(xs)
  def list_tail[A:Manifest](xs: Rep[List[A]])(implicit pos: SourceContext) = ListTail(xs)
  def list_isEmpty[A:Manifest](xs: Rep[List[A]])(implicit pos: SourceContext) = ListIsEmpty(xs)

  override def mirror[A:Manifest](e: Def[A], f: Transformer)(implicit pos: SourceContext): Exp[A] = {
    (e match {
      case ListNew(xs) => list_new(f(xs))
      case _ => super.mirror(e,f)
    }).asInstanceOf[Exp[A]] // why??
  }

  override def syms(e: Any): List[Sym[Any]] = e match {
    case ListMap(a, x, body) => syms(a):::syms(body)
    case ListFlatMap(a, _, body) => syms(a) ::: syms(body)
    case ListFilter(a, _, body) => syms(a) ::: syms(body)
    case ListSortBy(a, x, body) => syms(a):::syms(body)
    case _ => super.syms(e)
  }

  override def boundSyms(e: Any): List[Sym[Any]] = e match {
    case ListMap(a, x, body) => x :: effectSyms(body)
    case ListFlatMap(_, x, body) => x :: effectSyms(body)
    case ListFilter(_, x, body) => x :: effectSyms(body)
    case ListSortBy(a, x, body) => x :: effectSyms(body)
    case _ => super.boundSyms(e)
  }

  override def symsFreq(e: Any): List[(Sym[Any], Double)] = e match {
    case ListMap(a, x, body) => freqNormal(a):::freqHot(body)
    case ListFlatMap(a, _, body) => freqNormal(a) ::: freqHot(body)
    case ListFilter(a, _, body) => freqNormal(a) ::: freqHot(body)
    case ListSortBy(a, x, body) => freqNormal(a):::freqHot(body)
    case _ => super.symsFreq(e)
  }
 */
}

trait ScalaGenIteratorOps extends ScalaGenWhile with ScalaGenVariables
  with ScalaGenTupleOps with ScalaGenNumericOps with ScalaGenOrderingOps with ScalaGenIfThenElse{
  val IR: IteratorOpsExp
}

/*trait ListOpsExpOpt extends ListOpsExp {
  override def list_concat[A : Manifest](xs1: Exp[List[A]], xs2: Exp[List[A]])(implicit pos: SourceContext): Exp[List[A]] = (xs1, xs2) match {
    case (Def(ListNew(xs1)), Def(ListNew(xs2))) => ListNew(xs1 ++ xs2)
    case _ => super.list_concat(xs1, xs2)
  }
}

trait BaseGenListOps extends GenericNestedCodegen {
  val IR: ListOpsExp
  import IR._

}

trait ScalaGenListOps extends BaseGenListOps with ScalaGenEffect {
  val IR: ListOpsExp
  import IR._

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case ListNew(xs) => emitValDef(sym, "List(" + (xs map {quote}).mkString(",") + ")")
    case ListConcat(xs,ys) => emitValDef(sym, quote(xs) + " ::: " + quote(ys))
    case ListCons(x, xs) => emitValDef(sym, quote(x) + " :: " + quote(xs))
    case ListHead(xs) => emitValDef(sym, quote(xs) + ".head")
    case ListTail(xs) => emitValDef(sym, quote(xs) + ".tail")
    case ListIsEmpty(xs) => emitValDef(sym, quote(xs) + ".isEmpty")
    case ListFromSeq(xs) => emitValDef(sym, "List(" + quote(xs) + ": _*)")
    case ListMkString(xs) => emitValDef(sym, quote(xs) + ".mkString")
    case ListMap(l,x,blk) =>
      stream.println("val " + quote(sym) + " = " + quote(l) + ".map{")
      stream.println(quote(x) + " => ")
      emitBlock(blk)
      stream.println(quote(getBlockResult(blk)))
      stream.println("}")
    case ListFlatMap(l, x, b) => {
      stream.println("val " + quote(sym) + " = " + quote(l) + ".flatMap { " + quote(x) + " => ")
      emitBlock(b)
      stream.println(quote(getBlockResult(b)))
      stream.println("}")
    }
    case ListFilter(l, x, b) => {
      stream.println("val " + quote(sym) + " = " + quote(l) + ".filter { " + quote(x) + " => ")
      emitBlock(b)
      stream.println(quote(getBlockResult(b)))
      stream.println("}")
    }
    case ListSortBy(l,x,blk) =>
      stream.println("val " + quote(sym) + " = " + quote(l) + ".sortBy{")
      stream.println(quote(x) + " => ")
      emitBlock(blk)
      stream.println(quote(getBlockResult(blk)))
      stream.println("}")
    case ListPrepend(l,e) => emitValDef(sym, quote(e) + " :: " + quote(l))
    case ListToArray(l) => emitValDef(sym, quote(l) + ".toArray")
    case ListToSeq(l) => emitValDef(sym, quote(l) + ".toSeq")
    case _ => super.emitNode(sym, rhs)
  }
}*/

/**

case class SimpleLoop[A](val size: Exp[Int], val v: Sym[Int], val body: Def[A]) extends AbstractLoop[A]

def simpleLoop[A:Manifest](size: Exp[Int], v: Sym[Int], body: Def[A]): Exp[A] = SimpleLoop(size, v, body)


override def syms(e: Any): List[Sym[Any]] = e match {
  case e: AbstractLoop[_] => syms(e.size) ::: syms(e.body) // should add super.syms(e) ?? not without a flag ...
  case _ => super.syms(e)
}

override def readSyms(e: Any): List[Sym[Any]] = e match {
  case e: AbstractLoop[_] => readSyms(e.size) ::: readSyms(e.body)
  case _ => super.readSyms(e)
}

override def boundSyms(e: Any): List[Sym[Any]] = e match {
  case e: AbstractLoop[_] => e.v :: boundSyms(e.body)
  case _ => super.boundSyms(e)
}

override def symsFreq(e: Any): List[(Sym[Any], Double)] = e match {
  case e: AbstractLoop[_] => freqNormal(e.size) ::: freqHot(e.body) // should add super.syms(e) ?? not without a flag ...
  case _ => super.symsFreq(e)
}
*/