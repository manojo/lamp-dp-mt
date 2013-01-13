package v4

// We purposedly shadow the librna.LibRNA class so that we can
// provide additional instrumentation toward code generation.

trait LibRNA {
  import librna.{LibRNA=>l}

  // Setup functions (unwrapped)
  def setParams(file:String) = l.setParams(file)
  def setSequence(seq:String) = l.setSequence(seq)
  def clear = l.clear

  // Computations functions
  class F0(f:()=>Int,name:String) extends (()=>Int) with CFun {
    def apply() = f()
    val (args,body,tpe)=(List(),"return "+name+"();","Int")
  }
  class F2(f:(Int,Int)=>Int,name:String) extends ((Int,Int)=>Int) with CFun {
    def apply(i:Int,j:Int) = f(i,j)
    val (args,body,tpe)=(List(("i","Int"),("j","Int")),"return "+name+"(i,j);","Int")
  }
  class F4(f:(Int,Int,Int,Int)=>Int,name:String) extends ((Int,Int,Int,Int)=>Int) with CFun {
    def apply(i:Int,k:Int,l:Int,j:Int) = f(i,k,l,j)
    val (args,body,tpe)=(List(("i","Int"),("k","Int"),("l","Int"),("j","Int")),"return "+name+"(i,k,l,j);","Int")
  }
  class F5(f:(Int,Int,Int,Int,Int)=>Int,name:String) extends ((Int,Int,Int,Int,Int)=>Int) with CFun {
    def apply(i:Int,k:Int,l:Int,j:Int,x:Int) = f(i,k,l,j,x)
    val (args,body,tpe)=(List(("i","Int"),("k","Int"),("l","Int"),("j","Int"),("x","Int")),"return "+name+"(i,k,l,j,x);","Int")
  }
  class FB3(f:(Byte,Byte,Byte)=>Int,name:String) extends ((Byte,Byte,Byte)=>Int) with CFun {
    def apply(a:Byte,b:Byte,c:Byte) = f(a,b,c)
    val (args,body,tpe)=(List(("a","Byte"),("b","Byte"),("c","Byte")),"return "+name+"(a,b,c);","Int")
  }

  // Basepairing = make one pair, stack pairing = make two pairs
  // XXX: convert to internal representation
  def in(x:Int):Char
  def basepairing(s:(Int,Int)):Boolean = { val (i,j)=s;if (i+2>j) false else (in(i),in(j-1)) match {
    case ('a','u') | ('u','a') | ('u','g') | ('g','u') | ('g','c') | ('c','g') => true
    case _ => false
  }}
  def stackpairing(s:(Int,Int)):Boolean = { val (i,j)=s; (i+3<=j) && basepairing((i,j)) && basepairing((i+1,j-1)) }


  // Wrapped functions
  val termau_energy = new F2(l.termau_energy _,"termau_energy")
  val hl_energy = new F2(l.hl_energy _,"hl_energy") // <-- hairpin loop
  val hl_energy_stem = new F2(l.hl_energy_stem _,"hl_energy_stem")
  val il_energy = new F4(l.il_energy _,"il_energy") // <-- internal loop
  val bl_energy = new F5(l.bl_energy _,"bl_energy")
  val br_energy = new F5(l.br_energy _,"br_energy")
  val sr_energy = new F2(l.sr_energy _,"sr_energy") // <-- 2 stacked base pairs
  val sr_pk_energy = new ((Byte,Byte,Byte,Byte)=>Int) with CFun {
    def apply(a:Byte,b:Byte,c:Byte,d:Byte) = l.sr_pk_energy(a,b,c,d)
    val (args,body,tpe)=(List(("a","Byte"),("b","Byte"),("c","Byte"),("d","Byte")),"return sr_pk_energy(a,b,c,d);","Int")
  }
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
  val mk_pf = new (Double=>Double) with CFun {
    def apply(x:Double) = l.mk_pf(x)
    val (args,body,tpe)=(List(("x","Double")),"return mk_pf(x);","Double")
  }
  val scale = new (Int=>Double) with CFun {
    def apply(x:Int) = l.scale(x)
    val (args,body,tpe)=(List(("x","Int")),"return scale(x);","Double")
  }
  val iupac_match = new ((Byte,Byte)=>Boolean) with CFun {
    def apply(base:Byte,iupac_base:Byte) = l.iupac_match(base,iupac_base)
    val (args,body,tpe)=(List(("base","Byte"),("iupac_base","Byte")),"return iupac_match(base,iupac_base);","Boolean")
  }

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

  // Generate a random sequence in a reproducible manner
  import scala.util.Random
  Random.setSeed(123456789L)
  def genSeq(n:Int) = Seq.fill(n)(Math.abs(Random.nextInt)%4).map {case 0=>'a' case 1=>'c' case 2=>'g' case 3=>'u'}.mkString
}
