package v4.examples
import v4._

// Matrix chain multiplication with outrageously complicated structures.

case class Num(i:Int,f:Float)
case class Mat(rows:Num,cols:Num)

trait MatrixMultGen2Sig extends Signature {

  type Alphabet = Mat
  type Answer = (Num,Mat) // cost, (rows,columns)

  val tpAlph = "v4.examples.Mat"
  val tpAns = "scala.Tuple2[v4.examples.Num, v4.examples.Mat]"

  val hf = new (Answer=>Int) with CFun {
    def apply(a:Answer) = a._1.i
    val args=List(("a",tpAns))
    val body="return a._1.i;"
    val tpe ="Int"
  }
  override val h = minBy(hf)

  val single = new (Alphabet=>Answer) with CFun {
    def apply(i: Alphabet) = (Num(0,0),i)
    val args=List(("i",tpAlph))
    val body="num_t z={0,0}; return (T2_num_mat){z,i};"
    val tpe = tpAns
  }
  val mult = new ((Answer,Answer)=>Answer) with CFun {
    def apply(l:Answer,r:Answer) = { (Num(l._1.i+r._1.i+ l._2.rows.i * l._2.cols.i * r._2.cols.i ,0),Mat(l._2.rows,r._2.cols)) }
    val args=List(("l",tpAns),("r",tpAns))
    val body = "return (T2_num_mat){ (num_t){l._1.i+r._1.i+ l._2.rows.i * l._2.cols.i * r._2.cols.i ,0}, (mat_t){l._2.rows,r._2.cols} };"
    val tpe = tpAns
  }
}

// Matrix multiplication grammar (rules)
trait MatrixMultGen2Grammar extends ADPParsers with MatrixMultGen2Sig {
  val matrixGrammar:Tabulate = tabulate("m1",(
    el ^^ single
  | (matrixGrammar ~ matrixGrammar) ^^ mult
  ) aggregate h,true)

  // Let us be more fancy and define testing
  val fooBar:Tabulate = tabulate("m2",matrixGrammar aggregate h)

  val ps = new ((Int,Int)=>Boolean) with CFun {
    def apply(i:Int,j:Int) = i%2==j%2
    val args=List(("i","Int"),("j","Int"))
    val body = "return i%2==j%2;"
    val tpe = "Boolean"
  }

  val ffail = new Terminal[Answer](0,0,(i:Var,j:Var)=>(List(CUser("1==0")),"(T2_num_mat){}") ) { def apply(sw:Subword) = Nil }
  val nestedAggr = tabulate("aggr",( // complexity = O(n^2) / element
    (ffail ~ matrixGrammar ^^ mult aggregate h) ~
    ((matrixGrammar filter ps filter ps) ~ matrixGrammar ^^ mult aggregate h) ^^ mult
  ) aggregate h)

  val axiom=matrixGrammar
}

// Code generator only
object MatrixMultGen2 extends MatrixMultGen2Grammar with CodeGen with App {
  //val input = List((10,100),(100,5),(5,50)).toArray
  val input = List((1,2),(2,20),(20,2),(2,4),(4,2),(2,1),(1,7),(7,3)).map{case (a,b)=>Mat(Num(a,0),Num(b,0)) }.toArray // -> 1x3, 122 multiplications
  override val window = 3 // only 3 consecutive matrices (aka 2x4, 4x2, 2x1 => 16)

  // ------- Extra codegen initialization
  override val benchmark = true
  override val tps = (manifest[Alphabet],manifest[Answer])
  // ------- Extra codegen initialization
  //println(gen)
  println(backtrack(input).head)
}
