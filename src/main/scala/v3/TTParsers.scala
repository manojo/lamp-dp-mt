package v3

class TTParsers extends BaseParsers { this:Signature =>
  // Two-tracks combinators: subword := (end_in1, end_in2)
  // Main difference with ADP is the concat operators and use of 2 inputs.

  // I/O interface
  override val twotracks = true
  private var input1: Input = null
  private var input2: Input = null
  def in1(k:Int):Alphabet = input1(k)
  def in2(k:Int):Alphabet = input2(k)
  def size1:Int = input1.size
  def size2:Int = input2.size
  def parse(p:Parser[Answer])(in1:Input,in2:Input):List[Answer] = {
    analyze; input1=in1; input2=in2; val res=p(input1.size,input2.size); input1=null; input2=null; reset(); res.map{_._1}
  }
  def backtrack(p:Tabulate)(in1:Input,in2:Input):List[(Answer,List[(Subword,Backtrack)])] = {
    analyze; input1=in1; input2=in2; val res=p.backtrack(input1.size,input2.size); input1=null; input2=null; reset(); res
  }

  // Concat parsers
  class ParserTT[T](inner:Parser[T]) {
    def ++~ [U](that:Parser[U]) = p_concat(inner,that,(0,1,1, -1)) // indices._4 unused
    def +~~ [U](that:Parser[U]) = p_concat(inner,that,(0,0,1, -1))
    def -~~ [U](that:Parser[U]) = p_concat(inner,that,(1,1,1, -1))
    def ~++ [U](that:Parser[U]) = p_concat(inner,that,(0,1,2, -1))
    def ~~+ [U](that:Parser[U]) = p_concat(inner,that,(0,0,2, -1))
    def ~~- [U](that:Parser[U]) = p_concat(inner,that,(1,1,2, -1))
  }
  import scala.language.implicitConversions
  implicit def parserTT[T](inner:Parser[T]) = new ParserTT(inner)

  // Terminal parsers
  def empty = new Parser[Dummy] {
    val tree = PTerminal{(i:Var,j:Var) => (List(zero.leq(i,1),zero.leq(j,1)),"empty")}
    def apply(sw:Subword) = sw match { case (i,j) => if(i==0 && j==0) List((new Dummy,bt0)) else Nil }
  }
  def el1 = new Parser[Alphabet] {
    val tree = PTerminal{(i:Var,j:Var) => (List(i.eq(j,1)),"in1["+i+"]")}
    def apply(sw:Subword) = sw match { case (i,j) => if(i+1==j) List((in1(i),bt0)) else Nil }
  }
  def el2 = new Parser[Alphabet] {
    val tree = PTerminal{(i:Var,j:Var) => (List(i.eq(j,1)),"in2["+i+"]")}
    def apply(sw:Subword) = sw match { case (i,j) => if(i+1==j) List((in2(i),bt0)) else Nil }
  }
  def seq1(min:Int=1, max:Int=0) = new Parser[(Int,Int)] {
    val tree = PTerminal{(i:Var,j:Var) => val cm:List[Cond] = if(max==0) Nil else List(j.leq(i,max)); (i.leq(j,min)::cm, "in1["+i+".."+j+"]")}
    def apply(sw:Subword) = sw match { case (i,j) => if (i+min<=j && (max==0 || i+max>=j)) List(((i,j),bt0)) else Nil }
  }
  def seq2(min:Int=1, max:Int=0) = new Parser[(Int,Int)] {
    val tree = PTerminal{(i:Var,j:Var) => val cm:List[Cond] = if(max==0) Nil else List(j.leq(i,max)); (i.leq(j,min)::cm, "in2["+i+".."+j+"]")}
    def apply(sw:Subword) = sw match { case (i,j) => if (i+min<=j && (max==0 || i+max>=j)) List(((i,j),bt0)) else Nil }
  }
}
