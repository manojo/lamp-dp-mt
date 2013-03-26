package lms2

import scala.virtualization.lms.common._
import lms._

trait ADPParsers extends BaseParsersExp { this:Signature =>
  var in: Rep[Input] = unit(null)

  def bottomUp(n:Rep[Int], z:Rep[Answer], foldF: (Rep[Answer], Rep[Answer]) => Rep[Answer]) {
    val rs=rulesOrder map {n=>rules(n)};
    (unit(0) until n).foreach { d=>
      (unit(0) until n-d).foreach { i=>
        print(unit("("));  print(i); print(unit(",")); print(d+i); println(unit(")"))
        for (r<-rs) { r.compute(i,d+i)(z, foldF); }
        unit({})
      }
    }
  }

  // XXX: avoid code duplication
  def parse(input:Rep[Input], z:Rep[Answer], foldF: (Rep[Answer], Rep[Answer]) => Rep[Answer])(implicit mAlph:Manifest[Alphabet], mAns:Manifest[Answer]):Rep[Answer] = {
    analyze; in = input
    val n:Rep[Int] = in.length+unit(1)
    val rs=rulesOrder map {x=>rules(x)}
    for (r<-rs) r.init(n,n) // Initialization
    bottomUp(n, z, foldF)

    val res = var_new(z)
    axiom(unit(0),in.length){ x: Rep[Answer] =>
      res = x
    }

    //val res = if (r.isEmpty) List[Answer]() else List(r.head._1)
    for (r<-rs) r.reset; in=unit(null); readVar(res) // Cleanup & return result
  }

/*  def backtrack(input:Rep[Input])(implicit mAlph:Manifest[Alphabet], mAns:Manifest[Answer]):Rep[List[(Answer,Trace)]] = {
    analyze; in = input;
    val n:Rep[Int] = in.length+unit(1)
    val rs=rulesOrder map {x=>rules(x)};
    for (r<-rs) r.init(n,n); // Initialization
    bottomUp(n)
    val res=axiom.backtrack(unit(0),in.length)
    for (r<-rs) r.reset; in=unit(null); res // Cleanup & return result
  }
*/
  /*
  def build(in:Rep[Input],trace:Rep[Trace])(implicit mAns:Manifest[Answer]):Rep[Answer] = {
    unit(null.asInstanceOf[Answer]) // Stub
  }
  */

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
    def ~ [U:Manifest](p2:Parser[U]) = {
      if (idx!=null) new Concat(p1,p2,0) {
        override lazy val indices=idx
      } else new Concat(p1,p2,0) }

    def ~ (minl:Int,maxl:Int,minr:Int,maxr:Int):ParserADP[T] =
      new ParserADP[T](p1,(minl,maxl,minr,maxr))
  }

  // Terminal parsers
  val empty = new Terminal[Unit](0,0) {
    def apply(i:Rep[Int],j:Rep[Int]) =
      //needs to be change to represent the empty parser?
      cond((i==j), emptyGen[Unit](), emptyGen[Unit]())
      //List((unit({}),bt0)) else List[(Unit,Backtrack)]()
  }

  val emptyi = new Terminal[Int](0,0) {
    def apply(i:Rep[Int],j:Rep[Int]) =
      cond((i == j), elGen(i/*bt0*/), emptyGen())
  }

  val eli = new Terminal[Int](1,1) {
    def apply(i:Rep[Int],j:Rep[Int]) =
      cond(i+unit(1) == j, elGen(i /*,bt0*/), emptyGen())
  }

  def el(implicit mAlph:Manifest[Alphabet]) = new Terminal[Alphabet](1,1) {
    def apply(i:Rep[Int],j:Rep[Int]) = {
      cond(i+unit(1) == j, elGen(in(i)/*,bt0*/), emptyGen())
    }
  }

  def seq(min:Int=1, max:Int=maxN) = new Terminal[(Int,Int)](min,max) {
    def apply(i:Rep[Int],j:Rep[Int]) =
      cond(i+unit(min)<=j && (unit(max==maxN) || i+unit(max)>=j),
        elGen(make_tuple2(i,j)/*,bt0*/),
        emptyGen()
      )
  }
}