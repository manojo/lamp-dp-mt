package v4.examples
import v4._

// Zuker folding (Minimum Free Energy)
// ----------------------------------------------------------------------------
// Based on http://gapc.eu/grammar/adpfold.gap (gapc-2012.07.23/grammar/adpf.gap)
// See p.147 of "Parallelization of Dynamic Programming Recurrences in Computational Biology"
// Same coefficients as: http://www.tbi.univie.ac.at/~ivo/RNA/ (with parameters -noLP -d2)

trait ZukerSig extends RNASignature {
  type SSeq = (Int,Int) // = Subword
  val sadd:(Int, Answer) => Answer
  val cadd:(Answer, Answer) => Answer
  val dlr:(Int, Answer, Int) => Answer
  val sr:(Int, Answer, Int) => Answer
  val hl:(Int, Int, SSeq, Int, Int) => Answer
  val bl:(Int, Int, SSeq, Answer, Int, Int) => Answer
  val br:(Int, Int, Answer, SSeq, Int, Int) => Answer
  val il:(Int, Int, SSeq, Answer, SSeq, Int, Int) => Answer
  val ml:(Int, Int, Answer, Int, Int) => Answer
  val app:(Answer, Answer) => Answer
  val ul:(Answer) => Answer
  val addss:(Answer, SSeq) => Answer
  val ssadd:(SSeq, Answer) => Answer
  val nil : Unit => Answer
}

trait ZukerCount extends ZukerSig {
  type Answer = Int
  val sadd = (lb:Int, e:Answer) => e
  val cadd = (x:Answer, e:Answer) => x * e
  val dlr = (lb:Int, e:Answer, rb:Int) => e
  val sr = (lb:Int, e:Answer, rb:Int) => e
  val hl = (lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) => 1
  val bl = (lb:Int, f1:Int, x:SSeq, e:Answer, f2:Int, rb:Int) => e
  val br = (lb:Int, f1:Int, e:Answer, x:SSeq, f2:Int, rb:Int) => e
  val il = (f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) => x
  val ml = (lb:Int, f1:Int, x:Answer, f2:Int, rb:Int) => x
  val app = (c1:Answer, c:Answer) => c1 * c
  val ul = (c1:Answer) => c1
  val addss = (c1:Answer, e:SSeq) => c1
  val ssadd = (e:SSeq, x:Answer) => x
  val nil = (d:Unit) => 1
  override val h = sum[Answer] _
}

trait ZukerPrettyPrint extends ZukerSig {
  type Answer = String
  private def dots(s:SSeq,c:Char='.') = (0 until s._2-s._1).map{_=>c}.mkString
  val sadd = (lb:Int, e:Answer) => "."+e
  val cadd = (x:Answer, e:Answer) => x+e
  val dlr = (lb:Int, e:Answer, rb:Int) => e
  val sr = (lb:Int, e:Answer, rb:Int) => "("+e+")"
  val hl = (lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) => "(("+dots(x)+"))"
  val bl = (lb:Int, f1:Int, x:SSeq, e:Answer, f2:Int, rb:Int) => "(("+dots(x)+e+"))"
  val br = (lb:Int, f1:Int, e:Answer, x:SSeq, f2:Int, rb:Int) => "(("+e+dots(x)+"))"
  val il = (f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) => "(("+dots(r1)+x+dots(r2)+"))"
  val ml = (bl:Int, f1:Int, x:Answer, f2:Int, rb:Int) => "(("+x+"))"
  val app = (c1:Answer, c:Answer) => c1+c
  val ul = (c1:Answer) => c1
  val addss = (c1:Answer, e:SSeq) => c1+dots(e)
  val ssadd = (e:SSeq, x:Answer) => dots(e)+x
  val nil = (d:Unit) => ""
}

