package lms

import scala.virtualization.lms.common._

import java.io.PrintWriter
import scala.virtualization.lms.internal.GenericNestedCodegen
import scala.reflect.SourceContext

trait GeneratorOps extends Variables with While with LiftVariables with TupleOps
  with HackyRangeOps with NumericOps with OrderingOps with IfThenElse with EmbeddedControls{

  abstract class Generator[T:Manifest] extends ((Rep[T] => Rep[Unit]) => Unit) {self =>

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
  }

  def range(start: Rep[Int], end: Rep[Int]) : Generator[Int] = new Generator[Int]{
    def apply(f: Rep[Int] => Rep[Unit]) {
      for(i <- start until end){
        f(i)
      }
    }
  }
}

trait GeneratorOpsExp extends GeneratorOps with EffectExp with VariablesExp with TupleOpsExp
  with HackyRangeOpsExp with WhileExp with NumericOpsExp with OrderingOpsExp with IfThenElseExp

trait ScalaGenGeneratorOps extends ScalaGenWhile with ScalaGenVariables
  with ScalaGenHackyRangeOps with ScalaGenTupleOps with ScalaGenNumericOps with ScalaGenOrderingOps with ScalaGenIfThenElse{
  val IR: GeneratorOpsExp
}