package v4

trait ADPParsers extends BaseParsers { this:Signature =>
  // I/O interface
  private var input: Input = null
  def in(k:Int):Alphabet = input(k)
  def size:Int = input.size 
  def parse(in:Input):List[Answer] = {
    run(in,()=>(if (window>0) aggr(((0 to size-window).flatMap{x=>axiom(x,window+x)}).toList, h) else axiom(0,size)).map{_._1})
  }
  def backtrack(in:Input):List[(Answer,List[(Subword,Backtrack)])] = { 
    run(in,()=>if (window>0) aggr(((0 to size-window).flatMap{x=>axiom.backtrack(x,window+x)}).toList, h) else axiom.backtrack(0,size))
  }
  def build(in:Input,bt:List[(Subword,Backtrack)]):Answer = run(in, ()=>axiom.build(bt))
  private def run[T](in:Input, f:()=>T) = { analyze; input=in; val res=f(); input=null; reset(); res }

  // Concatenation operations
  import scala.language.implicitConversions
  implicit def parserADP[T](p1:Parser[T]) = new ParserADP(p1)
  class ParserADP[T](p1:Parser[T]) { def ~ [U](p2:Parser[U]) = new Concat(p1,p2,0) }

  // Terminal parsers
  def empty = new Terminal[Dummy](0,0,(i:Var,j:Var) => (List(i.eq(j,0)),"EMPTY")) {
    def apply(sw:Subword) = sw match { case (i,j) => if (i==j) List((new Dummy,bt0)) else Nil }
  }
  def emptyi = new Terminal[Int](0,0,(i:Var,j:Var) => (List(i.eq(j,0)),""+i)) {
    def apply(sw:Subword) = sw match { case (i,j) => if (i==j) List((i,bt0)) else Nil }
  }
  def el = new Terminal[Alphabet](1,1,(i:Var,j:Var) => (List(i.eq(j,1)),"in["+i+"]")) {
    def apply(sw:Subword) = sw match { case (i,j) => if(i+1==j) List((in(i),bt0)) else Nil }
  }
  def eli = new Terminal[Int](1,1,(i:Var,j:Var) => (List(i.eq(j,1)),""+i)) {
    def apply(sw:Subword) = sw match { case (i,j) => if(i+1==j) List((i,bt0)) else Nil }
  }
  def seq(min:Int=1, max:Int=0) = new Terminal[Subword](min,max,
         (i:Var,j:Var) => { val cm:List[Cond]=if(max== -1) Nil else List(j.leq(i,max)); (i.leq(j,min)::cm, "in["+i+".."+j+"]") }) {
    def apply(sw:Subword) = sw match { case (i,j) => if (i+min<=j && (max== -1 || i+max>=j)) List(((i,j),bt0)) else Nil }
  }
}

trait LexicalParsers extends ADPParsers { this:Signature =>
  override type Alphabet = Char
  def char = el
  def chari = eli
  def charf(f: Char => Boolean) = el filter {
    case(i,j) if(i+1==j) => f(in(i))
    case _ => false
  }
  def digit: Parser[Int] = (charf {_.isDigit}) ^^ { c=>(c-'0').toInt }

  import scala.language.implicitConversions
  implicit def toCharArray(s:String):Array[Char] = s.toArray
}
