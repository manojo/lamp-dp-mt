package lms2

import scala.virtualization.lms.common._
import lms._

object MatrixMult2 extends App with Signature with ADPParsers
  with PackageExp with MyScalaCompile { self =>
  val codegen = new ScalaGenPackage with ScalaGenVariables { val IR: self.type = self }

  //val cCodegen = new CGenPackage { val IR: self.type = self }

  type Alphabet = (Int,Int) // matrix as (rows, columns)
  type Answer = (Int,Int,Int) // rows, cost, columns

  val mAlph = manifest[Alphabet]
  val mAns  = manifest[Answer]

  // Algebra
  def single(i: Rep[Alphabet]) = (i._1, unit(0), i._2)
  def mult(m:Rep[(Answer,Answer)]):Rep[Answer] = { val l=m._1; val r=m._2; (l._1, l._2 + r._2 + l._1 * l._3 * r._3, r._3) }
  def h(a:Rep[Answer],b:Rep[Answer]) = if (a._2 < b._2) a else b

  // Grammar
  val axiom:Tabulate = tabulate("M",( // XXX: can we get rid of the name? it was used only for CUDA codegen
    el              ^^ single // XXX: bug in here
  | (axiom ~ axiom) ^^ mult
  ) /*aggregate h*/)
  analyze

  // Concrete program
  val input = scala.Array((1,2),(2,20),(20,2),(2,4),(4,2),(2,1),(1,7),(7,3)) // -> 1x3 matrix, 122 multiplications
  //val progParse = compile(parse)
  //scala.Console.println(progParse(input))

  def testParse(input: Rep[Input]) = {
    parse(input, (unit(0),unit(10000),unit(0)), h)
  }



  // Compilation into a program (apply,unapply,reapply)
  codegen.emitSource(testParse, "testParse", new java.io.PrintWriter(System.out))

  val progParse = compile(testParse)
  scala.Console.println(progParse(input))
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