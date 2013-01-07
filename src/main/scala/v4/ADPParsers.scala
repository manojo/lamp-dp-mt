package v4

trait ADPParsers extends BaseParsers { this:Signature =>
  // I/O interface
  private var input: Input = null
  def in(k:Int):Alphabet = input(k)
  def size:Int = input.size
  def parse(in:Input,forceScala:Boolean=false):List[Answer] = this match {
    case c:CodeGen if (!forceScala) => List(c.parseCU(in.asInstanceOf[c.Input]).asInstanceOf[Answer])
    case _ => run(in,()=>(if (window>0) aggr(((0 to size-window).flatMap{x=>axiom(x,window+x)}).toList, h) else axiom(0,size)).map{_._1})
  }
  def backtrack(in:Input,forceScala:Boolean=false):List[(Answer,List[(Subword,Backtrack)])] = this match {
    case c:CodeGen if (!forceScala) => List(c.backtrackCU(in.asInstanceOf[c.Input]).asInstanceOf[(Answer,List[(Subword,Backtrack)])])
    case _ => run(in,()=>if (window>0) aggr(((0 to size-window).flatMap{x=>axiom.backtrack(x,window+x)}).toList, h) else axiom.backtrack(0,size))
  }
  def build(in:Input,bt:List[(Subword,Backtrack)]):Answer = run(in, ()=>axiom.build(bt))
  private def run[T](in:Input, f:()=>T) = { input=in; analyze; val res=time("Execution")(f); input=null; reset(); res }

  // Concatenation operations
  import scala.language.implicitConversions
  implicit def parserADP[T](p1:Parser[T]) = new ParserADP(p1)
  class ParserADP[T](p1:Parser[T],idx:(Int,Int,Int,Int)=null) {
    def ~ [U](p2:Parser[U]) = if (idx!=null) new Concat(p1,p2,0) { override lazy val indices=idx } else new Concat(p1,p2,0)
    def ~ (minl:Int,maxl:Int,minr:Int,maxr:Int):ParserADP[T] = new ParserADP[T](p1,(minl,maxl,minr,maxr))
  }

  // Terminal parsers
  val empty = new Terminal[Unit](0,0,(i:Var,j:Var) => (Nil,"")) {
    def apply(sw:Subword) = sw match { case (i,j) => if (i==j) List(({},bt0)) else Nil }
  }
  val emptyi = new Terminal[Int](0,0,(i:Var,j:Var) => (Nil,"("+i+")")) {
    def apply(sw:Subword) = sw match { case (i,j) => if (i==j) List((i,bt0)) else Nil }
  }
  val el = new Terminal[Alphabet](1,1,(i:Var,j:Var) => (Nil,"in1["+i+"]")) {
    def apply(sw:Subword) = sw match { case (i,j) => if(i+1==j) List((in(i),bt0)) else Nil }
  }
  val eli = new Terminal[Int](1,1,(i:Var,j:Var) => (Nil,"("+i+")")) {
    def apply(sw:Subword) = sw match { case (i,j) => if(i+1==j) List((i,bt0)) else Nil }
  }
  def seq(min:Int=1, max:Int=maxN) = new Terminal[Subword](min,max,(i:Var,j:Var) => (Nil,"(T2ii){"+i+","+j+"}")) {
    def apply(sw:Subword) = sw match { case (i,j) => if (i+min<=j && (max==maxN || i+max>=j)) List(((i,j),bt0)) else Nil }
  }
}

trait LexicalParsers extends ADPParsers { this:Signature =>
  override type Alphabet = Char
  def char = el
  def chari = eli
  def charf(f: Char => Boolean) = el filter { // TODO: CUDA version
    case(i,j) if(i+1==j) => f(in(i))
    case _ => false
  }
  def digit: Parser[Int] = (charf {_.isDigit}) ^^ { c=>(c-'0').toInt } // TODO: CUDA version

  import scala.language.implicitConversions
  implicit def toCharArray(s:String):Array[Char] = s.toArray
}
