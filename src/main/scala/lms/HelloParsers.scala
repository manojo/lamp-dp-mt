package lms

import scala.virtualization.lms.common._

trait Parsers extends ArrayOps with ListOps with NumericOps with IfThenElse
                 with LiftNumeric with Equal with BooleanOps with OrderingOps
                 with MathOps with HackyRangeOps with TupleOps{

  abstract class Parser[T:Manifest] extends ((Rep[Int], Rep[Int]) => Rep[List[T]]){inner =>

    def filter (p: (Rep[Int], Rep[Int]) => Rep[Boolean]) = new Parser {
      def apply(i: Rep[Int], j: Rep[Int]) = if(p(i,j)) inner(i,j) else List()
    }

    def ^^[U:Manifest](f: Rep[T] => Rep[U]) = this.map(f)
    private def map[U:Manifest](f: Rep[T] => Rep[U]) = new Parser[U]{
      def apply(i: Rep[Int], j: Rep[Int]) = inner(i,j) map f
    }

    def |(that: => Parser[T]) = or(that)
    private def or (that: => Parser[T]) = new Parser[T]{
      def apply(i: Rep[Int], j: Rep[Int]) = inner(i,j)++that(i,j)
    }

    def aggregate(h: Rep[List[T]] => Rep[List[T]]) = new Parser[T] {
      def apply(i: Rep[Int], j: Rep[Int]) = h(inner(i,j))
    }

    // Concatenate combinator.
    // Parses a concatenation of string left~right with length(left) in [lL,lU]
    // and length(right) in [rL,rU], lU,rU=0 means unbounded (infinity).
    private def concat[U:Manifest](lL:Rep[Int], lU:Rep[Int], rL:Rep[Int], rU:Rep[Int])(that: => Parser[U]) = new Parser[(T,U)] {
      def apply(i: Rep[Int], j: Rep[Int]) = if(i<j){
        val min_k = if (rU==0) i+lL else Math.max(i+lL,j-rU)
        val max_k = if (lU==0) j-rL else Math.min(j-rL,i+lU)
        for(
          k <- (min_k until max_k+1).toList;
          x <- inner(i,k);
          y <- that(k,j)
        ) yield((x,y))
      } else List()
    }

    def ~~~ [U:Manifest](that: => Parser[U]) = concat(0,0,0,0)(that)
    def ~~+ [U:Manifest](that: => Parser[U]) = concat(0,0,1,0)(that)

  }

  def char(in: Rep[Array[Char]]) = new Parser[Char]{
    def apply(i: Rep[Int], j: Rep[Int]): Rep[List[Char]] = if(i+1 == j) List(in(i)) else List()
  }

  def charf(in: Rep[Array[Char]], c: Rep[Char]) = char(in) filter { (i: Rep[Int], j: Rep[Int]) =>
    (i + 1 == j) && in(i) == c
  }

  def myParser(in: Rep[Array[Char]]) : Parser[Char] =
    char(in) ^^ (x=>x)

  def bla(in: Rep[Array[Char]]) : Rep[List[(Char,Char)]] = {
    val p = (charf(in, 'm') ~~+ charf(in, 'a'))
    p(0,2)
  }

}

trait ParsersExp extends Parsers with ArrayOpsExp with ListOpsExp with LiftNumeric
    with NumericOpsExp with IfThenElseExp with EqualExp with BooleanOpsExp
    with OrderingOpsExp with MathOpsExp with HackyRangeOpsExp with TupleOpsExp

object HelloParsers extends App {

  //import LoopsProgExp._

  val concreteProg = new Parsers with ParsersExp { self =>
    val codegen = new ScalaGenArrayOps with ScalaGenListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
      with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
      with ScalaGenHackyRangeOps with ScalaGenTupleOps{ val IR: self.type = self }

    codegen.emitSource(bla, "bla", new java.io.PrintWriter(System.out))

  }

  //val f = (x:Rep[Double]) => fac(x) + fac(2.0 *x)
  //println(globalDefs.mkString("\n"))
  //println(f)
  //val p = new CudaGenNumericOps with CudaGenMathOps with CudaGenEqual with
  //  CudaGenIfThenElse with CudaGenFunctions { val IR: FacProgExp.type = FacProgExp }
}