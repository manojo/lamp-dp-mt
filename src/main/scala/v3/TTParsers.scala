package v3

// Two-tracks combinators: subword := (end_in1, end_in2)
// Main difference with ADP parsers is the concat operators and
// the two inputs. Otherwise everything is very similar.
// We shall look forward merging/reusing.
trait TTParsers extends BaseParsers { this:Signature =>
  // I/O interface
  override val twotracks = true
  private var input1: Input = null
  private var input2: Input = null
  def in1(k:Int):Alphabet = input1(k)
  def in2(k:Int):Alphabet = input2(k)
  def parse(p:Parser[Answer])(in1:Input,in2:Input):List[(Answer,Backtrack)] = {
    input1=in1; input2=in2; val res=p(input1.size,input2.size); input1=null; input2=null; res
  }

  // Concat parsers
  class ParserTT[T](inner:Parser[T]) {
    //def apply2(sw:Subword, k:Int): List[(T,Backtrack)] = apply(sw)
    def ++~ [U](that:Parser[U]) = p_concat(inner,that,(0,1,1,0xdeadbeef)) // last value of indices unused
    def +~~ [U](that:Parser[U]) = p_concat(inner,that,(0,0,1,0xdeadbeef))
    def -~~ [U](that:Parser[U]) = p_concat(inner,that,(1,1,1,0xdeadbeef))
    def ~++ [U](that:Parser[U]) = p_concat(inner,that,(0,1,2,0xdeadbeef))
    def ~~+ [U](that:Parser[U]) = p_concat(inner,that,(0,0,2,0xdeadbeef))
    def ~~- [U](that:Parser[U]) = p_concat(inner,that,(1,1,2,0xdeadbeef))
  }
  import scala.language.implicitConversions
  implicit def parserTT[T](inner:Parser[T]) = new ParserTT(inner)

  // Terminal parsers
  def empty = new Parser[Dummy] {
    def tree = PTerminal{(i:Var,j:Var) => (List(zero.leq(i,1),zero.leq(j,1)),"empty")}
    def apply(sw:Subword) = sw match { case (i,j) => if(i==0 && j==0) List((new Dummy,Nil)) else Nil }
  }
  def el1 = new Parser[Alphabet] {
    def tree = PTerminal{(i:Var,j:Var) => (List(zero.leq(i,1)),"in1["+i.add(-1)+"]")}
    def apply(sw:Subword) = sw match { case (i,j) => if(0 < i) List((in1(i-1),Nil)) else Nil }
  }
  def el2 = new Parser[Alphabet] {
    def tree = PTerminal{(i:Var,j:Var) => (List(zero.leq(j,1)),"in2["+j.add(-1)+"]")}
    def apply(sw:Subword) = sw match { case (i,j) => if(0 < j) List((in2(j-1),Nil)) else Nil }
  }
  // non-empty string, return (start,end)
  def seq1 = new Parser[(Int,Int)] {
    def tree = PTerminal{(i:Var,j:Var) => (List(zero.leq(j,1)),"seq1["+i+","+j+"]")}
    def apply(sw:Subword) = sw match { case (i,j) => if (0 < j) List(((i,j),Nil)) else Nil }
  }
  def seq2 = new Parser[(Int,Int)] {
    def tree = PTerminal{(i:Var,j:Var) => (List(zero.leq(j,1)),"seq2["+i+","+j+"]")}
    def apply(sw:Subword) = sw match { case (i,j) => if (0 < j) List(((i,j),Nil)) else Nil }
  }
/*
  def seq1 = new Parser[(Int,Int)] {
    def tree = PTerminal{(i:Var,j:Var) => (List(zero.leq(i,1)),"seq1[??k??,"+i+"]")}
    def apply(sw:Subword) = Nil // should never be called
    override def apply2(sw:Subword, k:Int) = sw match { case (i,j) => if (0 < i) List(((k,i),Nil)) else Nil }
  }
  def seq2 = new Parser[(Int,Int)] {
    def tree = PTerminal{(i:Var,j:Var) => (List(zero.leq(j,1)),"seq2[??k??,"+j+"]")}
    def apply(sw:Subword) = Nil // should never be called
    override def apply2(sw:Subword, k:Int) = sw match { case (i,j) => if (0 < j) List(((k,j),Nil)) else Nil }
  }
  */
}
