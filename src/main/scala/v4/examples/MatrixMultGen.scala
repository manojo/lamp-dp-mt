package v4.examples
import v4._

// Matrix chain multiplication.
// We make all compromises to be able to generate code.
// Ultimately, we might want to infer as much information as possible instead of making it explicit

// Computation cost algebra (in # of multiplications)
trait MatrixAlgebraGen extends MatrixSig {
  type Answer = (Int,Int,Int) // rows, cost, columns
  
  val hf = new (Answer=>Int) with CFun {
    def apply(a:Answer) = a._2
    val args=List(("a","(Int,Int,Int)"))
    val body="return a._2;"
    val tpe ="Int"
  }

  override val h = minBy(hf)

  val single = new (Alphabet=>Answer) with CFun {
    def apply(i: Alphabet) = (i._1, 0, i._2)
    val args=List(("i","(Int,Int)"))
    val body="return (T3iii){i._1,0,i._2};"
    val tpe ="(Int,Int,Int)"
  }
  val mult = new ((Answer,Answer)=>Answer) with CFun {
    def apply(l:Answer,r:Answer) = { val ((r1,m1,c1),(r2,m2,c2))=(l,r); (r1, m1 + m2 + r1 * c1 * c2, c2) }
    val args=List(("l","(Int,Int,Int)"),("r","(Int,Int,Int)"))
    val body = "return (T3iii){l._1, l._2 + r._2 + l._1 * l._3 * r._3, r._3};"
    val tpe ="(Int,Int,Int)"
  }
}

// Matrix multiplication grammar (rules)
trait MatrixGrammarGen extends ADPParsers with CodeGen with MatrixSig {
  val matrixGrammar:Tabulate = tabulate("m",(
    el ^^ single
  | (matrixGrammar ~ matrixGrammar) ^^ mult
  ) aggregate h)

  // Let us be more fancy and define useless rules
  val fooBar:Tabulate = tabulate("m2",matrixGrammar aggregate h)

  val axiom=matrixGrammar
}

// Code generator only
object MatrixMultGen extends MatrixGrammarGen with MatrixAlgebraGen with App {
  val input = List((10,100),(100,5),(5,50)).toArray

  // ------- Extra codegen initialization
  val infty = 2147483647
  setDefaults((0,infty,0),(-1,infty,-1),"(Int,Int)")
  // ------- Extra codegen initialization

  println(gen)
}
