package v3.examples
import v3._

// Matrix multiplication
trait MatrixSig extends Signature {
  type Alphabet = (Int,Int) // matrix dimensions: (rows, columns)

  def single(i: Alphabet): Answer
  def mult(l: Answer, r: Answer): Answer
}

// Algebrae
trait MatrixAlgebra extends MatrixSig {
  type Answer = (Int,Int,Int) // rows, cost, columns

  def single(i: Alphabet) = (i._1, 0, i._2)
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

  def single(i: Alphabet) = "|"+i._1+"x"+i._2+"|"
  def mult(l: Answer, r: Answer) = "("+l+"*"+r+")"
  def h(l :List[Answer]) = l
}

// Combining two algebrae
trait PrettyMatrixAlgebra extends MatrixSig {
  object m extends MatrixAlgebra
  object p extends PrettyPrintAlgebra
  type Answer = (m.Answer,p.Answer)

  def single(i: Alphabet) = (m.single(i), p.single(i))
  def mult(l: Answer, r: Answer) = (m.mult(l._1,r._1), p.mult(l._2,r._2))
  def h(l :List[Answer]) = { val s=m.h(l.map(_._1)).toSet; l.filter(e=>s.contains(e._1)) } 
}

trait MatrixGrammar extends ADPParsers with MatrixSig {
  val matrixGrammar: Parser[Answer] = tabulate("M",(
    el ^^ single
  | (matrixGrammar +~+ matrixGrammar) ^^ { case (a1,a2) => mult(a1, a2) }
  ) aggregate h)
}

object MatrixMult extends MatrixGrammar with PrettyMatrixAlgebra with App {
  val input = List((10,100),(100,5),(5,50)).toArray

  println(parse(matrixGrammar)(input))
  println(gen)
}