trait ZukerMFEGen extends ZukerSig {
  type Answer = Int
  import librna.LibRNA._
  val sadd=cfun2((lb:Int,e:Int)=>e, "lb,e", "return e;")
  val cadd=cfun2((x:Int,e:Int)=>x+e, "x,e", "return x+e;")
  val dlr=cfun3((lb:Int, e:Answer, rb:Int)=>e+ext_mismatch_energy(lb,rb-1)+termau_energy(lb,rb-1),"lb,e,rb","return e+ext_mismatch_energy(lb, rb-1)+termau_energy(lb, rb-1);")
  val sr=cfun3((lb:Int, e:Answer, rb:Int)=>e+sr_energy(lb,rb),"lb,e,rb","return e+sr_energy(lb,rb);")
  val hl=cfun5((lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) => hl_energy(f1,f2) + sr_energy(lb, rb),
    "lb,f1,x,f2,rb","return hl_energy(f1,f2)+sr_energy(lb, rb);")
  val bl=cfun6((lb:Int, f1:Int, b:SSeq, x:Answer, f2:Int, rb:Int) => x + bl_energy(f1,b._1,b._2-1,f2,f2-1) + sr_energy(lb, rb),
    "lb,f1,b,x,f2,rb","return x + bl_energy(f1,b._1,b._2-1,f2,f2-1) + sr_energy(lb, rb);")
  val br=cfun6((lb:Int, f1:Int, x:Answer, b:SSeq, f2:Int, rb:Int) => x + br_energy(f1,b._1,b._2-1,f2,f1+1) + sr_energy(lb, rb),
    "lb,f1,x,b,f2,rb","return x + br_energy(f1,b._1,b._2-1,f2,f1+1) + sr_energy(lb, rb);")
  val il=cfun7((f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) => x + il_energy(f2,r1._2,r2._1-1,f3) + sr_energy(f1, f4),
    "f1,f2,r1,x,r2,f3,f4","return x + il_energy(f2,r1._2,r2._1-1,f3) + sr_energy(f1, f4);")
  val ml=cfun5((lb:Int, f1:Int, x:Answer, f2:Int, rb:Int) => ml_energy + ul_energy + x + termau_energy(f1, f2) + sr_energy(lb, rb) + ml_mismatch_energy(f1,f2),
    "lb,f1,x,f2,rb","return ml_energy() + ul_energy() + x + termau_energy(f1, f2) + sr_energy(lb, rb) + ml_mismatch_energy(f1,f2);")
  val app=cfun2((c1:Int, c:Int)=>c1+c,"c1,c","return c1+c;")
  val ul=cfun1((c1:Int)=>ul_energy+c1,"c1","return ul_energy()+c1;")
  val addss=cfun2((c1:Int, e:SSeq)=>c1,"c1,e","return c1;")
  val ssadd=cfun2((e:SSeq,x:Int)=>ul_energy+x,"e,x","return ul_energy()+x;")
  val nil=cfun1((d:Unit)=>0,"","return 0;")
  override val h = min[Answer] _

  def cfun1[A,R](fn:A=>R,as:String,bdy:String)(implicit mA:Manifest[A],mR:Manifest[R]) =
    new Function1[A,R] with CFun { val (args,body,tpe)=((if(as!="") List(as) else Nil) zip List(mA).map{_.toString},bdy,mR.toString); def apply(a:A) = fn(a) }
  def cfun2[A,B,R](fn:(A,B)=>R,as:String,bdy:String)(implicit mA:Manifest[A],mB:Manifest[B],mR:Manifest[R]) =
    new Function2[A,B,R] with CFun { val (args,body,tpe)=(as.split(",").toList zip List(mA,mB).map{_.toString},bdy,mR.toString); def apply(a:A,b:B) = fn(a,b) }
  def cfun3[A,B,C,R](fn:(A,B,C)=>R,as:String,bdy:String)(implicit mA:Manifest[A],mB:Manifest[B],mC:Manifest[C],mR:Manifest[R]) =
    new Function3[A,B,C,R] with CFun { val (args,body,tpe)=(as.split(",").toList zip List(mA,mB,mC).map{_.toString},bdy,mR.toString); def apply(a:A,b:B,c:C) = fn(a,b,c) }
  def cfun4[A,B,C,D,R](fn:(A,B,C,D)=>R,as:String,bdy:String)(implicit mA:Manifest[A],mB:Manifest[B],mC:Manifest[C],mD:Manifest[D],mR:Manifest[R]) =
    new Function4[A,B,C,D,R] with CFun { val (args,body,tpe)=(as.split(",").toList zip List(mA,mB,mC,mD).map{_.toString},bdy,mR.toString); def apply(a:A,b:B,c:C,d:D) = fn(a,b,c,d) }
  def cfun5[A,B,C,D,E,R](fn:(A,B,C,D,E)=>R,as:String,bdy:String)(implicit mA:Manifest[A],mB:Manifest[B],mC:Manifest[C],mD:Manifest[D],mE:Manifest[E],mR:Manifest[R]) =
    new Function5[A,B,C,D,E,R] with CFun { val (args,body,tpe)=(as.split(",").toList zip List(mA,mB,mC,mD,mE).map{_.toString},bdy,mR.toString); def apply(a:A,b:B,c:C,d:D,e:E) = fn(a,b,c,d,e) }
  def cfun6[A,B,C,D,E,F,R](fn:(A,B,C,D,E,F)=>R,as:String,bdy:String)(implicit mA:Manifest[A],mB:Manifest[B],mC:Manifest[C],mD:Manifest[D],mE:Manifest[E],mF:Manifest[F],mR:Manifest[R]) =
    new Function6[A,B,C,D,E,F,R] with CFun { val (args,body,tpe)=(as.split(",").toList zip List(mA,mB,mC,mD,mE,mF).map{_.toString},bdy,mR.toString); def apply(a:A,b:B,c:C,d:D,e:E,f:F) = fn(a,b,c,d,e,f) }
  def cfun7[A,B,C,D,E,F,G,R](fn:(A,B,C,D,E,F,G)=>R,as:String,bdy:String)(implicit mA:Manifest[A],mB:Manifest[B],mC:Manifest[C],mD:Manifest[D],mE:Manifest[E],mF:Manifest[F],mG:Manifest[G],mR:Manifest[R]) =
    new Function7[A,B,C,D,E,F,G,R] with CFun { val (args,body,tpe)=(as.split(",").toList zip List(mA,mB,mC,mD,mE,mF,mG).map{_.toString},bdy,mR.toString); def apply(a:A,b:B,c:C,d:D,e:E,f:F,g:G) = fn(a,b,c,d,e,f,g) }
}

