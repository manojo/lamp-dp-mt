package v2.examples

import v2._

// Matrix multiplication
trait MatrixSig extends Signature {
  type Alphabet = (Int,Int) // matrix dimensions: (rows, columns)

  def single(i: (Int, Int)): Answer
  def mult(l: Answer, r: Answer): Answer
}

trait MatrixAlgebra extends MatrixSig {
  type Answer = (Int,Int,Int) // rows, cost, columns

  def single(i: (Int, Int)) = (i._1, 0, i._2)
  def mult(l: Answer, r: Answer) = (l,r) match {
    case((r1,m1,c1),(r2,m2,c2)) => (r1, m1 + m2 + r1 * c1 * c2, c2)
  }

  def h(l :List[Answer]) = l match {
    case Nil => Nil
    case _ => l.minBy(_._2)::Nil
  }
}

trait PrettyPrintAlgebra extends MatrixSig {
  type Answer = String

  def single(i: (Int, Int)) = "|"+i._1+"x"+i._2+"|"
  def mult(l: Answer, r: Answer) = (l,r) match {
    case(s1,s2) => "("+s1+"*"+s2+")"
  }

  def h(l :List[Answer]) = l
}

// Combining two algebrae: done manually for now
// Useful? http://www.chuusai.com/2011/06/09/scala-union-types-curry-howard/
trait PrettyMatrixAlgebra extends MatrixSig {
  type Answer = ((Int,Int,Int), String)

  def single(i: (Int, Int)) = ((i._1, 0, i._2), "|"+i._1+"x"+i._2+"|")
  def mult(l: Answer, r: Answer) = (l,r) match {
    case(((r1,m1,c1),s1),((r2,m2,c2),s2)) =>
      ((r1, m1 + m2 + r1 * c1 * c2, c2), "("+s1+"*"+s2+")")
  }

  def h(l :List[Answer]) = l match {
    case Nil => Nil
    case _ => l.minBy(_._1._2)::Nil
  }
}

trait MatrixGrammar extends ADPParsers with MatrixSig {
  /*
  def aMatrix = new Parser[(Int,Int)] {
    def apply(sw: Subword) = if(sw._1+1 == sw._2) List(in(i)) else Nil
    def tree = PTerminal((i:Var,j:Var) => (List(i.e(j,1)),"mat["+i+"]"))
  }
  */
  def aMatrix = el

  def matrixGrammar: Parser[Answer] = tabulate("M",(
    aMatrix ^^ single
  | (matrixGrammar +~+ matrixGrammar) ^^ { case (a1,a2) => mult(a1, a2) }
  ) aggregate h)
}

object MatrixMult extends App with MatrixGrammar with PrettyMatrixAlgebra {
  val input = List((10,100),(100,5),(5,50)).toArray

  println(parse(matrixGrammar)(input))
  println(gen)
}
