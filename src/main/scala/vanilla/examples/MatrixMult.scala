package vanilla.examples

import vanilla._

/**
 * Matrix multiplication
 */
trait MatrixSig extends Signature{
  case class Add(l: Answer, c: Alphabet, r: Answer)
  case class Mul(l: Answer, c: Alphabet, r: Answer)

  def single(i: (Int, Int)): Answer
  def mult(l: Answer, r: Answer): Answer
}

trait MatrixAlgebra extends MatrixSig{
  type Answer = (Int,Int,Int)
  type Alphabet = (Int,Int)

  //create a new Ordering for triples of ints
  object TripleOrdering extends Ordering[(Int,Int,Int)]{
    def compare(a: (Int,Int,Int), b: (Int,Int,Int)) = a._2 compare b._2
  }

  def single(i: (Int, Int)) = (i._1, 0, i._2)
  def mult(l: Answer, r: Answer) = (l,r) match {
    case((r1,m1,c1),(r2,m2,c2)) => (r1, m1 + m2 + r1 * c1 * c2, c2)
  }

  def h(l :List[Answer]) = l match{
    case Nil => Nil
    case _ => l.min::Nil
  }
}

trait PrettyPrintAlgebra extends MatrixSig{
  type Answer = String
  type Alphabet = (Int,Int)

  def single(i: (Int, Int)) = "|"+i._1+"x"+i._2+"|"
  def mult(l: Answer, r: Answer) = (l,r) match {
    case(s1,s2) => "("+s1+"*"+s2+")"
  }

  def h(l :List[Answer]) = l
}

/*
 * combining two algebrae: done manually for now
 */
trait PrettyMatrixAlgebra extends MatrixSig {
  type Answer = ((Int,Int,Int), String)
  type Alphabet = (Int,Int)

  //create a new Ordering for triples of ints
  object TripleOrdering extends Ordering[((Int,Int,Int),String)]{
    def compare(a: ((Int,Int,Int),String), b: ((Int,Int,Int),String)) =
      a._1._2 compare b._1._2
  }

  def single(i: (Int, Int)) = ((i._1, 0, i._2), "|"+i._1+"x"+i._2+"|")
  def mult(l: Answer, r: Answer) = (l,r) match {
    case(((r1,m1,c1),s1),((r2,m2,c2),s2)) =>
      ((r1, m1 + m2 + r1 * c1 * c2, c2), "("+s1+"*"+s2+")")
  }

  def h(l :List[Answer]) = l match{
    case Nil => Nil
    case _ => l.min::Nil
  }
}

trait MatrixGrammar extends ADPParsers with MatrixAlgebra {
  def aMatrix = new Parser[(Int,Int)]{
    def apply(sw: Subword) = sw match {
      case (i,j) if(i+1 == j) => List(input(i))
      case _ => List()
    }

    def tree = PTerminal("aMatrix")
  }

  def matrixGrammar: Parser[(Int,Int,Int)] = tabulate("M",(
    aMatrix ^^ single
  | (matrixGrammar +~+ matrixGrammar) ^^ {case (a1,a2) => mult(a1, a2)}
  ) aggregate h)
}

object MatrixMult extends MatrixGrammar with App{
  def input = List((10,100),(100,5),(5,50)).toArray
  println(matrixGrammar(0,input.length))
  println(gen)
}


trait MatrixGrammarB extends BDPParsers with MatrixAlgebra {
  def aMatrix = new Parser[(Int,Int)]{
    def apply(sw: Subword) = sw match {
      case (i,j) if(i+1 == j) => List(input(i))
      case _ => List()
    }

    def makeTree = SingleElem
  }

  val costMatrix: Array[Array[List[Answer]]]
   = Array.ofDim(input.length + 1, input.length +1)

  val matrixGrammar: Parser[(Int,Int,Int)] = ((
    aMatrix ^^ single
  | (matrixGrammar +~+ matrixGrammar) ^^ {case (a1,a2) => mult(a1, a2)}
  ) aggregate h).tabulate("M", costMatrix)
}

object MatrixMultB extends MatrixGrammarB with GenB with App{
  def input = Array((10,100),(100,5),(5,50))
  val costs = bottomUp(matrixGrammar, costMatrix)

  //println(costs(0)(0))
  for(i <- 0 to input.length){
    for(j <- 0 to input.length){
      print(
        costs(i)(j) + " "
        //if(costs(i)(j).isEmpty) "empty  " else costs(i)(j).head + " "
      )
    }
    println()
  }

  println(matrixGrammar(0,input.length))
}