trait ZukerExplain extends ZukerSig {
  type Answer = String

  private def dots(s:SSeq,c:Char='.') = (0 until s._2-s._1).map{_=>c}.mkString
  val sadd = (lb:Int, e:Answer) => "."+e +" sadd"
  val cadd = (x:Answer, e:Answer) => x+e +" cadd"
  val dlr = (lb:Int, e:Answer, rb:Int) => e + " dlr"+(lb,rb)
  val sr = (lb:Int, e:Answer, rb:Int) => e +" sr("+lb+","+rb+")"
  val hl = (lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) => "{"+lb+","+rb+"}"
  val bl = (lb:Int, f1:Int, x:SSeq, e:Answer, f2:Int, rb:Int) => "(("+dots(x)+e+"))"  +" lb"
  val br = (lb:Int, f1:Int, e:Answer, x:SSeq, f2:Int, rb:Int) => "(("+e+dots(x)+"))"  +" br"
  val il = (f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) => "(("+dots(r1)+x+dots(r2)+"))"  +" il"+(f2,r1._2,r2._1-1,f3)
  val ml = (bl:Int, f1:Int, x:Answer, f2:Int, rb:Int) => "(("+x+"))"  +" ml"+(bl,rb)
  val app = (c1:Answer, c:Answer) => c1+c  +" app"
  val ul = (c1:Answer) => c1  +" ul"
  val addss = (c1:Answer, e:SSeq) => c1+dots(e) +" addss"
  val ssadd = (e:SSeq, x:Answer) => dots(e)+x   +" ssadd"
  val nil = (d:Unit) => ""  +" nil"
}

trait ZukerMFE extends ZukerSig {
  type Answer = Int
  import librna.LibRNA._
  val sadd = (lb:Int, e:Answer) => e
  val cadd = (x:Answer, e:Answer) => x + e
  val dlr = (lb:Int, e:Answer, rb:Int) => e + ext_mismatch_energy(lb, rb-1) + termau_energy(lb, rb-1) // OK
  val sr = (lb:Int, e:Answer, rb:Int) => e + sr_energy(lb,rb) // OK
  val hl = (lb:Int, f1:Int, x:SSeq, f2:Int, rb:Int) => hl_energy(f1,f2) + sr_energy(lb, rb) // OK
  val bl = (lb:Int, f1:Int, b:SSeq, x:Answer, f2:Int, rb:Int) => x + bl_energy(f1,b._1,b._2-1,f2,f2-1) + sr_energy(lb, rb) // OK
  val br = (lb:Int, f1:Int, x:Answer, b:SSeq, f2:Int, rb:Int) => x + br_energy(f1,b._1,b._2-1,f2,f1+1) + sr_energy(lb, rb) // OK
  val il = (f1:Int, f2:Int, r1:SSeq, x:Answer, r2:SSeq, f3:Int, f4:Int) => x + il_energy(f2,r1._2,r2._1-1,f3) + sr_energy(f1, f4) // OK
  val ml = (lb:Int, f1:Int, x:Answer, f2:Int, rb:Int) => ml_energy + ul_energy + x + termau_energy(f1, f2) + sr_energy(lb, rb) + ml_mismatch_energy(f1,f2)
  val app = (c1:Answer, c:Answer) => c1 + c
  val ul = (c1:Answer) => ul_energy + c1
  val addss = (c1:Answer, e:SSeq) => c1 // + ss_energy(e._1,e._2-1)=0 OK
  val ssadd = (e:SSeq, x:Answer) => ul_energy + x // + ss_energy(e._1,e._2-1)=0 OK
  val nil = (d:Unit) => 0
  override val h = min[Answer] _
}

