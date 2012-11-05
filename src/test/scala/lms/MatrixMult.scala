package lmstest

import scala.virtualization.lms.common._
import lms._

//Rep world of matrix parsers
trait MatrixParsers extends ADPParsers{
  def aMatrix: Rep[Parser[(Int,Int)]]
}


trait MatrixGrammar extends MatrixParsers{
  override type Input = Array[(Int,Int)]

  def mult(x: ((Int,Int,Int),(Int,Int,Int))) =  x match {
    case((r1,m1,c1),(r2,m2,c2)) => (r1, m1 + m2 + r1 * c1 * c2, c2)
  }

    //create a new Ordering for triples of ints
  object TripleOrdering extends Ordering[(Int,Int,Int)]{
    def compare(a: (Int,Int,Int), b: (Int,Int,Int)) = a._2 compare b._2
  }

  def h(l :List[(Int,Int,Int)]) = l match{
    case Nil => Nil
    case _ => l.min::Nil
  }

}

object MatrixMult extends App{

  val interpretedProg = new MatrixGrammar with Interpreter{
    def input = List((10,100),(100,5),(5,50)).toArray

    def aMatrix = new Parser[(Int,Int)]{
      def apply(sw: Subword) = sw match {
        case (i,j) if(i+1 == j) => List(input(i))
        case _ => List()
      }
    }
    val matrixGrammar: Parser[(Int,Int,Int)] = ((
    //  aMatrix ^^ {single}
    aMatrix ^^ {x: (Int,Int) => (x._1, 0, x._2)}
    //| (matrixGrammar +~+ matrixGrammar) ^^ {case (a1,a2) => mult(a1, a2)}
    | (matrixGrammar +~+ matrixGrammar) ^^ mult
    ) aggregate h).tabulate

  }

  println(interpretedProg.matrixGrammar(0,interpretedProg.input.length))

}
