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
  def backtrack(in:Input,forceScala:Boolean=false):List[(Answer,Trace)] = this match {
    case c:CodeGen if (!forceScala) => List(c.backtrackCU(in.asInstanceOf[c.Input]).asInstanceOf[(Answer,Trace)])
    case _ => run(in,()=>if (window>0) aggr(((0 to size-window).flatMap{x=>axiom.backtrack(x,window+x)}).toList, h) else axiom.backtrack(0,size))
  }
  def build(in:Input,bt:Trace):Answer = run(in,()=>axiom.build(bt))
  private def run[T](in:Input, f:()=>T) = {
    input=in; analyze; tabInit(in.size+1,in.size+1);
    this match { case s:RNASignature => if (s.energies) librna.LibRNA.setSequence(in.mkString) case _ => }
    val res=time("Execution")(f);
    this match { case s:RNASignature => if (s.energies) librna.LibRNA.clear case _ => }
    tabReset; input=null; res
  }

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
  val el = new Terminal[Alphabet](1,1,(i:Var,j:Var) => (Nil,"_in1["+i+"]")) {
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

trait RNASignature extends Signature {
  val energies = true
  type Alphabet = Char
  def in(x:Int):Char
  val basepairing = new ((Int,Int)=>Boolean) with CFun {
    def apply(i:Int,j:Int):Boolean = if (i+2>j) false else (in(i),in(j-1)) match {
      case ('a','u') | ('u','a') | ('u','g') | ('g','u') | ('g','c') | ('c','g') => true case _ => false
    }
    val (args,body,tpe)=(List(("i","Int"),("j","Int")),"return bp_index(i,j)!=NO_BP;","Boolean")
  }
  val stackpairing = new ((Int,Int)=>Boolean) with CFun {
    def apply(i:Int,j:Int):Boolean = basepairing(i,j) && basepairing(i+1,j-1)
    val (args,body,tpe)=(List(("i","Int"),("j","Int")),"return bp_index(i,j)!=NO_BP && bp_index(i+1,j-1)!=NO_BP;","Boolean")
  }
  def setParams(file:String) = if (energies) librna.LibRNA.setParams(file)
}

object RNAUtils {
  // Debugging helper, program must be Vienna/RNAfold-compatible
  def refFold(seq:String,prog:String="RNAfold"):String = {
    import java.io._
    val p = Runtime.getRuntime.exec(prog+" --noPS --noLP -d2");
    val in = new PrintStream(p.getOutputStream());
    def gobble(in:InputStream) = new Runnable {
      var out = new StringBuilder
      var thr = new Thread(this); thr.start
      override def toString = { thr.join; out.toString.trim }
      override def run { val r = new BufferedReader(new InputStreamReader(in))
        var l = r.readLine; while(l != null) { out.append(l+"\n"); l = r.readLine }; r.close
      }
    }
    val out=gobble(p.getInputStream);
    in.println(seq); in.close
    p.waitFor; out.toString.split("\n")(1)
  }
  // Generate a reproducible random sequence
  import scala.util.Random
  Random.setSeed(123456748299L)
  def genSeq(n:Int) = Seq.fill(n)(Math.abs(Random.nextInt)%4).map {case 0=>'a' case 1=>'c' case 2=>'g' case 3=>'u'}.mkString
}
