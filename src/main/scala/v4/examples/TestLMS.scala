package v4.examples
import v4._

object TestLMS extends App {
  // Matrix multiplication
  object mm extends Signature with LMSGenADP {
    type Alphabet = (Int,Int)
    type Answer = (Int,Int,Int) // col
    val tps=(manifest[Alphabet],manifest[Answer])

    override val h = minBy(lfun{ (a:Rep[Answer]) => a._2  })
    val single = lfun{ a:Rep[Alphabet] => (a._1, unit(0), a._2) }
    val mult = lfun{ p:Rep[(Answer,Answer)] => { val l=p._1; val r=p._2; (l._1, l._2 + r._2 + l._1 * l._3 * r._3, r._3) } }
    val axiom:Tabulate = tabulate("M",(el ^^ single | axiom ~ axiom ^^ mult) aggregate h)
    //override val window = 10

    //override val benchmark = true
    def test(name:String,ps:ParserStyle,mats:Input) {
      scala.Console.println("---------- "+name)
      var (res,bt) = backtrack(mats,ps).head
      scala.Console.println(res+" == "+build(mats,bt))
    }
  }

  object sw extends Signature with LMSGenTT {
    type Alphabet = Char
    type Answer = Int
    val tps=(manifest[Alphabet],manifest[Answer])
    override val cudaEmpty = "-100" // necessary as it is a numeric type

    override val h = max[Int] _
    val start = (x:Rep[Unit]) => unit(0)
    val gap1 = (v:Rep[((Int,Int),Int)]) => gap2(v._2,v._1) // by symmetry
    val gap2 = (v:Rep[(Int,(Int,Int))]) => { val d=v._2; val c=v._1 + unit(-2)+(d._2-d._1)*unit(-1); if (c < unit(0)) unit(0) else c }
    val pair = (v:Rep[(Char,(Int,Char))]) => { val r=v._2; r._1 + (if (v._1==r._2) unit(10) else unit(-3)) }
    val axiom:Tabulate = tabulate("M",(
      empty                   ^^ start
    | seq() -~ axiom          ^^ gap1
    |          axiom ~- seq() ^^ gap2
    | el1   -~ axiom ~- el2   ^^ pair
    ) aggregate h,true)

    def test(name:String,ps:ParserStyle,s1:Input,s2:Input) {
      scala.Console.println("---------- "+name)
      var (res,bt) = backtrack(s1,s2,ps).head
      scala.Console.println(res+" == "+build(s1,s2,bt))
    }
  }

  val s1=Utils.genDNA(40)
  val s2=Utils.genDNA(40)
  sw.test("Plain Scala (top-down)",sw.psTopDown,s1,s2)
  sw.test("Plain Scala (bottom-up)",sw.psBottomUp,s1,s2)
  scala.Console.println(sw.parse(s1,s2))
  sw.test("LMS Scala",sw.psScalaLMS,s1,s2)
  println("---------- LMS Scala (parse only)")
  println(sw.parse(s1,s2,sw.psScalaLMS).head)
  sw.test("CPU LMS",sw.psCPU,s1,s2)
  sw.test("GPU/CUDA LMS",sw.psCUDA,s1,s2)

  val mats = Utils.genMats(128) // scala.Array((1,2),(2,20),(20,2),(2,4),(4,2),(2,1),(1,7),(7,3)) // -> 1x3 matrix, 122 multiplications
  mm.test("Plain Scala (top-down)",mm.psTopDown,mats)
  mm.test("Plain Scala (bottom-up)",mm.psBottomUp,mats)
  mm.test("LMS Scala",mm.psScalaLMS,mats)
  println("---------- LMS Scala (parse only)")
  println(mm.parse(mats,mm.psScalaLMS).head)
  mm.test("CPU LMS",mm.psCPU,mats)
  mm.test("GPU/CUDA LMS",mm.psCUDA,mats)
}