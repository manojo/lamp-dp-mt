package v3

class ADPParsers extends BaseParsers { this:Signature =>
  // Processing interface
  private var input: Input = null
  def in(k:Int):Alphabet = input(k % size) // to deal with cyclic

  def parse(p:Parser[Answer])(in:Input):List[(Answer,Backtrack)] = {
  	def aggr[T](l:List[(T,Backtrack)], h: List[T] => List[T]):List[(T,Backtrack)] = { val b=h(l.map(_._1)); l.filter{e=>b contains e._1} }
    input = in;
    size = in.size
    val res = if (cyclic) aggr( ((0 until size).flatMap{ x => p(x,size+x) }).toList, h )
              else if (window>0) aggr( ((0 to size-window).flatMap{ x => p(x,window+x) }).toList, h)
              else p(0,size)
    input = null; res
  }

  // Concatenation operations
  class ADPParser[T](p:Parser[T]) {
    def ~~~ [U](that:Parser[U]) = p_concat(p,that,(0,0,0,0))
    def ~~+ [U](that:Parser[U]) = p_concat(p,that,(0,0,1,0))
    def +~~ [U](that:Parser[U]) = p_concat(p,that,(1,0,0,0))
    def +~+ [U](that:Parser[U]) = p_concat(p,that,(1,0,1,0))
    def *~~ [U](lMin:Int, rRange:Pair[Int,Int], that:Parser[U]) = p_concat(p,that,(lMin,0,rRange._1,rRange._2))
    def ~~* [U](lRange:Pair[Int,Int], rMin:Int, that:Parser[U]) = p_concat(p,that,(lRange._1,lRange._2,rMin,0))
    def *~* [U](lMin:Int, rMin:Int, that:Parser[U]) = p_concat(p,that,(lMin,0,rMin,0))
    def ~~  [U](lRange:Pair[Int,Int], rRange:Pair[Int,Int], that:Parser[U]) = p_concat(p,that,(lRange._1,lRange._2,rRange._1,rRange._2))
    def -~~ [U](that:Parser[U]) = p_concat(p,that,(1,1,0,0))
    def ~~- [U](that:Parser[U]) = p_concat(p,that,(0,0,1,1))
  }
  import scala.language.implicitConversions
  implicit def parserADP[T](p:Parser[T]) = new ADPParser(p)

  // Terminal parsers
  def empty = new Parser[Dummy] {
    def tree = PTerminal{(i:Var,j:Var) => (List(i.eq(j,0)),"empty")}
    def apply(sw:Subword) = sw match { case (i,j) => if (i==j) List((new Dummy,Nil)) else Nil }
  }
  def el = new Parser[Alphabet] {
    def tree = PTerminal{(i:Var,j:Var) => (List(i.eq(j,1)),"in["+i+"]")}
    def apply(sw:Subword) = sw match { case (i,j) => if(i+1==j) List((in(i),Nil)) else Nil }
  }
  def eli = new Parser[Int] {
    def tree = PTerminal{(i:Var,j:Var) => (List(i.eq(j,1)),""+i)}
    def apply(sw:Subword) = sw match { case (i,j) => if(i+1==j) List((i,Nil)) else Nil }
  }
  def seq(min:Int, max:Int) = new Parser[(Int,Int)] {
    def tree = PTerminal{(i:Var,j:Var) => (List(i.leq(j,min),(j.leq(i,max))),"in["+i+","+j+"]")}
    def apply(sw:Subword) = sw match { case (i,j) => if (i+min<=j && (max==0 || i+max>=j)) List(((i,j),Nil)) else Nil }
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
}