trait ZukerGrammar extends ADPParsers with ZukerSig {
  val BASE = eli
  val LOC = emptyi
  val REG = seq()
  val REG3 = seq(3,maxN)
  val REG30 = seq(1,30)

  val struct:Tabulate = tabulate("st",(
      BASE   ~ struct ^^ sadd
    | dangle ~ struct ^^ cadd
    | empty           ^^ nil
    ) aggregate h);

  lazy val dangle = LOC ~ closed ~ LOC ^^ dlr
  val closed:Tabulate = tabulate("cl", (stack | hairpin | leftB | rightB | iloop | multiloop) filter stackpairing aggregate h)

  lazy val stack   = BASE ~ closed ~ BASE ^^ sr
  lazy val hairpin = BASE ~ BASE ~ REG3 ~ BASE ~ BASE ^^ hl
  lazy val leftB   = BASE ~ BASE ~ REG30 ~ closed ~ BASE ~ BASE ^^ bl aggregate h
  lazy val rightB  = BASE ~ BASE ~ closed ~ REG30 ~ BASE ~ BASE ^^ br aggregate h
  lazy val iloop   = BASE ~ BASE ~ REG30 ~ closed ~ REG30 ~ BASE ~ BASE ^^ il aggregate h

  lazy val multiloop = BASE ~ BASE ~ ml_comps ~ BASE ~ BASE ^^ ml
  val ml_comps:Tabulate = tabulate("ml",(
      BASE ~ ml_comps ^^ sadd
    | (dangle ^^ ul) ~ ml_comps1 ^^ app
    ) aggregate h)
  val ml_comps1:Tabulate = tabulate("ml1",(
      BASE ~ ml_comps1 ^^ sadd
    | (dangle ^^ ul) ~ ml_comps1 ^^ app
    | dangle ^^ ul
    | (dangle ^^ ul) ~ REG ^^ addss
    ) aggregate h)
  val axiom = struct
}

object Zuker extends App {
  object mfe extends ZukerGrammar with ZukerMFEGen with CodeGen {
    override val benchmark = true
    override val tps = (manifest[Alphabet],manifest[Answer])
  }
  object pretty extends ZukerGrammar with ZukerPrettyPrint
  object count extends ZukerGrammar with ZukerCount
  object explain extends ZukerGrammar with ZukerExplain

  import librna.{LibRNA=>l}
  l.setParams("src/librna/vienna/rna_turner2004.par")
  def parse(s:String) = {
    l.setSequence(s);
    val seq=s.toArray
    val (score,bt) = mfe.backtrack(seq).head;
    val res = pretty.build(seq,bt)
    l.clear; (score,bt,res)
  }

  def testSeq(seq:String, strict:Boolean=true) {
    val (score,bt,res)=parse(seq)
    val ref=RNAUtils.refFold(seq,"src/librna/rfold" /*"resources/RNAfold_orig_mac"*/)
    val our=res+" (%6.2f)".format(score/100.0)
    if (ref==our) print(".")
    else println("\nSeq: "+seq+"\nRef: "+ref+"\nOur: "+res+" (%6.2f)".format(score/100.0)+" FAILED\n"+explain.build(seq.toArray,bt)+"\n")
  }

  def testSeq2(seq:String) {
    val (score,bt,res)=parse(seq)
    val ref=RNAUtils.refFold(seq,"src/librna/rfold" /*"resources/RNAfold_orig_mac"*/)
    val our=res+" (%6.2f)".format(score/100.0)
    if (ref.substring(res.size)==" (%6.2f)".format(score/100.0)) print(".")
    else println("\nSeq: "+seq+"\nRef: "+ref+"\nOur: "+res+" (%6.2f)".format(score/100.0)+" FAILED\n"+explain.build(seq.toArray,bt)+"\n")
  }

  //println(mfe.gen)

  // Having separate JVM instances is required due to issue described in
  // http://codethesis.com/sites/default/index.php?servlet=4&content=2
  // Note that sbt execute the program in the same JVM
 
  //scala.util.Random.setSeed(3974658973264L)
  //for (k<-0 until 4000) { testSeq2(RNAUtils.genSeq(80)); if (k%80==0) println }
}
