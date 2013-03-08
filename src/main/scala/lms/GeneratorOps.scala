package lms

import java.io.PrintWriter

import scala.virtualization.lms.common._
import scala.virtualization.lms.internal.GenericNestedCodegen
import scala.reflect.SourceContext

trait GeneratorOps extends Variables with While with LiftVariables
  with MyRangeOps with NumericOps with OrderingOps with IfThenElse
  with MiscOps with EmbeddedControls with Equal {

  object Gen {
    def fSeq[A:Manifest](xs: Rep[A]*)(implicit pos: SourceContext) = fromSeq(xs)
  }

  abstract class Generator[T:Manifest] extends ((Rep[T] => Rep[Unit]) => Rep[Unit]) {self =>

    def map[U:Manifest](g: Rep[T] => Rep[U]) = new Generator[U]{
      def apply(f: Rep[U] => Rep[Unit]) = self.apply{
        x:Rep[T] => f(g(x))
      }
    }

    def filter(p: Rep[T] => Rep[Boolean]) = new Generator[T]{
      def apply(f: Rep[T] => Rep[Unit]) = self.apply{
        x:Rep[T] => if(p(x)) f(x)
      }
    }

    def ++(that: Generator[T]) = new Generator[T]{
      def apply(f: Rep[T] => Rep[Unit]) = {
        self.apply(f)
        that.apply(f)
      }
    }

    def flatMap[U:Manifest](g: Rep[T] => Generator[U]) = new Generator[U]{
      def apply(f: Rep[U] => Rep[Unit]) = self.apply{ x:Rep[T] =>
        val tmp : Generator[U] = g(x)
        tmp(f)
      }
    }

    def reduce(h:(Rep[T],Rep[T])=>Rep[T], z:Rep[T]) = new Generator[T] {
      def apply(f: Rep[T] => Rep[Unit]) = {
        var best = z;
        self.apply { x:Rep[T] => if (best==z) best=x; else best=h(best,x) }
        if (best!=z) f(best)
      }
    }
  }

  def range(start: Rep[Int], end: Rep[Int]) : Generator[Int] = {
    val tmp = new Generator[Int]{
      def apply(f: Rep[Int] => Rep[Unit]) = {
        for(i <- start until end){
          f(i)
        }
      }
    }
    cond((start < end), tmp, emptyGen())
  }

  def fromSeq[A:Manifest](xs: Seq[Rep[A]]): Generator[A] =
    if(xs.isEmpty) emptyGen()
    else if(xs.length == 1) elGen(xs.head)
    else elGen(xs.head) ++ fromSeq(xs.tail)

  def emptyGen[A:Manifest](): Generator[A] = new Generator[A]{
    def apply(f: Rep[A] => Rep[Unit]) = {}
  }

  def elGen[A:Manifest](a: Rep[A]): Generator[A] = new Generator[A]{
    def apply(f: Rep[A] => Rep[Unit]) = {
      f(a)
    }
  }

  def cond[A:Manifest](cond: Rep[Boolean], a: Generator[A], b: Generator[A]) = new Generator[A]{
    def apply(f: Rep[A] => Rep[Unit]) = {
      if(cond) a(f) else b(f)
    }
  }
}

trait GeneratorOpsExp extends GeneratorOps with EffectExp with VariablesExp
  with MyRangeOpsExp with WhileExp with NumericOpsExp with OrderingOpsExp
  with IfThenElseExp with MiscOpsExp{

  //a Let tree for
  case class Let[T: Manifest,U: Manifest](x: Sym[T], rhs: Exp[T], body: Block[U]) extends Def[U]

  def let[T: Manifest,U: Manifest](x: Sym[T], rhs: Exp[T], b: => Exp[U]): Rep[U] = {
    val body = reifyEffects(b)
    val s = summarizeEffects(body)
    reflectEffect(Let(x,rhs,body), s)
  }


  override def boundSyms(e: Any): List[Sym[Any]] = e match {
    case Let(x, rhs, block) => x :: effectSyms(block)
    case _ => super.boundSyms(e)
  }
}

trait ScalaGenGeneratorOps extends ScalaGenWhile with ScalaGenVariables
  with ScalaGenMyRangeOps with ScalaGenNumericOps with ScalaGenOrderingOps
  with ScalaGenIfThenElse with ScalaGenMiscOps{
  val IR: GeneratorOpsExp
  import IR._

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case Let(x,y,blk) =>
      stream.println("val "+ quote(x) + " = "+ quote(y))
      emitBlock(blk)
      emitValDef(sym,quote(getBlockResult(blk)) )

    case _ => super.emitNode(sym, rhs)
  }

}

trait CGenGeneratorOps extends CGenWhile with CGenVariables
  with CGenMyRangeOps with CGenNumericOps with CGenOrderingOps
  with CGenIfThenElse with CGenMiscOps{
  val IR: GeneratorOpsExp
  import IR._

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case Let(x,y,blk) =>
      stream.println("val "+ quote(x) + " = "+ quote(y))
      emitBlock(blk)
      emitValDef(sym,quote(getBlockResult(blk)) )

    case _ => super.emitNode(sym, rhs)
  }

}