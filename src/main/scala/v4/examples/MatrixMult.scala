package v4.examples
import v4._

// Matrix chain multiplication.
// Also demonstrates how to backtrack and apply
// efficiently the result to another domain/algebra.
trait MatrixSig extends Signature {
  type Alphabet = (Int,Int) // matrix as (rows, columns)
  val single:Alphabet=>Answer
  val mult:((Answer,Answer))=>Answer
}

// Computation cost algebra (in # of multiplications)
trait MatrixAlgebra extends MatrixSig {
  type Answer = (Int,Int,Int) // rows, cost, columns

  val single = (i: Alphabet) => (i._1, 0, i._2)
  val mult = (a:(Answer,Answer)) => a match {
    case((r1,m1,c1),(r2,m2,c2)) => (r1, m1 + m2 + r1 * c1 * c2, c2)
  }
  override val h = (l:List[Answer]) => l match {
    case Nil => Nil
    case _ => l.minBy(_._2)::Nil
  }
}

// Pretty-print algebra (could also be concrete multiplication)
// Note that the string grows along with the number of multiplications
trait PrettyPrintAlgebra extends MatrixSig {
  type Answer = String
  val single = (i:Alphabet) => "|"+i._1+"x"+i._2+"|"
  val mult = (a:(Answer,Answer)) => "("+a._1+"*"+a._2+")"
}

// Combining two algebra manually (inefficient)
trait PrettyMatrixAlgebra extends MatrixSig {
  object m extends MatrixAlgebra with MatrixGrammar
  object p extends PrettyPrintAlgebra with MatrixGrammar
  type Answer = (m.Answer,p.Answer)

  val single = (i: Alphabet) => (m.single(i), p.single(i))
  val mult = (a:(Answer,Answer)) => (m.mult((a._1._1,a._2._1)), p.mult((a._1._2,a._2._2)))
  override val h = (l :List[Answer]) => { val s=m.h(l.map(_._1)).toSet; l.filter(e=>s.contains(e._1)) }
}

// Matrix multiplication grammar (rules)
trait MatrixGrammar extends ADPParsers with CodeGen with MatrixSig {
  val matrixGrammar:Tabulate = tabulate("M",(
    el ^^ single
  | (matrixGrammar ~ matrixGrammar) ^^ mult // { case (a1,a2) => mult(a1, a2) }
  ) aggregate h)

  val axiom=matrixGrammar
}

// Demonstration of the manual cross product algebra
object MatrixMult extends MatrixGrammar with PrettyMatrixAlgebra with App {
  val input = List((10,100),(100,5),(5,50)).toArray
  println(parse(input))
  println(gen)
}

// Demonstration of the separate DP-backtrack / build process
object MatrixMult2 extends App {
  object a extends MatrixGrammar with MatrixAlgebra
  object b extends MatrixGrammar with PrettyPrintAlgebra
  val input = List((10,100),(100,5),(5,50)).toArray

  // Compute the matrix, and return the best solution's backtrack
  val (score,bt) = a.backtrack(input).head
  println("Score     : "+score)
  println("Backtrack : "+bt)

  // Apply the backtrack to another parser sharing the same grammar,
  // This will only compute 1 result in relevant cells, hence O(n).
  println("Result    : "+b.build(input,bt))
}
