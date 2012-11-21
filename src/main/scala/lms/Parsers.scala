package lms

import scala.virtualization.lms.common._

/** Signature, taken from vanilla version */
/*trait Signature {
  type Alphabet // input type
  type Answer   // output type

//  def h(l: List[Answer]) : List[Answer]
//  val cyclic = false // cyclic problem
//  val window = 0     // windowing size, 0=disabled
}*/

trait Parsers extends ArrayOps with ListOps with NumericOps with IfThenElse
                 with LiftNumeric with Equal with BooleanOps with OrderingOps
                 with MathOps with HackyRangeOps with TupleOps{

  //DSL related type aliases and info
  //type Input = Rep[Array[Alphabet]]

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
    def +~~ [U:Manifest](that: => Parser[U]) = concat(1,0,0,0)(that)
    def +~+ [U:Manifest](that: => Parser[U]) = concat(1,0,1,0)(that)

    def *~~ [U:Manifest](lMin:Rep[Int], rRange:Pair[Int,Int], that: => Parser[U]) = concat(lMin,0,rRange._1,rRange._2)(that)
    def ~~* [U:Manifest](lRange:Pair[Rep[Int],Rep[Int]], rMin:Rep[Int], that: => Parser[U]) = concat(lRange._1,lRange._2,rMin,0)(that)
    def *~* [U:Manifest](lMin:Rep[Int], rMin:Rep[Int], that: => Parser[U]) = concat(lMin,0,rMin,0)(that)

    def ~~ [U:Manifest](lRange:Pair[Rep[Int],Rep[Int]], rRange:Pair[Rep[Int],Rep[Int]], that: => Parser[U]) = concat(lRange._1,lRange._2,rRange._1,rRange._2)(that)

    def -~~ [U:Manifest](that: => Parser[U]) = concat(1,1,0,0)(that)
    def ~~- [U:Manifest](that: => Parser[U]) = concat(0,0,1,1)(that)
  }

  // Memoization through tabulation
 /* import scala.collection.mutable.HashMap
  def tabulate(name:String, inner: => Parser[Answer]) = new Parser[Answer] {
    val map = tabs.getOrElseUpdate(name,new HashMap[Subword,List[Answer]])
    rules += ((name,this))

    def apply(sw: Subword) = sw match {
      case (i,j) if(i <= j) => map.getOrElseUpdate(if(cyclic) (i%size, j%size) else sw, inner(sw))
      case _ => List()
    }
  }*/

  /*************** simple parsers below *****************/

/*  def el(in: Input) = new Parser[Alphabet] {
    def apply(i: Rep[Int], j : Rep[Int]) =
      if(i+1==j) List(in(i)) else Nil
  }

  def eli(in: Input) = new Parser[Int] {
    def apply(i: Rep[Int], j : Rep[Int]) =
      if(i+1==j) List(i) else Nil
  }
*/
}

trait LexicalParsers extends Parsers{

  type Input = Rep[Array[Char]]

  //tabulation for Char parsers
  // Memoization through tabulation
  import scala.collection.mutable.HashSet
  //val costMatrices = new HashMap[String,Rep[Array[Array[List[List[Char]]]]]]

  val productions = new HashSet[String]
  def tabulate[T: Manifest](name:String,
    inner: Parser[T], mat: Rep[Array[Array[List[T]]]]
  ) = new Parser[T] {
    def apply(i: Rep[Int], j: Rep[Int]) =
      if(i <= j){

        if(!(productions contains(name)) /*&& res.isEmpty*/){
          productions += name
          mat(i)(j) = inner(i,j);
          productions -= name
          val a = mat(i)
          a(j)
        } else {
          val tmp = mat(i)
          tmp(j)
        }
      } else List()
  }

  //bottomup parsing
  /*def bottomUp(in: Input, p : Parser[List[Char]], costMatrix: Rep[Array[Array[List[List[Char]]]]]) = {
    //initialising the cost matrix
    (0 until in.length + 1).foreach{i =>
      (0 until in.length + 1).foreach{j =>
        val a = costMatrix(i)
        a(j) = List()
      }
    }

    (0 until in.length + 1).foreach{j =>
      (0 until j+1).foreach{i =>
        //TODO: extend range ops for descending ranges
        val a = costMatrix(j-i)
        a(j) = p(j-i,j)
      }
    }
  }*/

  def char(in: Input) = new Parser[Char]{
    def apply(i: Rep[Int], j : Rep[Int]) =
      if(i+1==j) List(in(i)) else List()
  }

  def charf(in: Input, c: Rep[Char]) = char(in) filter { (i: Rep[Int], j: Rep[Int]) =>
    (i + 1 == j) && in(i) == c
  }


  def myParser(in: Input) : Parser[Char] = {
    val a : Rep[Array[Array[List[Char]]]] = NewArray(in.length+1)
    (0 until in.length + 2).foreach{ i=>
      a(0) = NewArray(in.length+1)
    }

    tabulate("myParser",
      charf(in, 'm'),
      a
    )
  }


  def bla(in: Input) : Rep[List[Char]] = {
    //def p : Parser[List[Char]] = (charf(in, 'm') -~~ p) ^^ concatenate
    myParser(in)(0,in.length)//.head
  }

  def concatenate(t : Rep[(Char, List[Char])]) = t._1 :: t._2

}

trait ParsersExp extends Parsers with ArrayOpsExp with ListOpsExp with LiftNumeric
    with NumericOpsExp with IfThenElseExp with EqualExp with BooleanOpsExp
    with OrderingOpsExp with MathOpsExp with HackyRangeOpsExp with TupleOpsExp

object HelloParsers extends App {

  //import LoopsProgExp._

  val concreteProg = new LexicalParsers with ParsersExp { self =>
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