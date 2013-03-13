package lms2

trait ADPParsers extends BaseParsersExp { this:Signature =>
  val grammar:Rep[Input]=>Tabulate

  def parse(in:Rep[Input])(implicit mAns:Manifest[Answer]):Rep[List[Answer]] = {
    List[Answer]() // Stub
  }
  def backtrack(in:Rep[Input])(implicit mAns:Manifest[Answer]):Rep[List[(Answer,Trace)]] = {
    List[(Answer,Trace)]() // Stub
  }
  def build(in:Rep[Input],trace:Rep[Trace])(implicit mAns:Manifest[Answer]):Rep[Answer] = {
    unit(null.asInstanceOf[Answer]) // Stub
  }

  // LEGACY I/O interface
  //private var input: Rep[Input] = unit(null)
  //def in(k:Rep[Int]):Rep[Alphabet] = input(k)
  //def size:Rep[Int] = input.length
/*
  def parse(in:Rep[Input]):List[Answer] = run(in,()=>{parseBottomUp; axiom(0,size).map(_._1)})
  def backtrack(in:Rep[Input]):List[(Answer,Trace)] = run(in,()=>{parseBottomUp; axiom.backtrack(0,size)})
  def build(in:Rep[Input],bt:Rep[Trace]):Answer = run(in,()=>axiom.build(bt))
  private def run[T](in:Rep[Input], f:()=>T) = { input=in; analyze; tabInit(in.size+1,in.size+1); val res=f(); tabReset; input=null; res }
  private def parseBottomUp:Unit = {
    val rs=rulesOrder map {n=>rules(n)}; var d=0; while (d<=size) { for (r<-rs) { val iu=size-d; var i=0; while (i<=iu) { r.compute(i,d+i); i=i+1 } }; d=d+1; }
  }
*/

  // Concatenation operations
  import scala.language.implicitConversions
  implicit def parserADP[T:Manifest](p1:Parser[T]) = new ParserADP(p1)
  class ParserADP[T:Manifest](p1:Parser[T],idx:(Int,Int,Int,Int)=null) {
    def ~ [U:Manifest](p2:Parser[U]) = { if (idx.eq(null)) new Concat(p1,p2,0) { override lazy val indices=idx } else new Concat(p1,p2,0) }
    def ~ (minl:Int,maxl:Int,minr:Int,maxr:Int):ParserADP[T] = new ParserADP[T](p1,(minl,maxl,minr,maxr))
  }

  // Terminal parsers
  val empty = new Terminal[Unit](0,0,unit(null)) { def apply(i:Rep[Int],j:Rep[Int]) = if (i==j) List((unit({}),bt0)) else List[(Unit,Backtrack)]() }
  val emptyi = new Terminal[Int](0,0,unit(null)) { def apply(i:Rep[Int],j:Rep[Int]) = if (i==j) List((i,bt0)) else List[(Int,Backtrack)]() }
  val eli = new Terminal[Int](1,1,unit(null)) { def apply(i:Rep[Int],j:Rep[Int]) = if(i+1==j) List((i,bt0)) else List[(Int,Backtrack)]() }
  def el(in:Rep[Input])(implicit mAlph:Manifest[Alphabet]) = new Terminal[Alphabet](1,1,in) {
    def apply(i:Rep[Int],j:Rep[Int]) = if(i+1==j) List((in(i),bt0)) else List[(Alphabet,Backtrack)]()
  }
  def seq(in:Rep[Input],min:Int=1, max:Int=maxN) = new Terminal[(Int,Int)](min,max,in) {
    def apply(i:Rep[Int],j:Rep[Int]) = if (i+unit(min)<=j && (max==maxN || i+unit(max)>=j)) { val p:Rep[(Int,Int)]=(i,j); List((p,bt0)) } else List[((Int,Int),Backtrack)]()
  }
}

//import scala.virtualization.lms.common._
import lms._
object MatrixMult2 extends App with Signature with ADPParsers /*with ScalaGenPackage*/ {
  type Alphabet = (Int,Int) // matrix as (rows, columns)
  type Answer = (Int,Int,Int) // rows, cost, columns

  val mAlph = manifest[Alphabet]
  val mAns  = manifest[Answer]

  // Algebra
  def single(i: Rep[Alphabet]) = (i._1, unit(0), i._2)
  def mult(m:Rep[(Answer,Answer)]):Rep[Answer] = { val l=m._1; val r=m._2; (l._1, l._2 + r._2 + l._1 * l._3 * r._3, r._3) }
  def h(a:Rep[Answer],b:Rep[Answer]) = if (a._2 < b._2) a else b

  // Grammar
  val grammar = (in:Rep[Input]) => {
    lazy val axiom:Tabulate = tabulate("M",( // XXX: can we get rid of the name? it was used only for CUDA codegen
      el(in)          ^^ single
    | (axiom ~ axiom) ^^ mult
    ) aggregate h,true)
    axiom // return the axiom of grammar
  }

  // compile axiom for (apply,unapply,reapply)

  // XXX: I'm missing one trait somewhere
  //codegen.emitSource(parse(grammar) _, "testParse", new java.io.PrintWriter(System.out))
  //val progParse = compile(parse(grammar))

  val input = Array((1,2),(2,20),(20,2),(2,4),(4,2),(2,1),(1,7),(7,3)) // -> 1x3 matrix, 122 multiplications
  /*
  val (score,bt) = backtrack(input).head
  println("Score     : "+score)
  println("Backtrack : "+bt)
  println("Reapply   : "+build(input,bt))
  */
}

/*
trait LexicalParsers extends ADPParsers { this:Signature =>
  override type Alphabet = Char
  // Predefined terminals
  def char(in:Rep[Input]) = el(in)
  val chari = eli

  //val letter = char filter cf((c:Char)=>(c>='a' && c<='z') || (c>='A' && c<='Z'),"return (c>='a' && c<='z') || (c>='A' && c<='Z');")
  //val digit = (char filter cf((c:Char)=>c>='0' && c<='9',"return c>='0' && c<='9';"))
  /*
  //def charf(s:String) = char filter cf((c:Char)=>s.indexOf(c)!= -1,"const char* s=\""+esc(s)+"\"; for(;*s;++s) { if (*s==c) return true; } return false;")
  //def charf(c0:Char) = char filter cf((c:Char)=>c==c0,"return c=='"+esc(""+c0)+"';")

  // Predefined filters
  def length(min:Int=0,max:Int= -1) = cfun2((i:Int,j:Int)=> (j-i)>=min && (max < 0 || j-i<=max), "i,j","return j-i>="+min+(if(max>=0)" && j-i<="+max else "")+";")

  import scala.language.implicitConversions
  implicit def toCharArray(s:String):Array[Char] = s.toArray
  private def esc(s:String) = (s /: List(('\\','\\'),('"','"'),('\'','\''),('\n','n'),('\r','r'),('\t','t'),('\0','0'),('\b','b'),('\f','f'))) {case (s,(a,b))=>s.replace(""+a,"\\"+b)}
  private def cf(f:Char=>Boolean,cc:String) = cfun1((i:Int,j:Int) => (i+1==j) && f(in(i)),"i,j","if (i+1!=j) return false; c=_in1[i]; "+cc)
  def in(k:Int):Char
  */
}
*/