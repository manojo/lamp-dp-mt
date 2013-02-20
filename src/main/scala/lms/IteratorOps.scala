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

    def ++(that: Iterator[T]) = new Iterator[T]{
      def size = self.size + that.size
      def seed = self.seed
      def next(i : Rep[Int]) =
        if(i < self.size) self.next(i) else that.next(i - self.size)
    }
  }

  def range(start: Rep[Int], end: Rep[Int]) : Iterator[Int] = new Iterator[Int]{
    def size = end - start
    def seed = start
    //def hasNext(i:Rep[Int]) = (i < end)
    def next(t: Rep[Int]) = t+unit(1)
  }
}

trait IteratorOpsExp extends IteratorOps with EffectExp with VariablesExp with TupleOpsExp
  with WhileExp with NumericOpsExp with OrderingOpsExp with IfThenElseExp

trait ScalaGenIteratorOps extends ScalaGenWhile with ScalaGenVariables
  with ScalaGenTupleOps with ScalaGenNumericOps with ScalaGenOrderingOps with ScalaGenIfThenElse{
  val IR: IteratorOpsExp
}