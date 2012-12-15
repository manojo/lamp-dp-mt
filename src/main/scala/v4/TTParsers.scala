package v4

trait TTParsers extends BaseParsers { this:Signature =>
  // Two-tracks combinators. Subword := (end_in1, end_in2)
  // Main difference with ADP is the concat operators and use of 2 inputs.

  // I/O interface
  override val twotracks = true
  private var input1: Input = null
  private var input2: Input = null
  def in1(k:Int):Alphabet = input1(k)
  def in2(k:Int):Alphabet = input2(k)
  def size1:Int = input1.size
  def size2:Int = input2.size
  def parse(in1:Input,in2:Input):List[Answer] = run(in1,in2,()=>axiom(input1.size,input2.size).map{_._1} )
  def backtrack(in1:Input,in2:Input):List[(Answer,List[(Subword,Backtrack)])] = run(in1,in2,()=>axiom.backtrack(input1.size,input2.size))
  def build(in1:Input,in2:Input,bt:List[(Subword,Backtrack)]):Answer = run(in1,in2,()=>axiom.build(bt))
  private def run[T](in1:Input,in2:Input, f:()=>T) = { input1=in1; input2=in2; analyze; val res=f(); input1=null; input2=null; reset(); res }

  // Concat parsers
  import scala.language.implicitConversions
  implicit def parserTT[T](p1:Parser[T]) = new ParserTT(p1)
  class ParserTT[T](p1:Parser[T]) {
    def -~ [U](p2:Parser[U]) = new Concat(p1,p2,1)
    def ~- [U](p2:Parser[U]) = new Concat(p1,p2,2)
    // XXX: improve to support more concatenations along one direction (?)
  }

  // Terminal parsers
  def empty = new Terminal[Dummy](0,0,(i:Var,j:Var) => (List(zero.leq(i,1),zero.leq(j,1)),"EMPTY")) {
    def apply(sw:Subword) = sw match { case (i,j) => if(i==0 && j==0) List((new Dummy,bt0)) else Nil }
  }
  def el1 = new Terminal[Alphabet](1,1,(i:Var,j:Var) => (Nil,"in1["+i+"]")) {
    def apply(sw:Subword) = sw match { case (i,j) => if(i+1==j) List((in1(i),bt0)) else Nil }
  }
  def el2 = new Terminal[Alphabet](1,1,(i:Var,j:Var) => (Nil,"in2["+i+"]")) {
    def apply(sw:Subword) = sw match { case (i,j) => if(i+1==j) List((in2(i),bt0)) else Nil }
  }
  def seq1(min:Int=1,max:Int=maxN) = new Terminal[Subword](min,max,(i:Var,j:Var) => (Nil,"in1["+i+".."+j+"]")) {
    def apply(sw:Subword) = sw match { case (i,j) => if (i+min<=j && (max==maxN || i+max>=j)) List(((i,j),bt0)) else Nil }
  }
  def seq2(min:Int=1, max:Int=maxN) = new Terminal[Subword](min,max,(i:Var,j:Var) => (Nil, "in2["+i+".."+j+"]")) {
    def apply(sw:Subword) = sw match { case (i,j) => if (i+min<=j && (max==maxN || i+max>=j)) List(((i,j),bt0)) else Nil }
  }
}
