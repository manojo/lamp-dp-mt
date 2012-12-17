package v4lms.examples
import v4lms._

// Matrix chain multiplication.
// Also demonstrates how to backtrack and apply
// efficiently the result to another domain/algebra.
trait MatrixSig extends Signature {
  type Alphabet = (Int,Int) // matrix as (rows, columns)
  val single:Alphabet=>Answer
  val mult:(Answer,Answer)=>Answer
}

// Computation cost algebra (in # of multiplications)
trait MatrixAlgebra extends MatrixSig {
  type Answer = (Int,Int,Int) // rows, cost, columns

  val single = (i: Alphabet) => (i._1, 0, i._2)
  val mult = (l:Answer,r:Answer) => (l,r) match {
    case((r1,m1,c1),(r2,m2,c2)) => (r1, m1 + m2 + r1 * c1 * c2, c2)
  }
  override val h = (l:List[Answer]) => l match {
    case Nil => Nil
    case _ => l.minBy(_._2)::Nil
  }
}

// Matrix multiplication grammar (rules)
trait MatrixGrammar extends ADPParsers with MatrixSig {
  val matrixGrammar:Tabulate = tabulate("M",(
 //   el ^^ single
//  |
    (matrixGrammar ~ matrixGrammar) ^^ mult // { case (a1,a2) => mult(a1, a2) }
  ) aggregate h)

  val axiom=matrixGrammar
}

// Demonstration of the manual cross product algebra
object MatrixMult extends MatrixGrammar with MatrixAlgebra with App {
  val mAlphabet = manifest[Alphabet]
  val mAnswer = manifest[Answer]

  val input = List((10,100),(100,5),(5,50)).toArray
  println(parse(input))
}
