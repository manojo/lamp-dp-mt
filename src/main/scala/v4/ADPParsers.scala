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
  private def run[T](in:Input, f:()=>T) = { input=in; analyze; tabInit(in.size+1,in.size+1); val res=time("Execution")(f); tabReset; input=null; res }

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

trait RNASignature extends Signature {
  override type Alphabet = Char
  import librna.{LibRNA=>l}

  // Setup functions
  def setParams(file:String) = l.setParams(file)
  def setSequence(seq:String) = l.setSequence(seq)
  def clear = l.clear

  // Filtering functions (basepairing = one pair, stackpairing = two pairs)
  // XXX: convert to internal representation?
  // XXX: provide CUDA counterpart
  def in(x:Int):Char
  def basepairing(s:(Int,Int)):Boolean = { val (i,j)=s;if (i+2>j) false else (in(i),in(j-1)) match {
    case ('a','u') | ('u','a') | ('u','g') | ('g','u') | ('g','c') | ('c','g') => true
    case _ => false
  }}
  def stackpairing(s:(Int,Int)):Boolean = { val (i,j)=s; (i+3<=j) && basepairing((i,j)) && basepairing((i+1,j-1)) }

  // Exported energies function
  val termau_energy = new F2(l.termau_energy _,"termau_energy")
  val hl_energy = new F2(l.hl_energy _,"hl_energy") // <-- hairpin loop
  val hl_energy_stem = new F2(l.hl_energy_stem _,"hl_energy_stem")
  val il_energy = new F4(l.il_energy _,"il_energy") // <-- internal loop
  val bl_energy = new F5(l.bl_energy _,"bl_energy")
  val br_energy = new F5(l.br_energy _,"br_energy")
  val sr_energy = new F2(l.sr_energy _,"sr_energy") // <-- 2 stacked base pairs
  val sr_pk_energy = new FB4(l.sr_pk_energy _,"sr_pk_energy")
  val dl_energy = new F2(l.dl_energy _,"dl_energy")
  val dr_energy = new F2(l.dr_energy _,"dr_energy")
  val dli_energy = new F2(l.dli_energy _,"dli_energy")
  val dri_energy = new F2(l.dri_energy _,"dri_energy")
  val ext_mismatch_energy = new F2(l.ext_mismatch_energy _,"ext_mismatch_energy")
  val ml_mismatch_energy = new F2(l.ml_mismatch_energy _,"ml_mismatch_energy")
  val ml_energy = new F0(l.ml_energy _,"ml_energy")
  val ul_energy = new F0(l.ul_energy _,"ul_energy")
  val sbase_energy = new F0(l.sbase_energy _,"sbase_energy")
  val ss_energy = new F2(l.ss_energy _,"ss_energy")
  val dl_dangle_dg = new FB3(l.dl_dangle_dg _,"dl_dangle_dg")
  val dr_dangle_dg = new FB3(l.dr_dangle_dg _,"dr_dangle_dg")
  val mk_pf = new FDD(l.mk_pf _,"mk_pf")
  val scale = new FID(l.scale _,"scale")
  val iupac_match = new FBBB(l.iupac_match _,"iupac_match")

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

  // Wrapping functions
  class F0(f:()=>Int,name:String) extends (()=>Int) with CFun { def apply()=f(); val (args,body,tpe)=(List(),"return "+name+"();","Int") }
  class F2(f:(Int,Int)=>Int,name:String) extends ((Int,Int)=>Int) with CFun { def apply(i:Int,j:Int) = f(i,j)
    val (args,body,tpe)=(List(("i","Int"),("j","Int")),"return "+name+"(i,j);","Int")
  }
  class F4(f:(Int,Int,Int,Int)=>Int,name:String) extends ((Int,Int,Int,Int)=>Int) with CFun { def apply(i:Int,k:Int,l:Int,j:Int) = f(i,k,l,j)
    val (args,body,tpe)=(List(("i","Int"),("k","Int"),("l","Int"),("j","Int")),"return "+name+"(i,k,l,j);","Int")
  }
  class F5(f:(Int,Int,Int,Int,Int)=>Int,name:String) extends ((Int,Int,Int,Int,Int)=>Int) with CFun { def apply(i:Int,k:Int,l:Int,j:Int,x:Int) = f(i,k,l,j,x)
    val (args,body,tpe)=(List(("i","Int"),("k","Int"),("l","Int"),("j","Int"),("x","Int")),"return "+name+"(i,k,l,j,x);","Int")
  }
  class FB3(f:(Byte,Byte,Byte)=>Int,name:String) extends ((Byte,Byte,Byte)=>Int) with CFun { def apply(a:Byte,b:Byte,c:Byte) = f(a,b,c)
    val (args,body,tpe)=(List(("a","Byte"),("b","Byte"),("c","Byte")),"return "+name+"(a,b,c);","Int")
  }
  class FB4(f:(Byte,Byte,Byte,Byte)=>Int,name:String) extends ((Byte,Byte,Byte,Byte)=>Int) with CFun { def apply(a:Byte,b:Byte,c:Byte,d:Byte) = f(a,b,c,d)
    val (args,body,tpe)=(List(("a","Byte"),("b","Byte"),("c","Byte"),("d","Byte")),"return "+name+"(a,b,c,d);","Int")
  }
  class FDD(f:Double=>Double,name:String) extends (Double=>Double) with CFun { def apply(x:Double) = f(x)
    val (args,body,tpe)=(List(("x","Double")),"return "+name+"(x);","Double")
  }
  class FID(f:Int=>Double,name:String) extends (Int=>Double) with CFun { def apply(x:Int) = f(x)
    val (args,body,tpe)=(List(("x","Int")),"return "+name+"(x);","Double")
  }
  class FBBB(f:((Byte,Byte)=>Boolean),name:String) extends ((Byte,Byte)=>Boolean) with CFun { def apply(a:Byte,b:Byte) = f(a,b)
    val (args,body,tpe)=(List(("a","Byte"),("b","Byte")),"return "+name+"(a,b);","Boolean")
  }
}
