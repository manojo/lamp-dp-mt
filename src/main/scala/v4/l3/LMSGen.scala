package v4.l3
import v4._
import lms._

import scala.virtualization.lms.common._

object Test extends Signature with LMSGenADP with App {
  // Matrix multiplication
  type Alphabet = (Int,Int)
  type Answer = (Int,Int,Int) // col
  val tps=(manifest[Alphabet],manifest[Answer])

  override val h = minBy(lfun{ (a:Rep[Answer]) => a._2  })
  val single = lfun{(a: Rep[Alphabet]) => (a._1, unit(0), a._2)} 
  val mult = lfun{p:Rep[(Answer,Answer)] => { val l=p._1; val r=p._2; (l._1, l._2 + r._2 + l._1 * l._3 * r._3, r._3) } }
  //val mult = lfun2{(l:Rep[Answer],r:Rep[Answer]) => { (l._1, l._2 + r._2 + l._1 * l._3 * r._3, r._3) } }

  val axiom:Tabulate = tabulate("M",(el ^^ single | axiom ~ axiom ^^ mult) aggregate h)

  val mats = Utils.genMats(128) // scala.Array((1,2),(2,20),(20,2),(2,4),(4,2),(2,1),(1,7),(7,3)) // -> 1x3 matrix, 122 multiplications
  //override val window = 10

  // Vanilla Scala version
  override val benchmark = true
  var (r1,b1) = time("Plain")(()=>backtrack(mats,psCPU).head)
  scala.Console.println(r1)
  scala.Console.println(build(mats,b1))

  scala.Console.println("--------")
  scala.Console.println(time("LMS_parse")(()=>parse(mats).head))
  scala.Console.println("--------")
  
  var (r2,b2) = time("LMS")(()=>backtrack(mats).head)
  scala.Console.println(r2)
  scala.Console.println(build(mats,b2))

  //scala.Console.println(backtrack(mats,psBottomUp))

  // LMS generated code
  //scala.Console.println(parseLMS(mats))
  //scala.Console.println(genLMS)
}

// -----------------------------------------------------------------

trait LMSGenADP extends ADPParsers with LMSGen { self:Signature =>
  def in(idx:Rep[Int]):Rep[Alphabet] = in1_read(idx)(tps._1)
  override def genTerminal[T](t:Terminal[T],i:Rep[Int],j:Rep[Int],cont:Rep[T]=>Rep[Unit]) = t match {
    case `empty` => if (i==j) cont(unit(()).asInstanceOf[Rep[T]])
    case `emptyi` => if (i==j) cont(i.asInstanceOf[Rep[T]])
    case `el` => if (i+1==j) cont(in(i).asInstanceOf[Rep[T]])
    case `eli` => if (i+1==j) cont(i.asInstanceOf[Rep[T]])
    case _ => super.genTerminal(t,i,j,cont)
  }

  override def parse(in:Input,ps:ParserStyle=psScalaLMS):List[Answer] = if (ps!=psScalaLMS) super.parse(in,ps) else {
    val as=bottomUp(in); var res:scala.List[Answer]=Nil
    for((p,a)<-as) if (p==axiom) res=if (window>0) h( (0 to in.size-window).map{x=>a(x*(in.size+2)+window)._1}.toList ) else scala.List(a(in.size)._1)
    res
  }

  override def backtrack(in:Input,ps:ParserStyle=psScalaLMS):List[(Answer,Trace)] = if (ps!=psScalaLMS) super.backtrack(in,ps) else run(in,()=>{
    val as=bottomUp(in); val n=size+1
    for((p,a)<-as) for (i<-0 to size) for (j<-i to (if (window>0) java.lang.Math.min(i+window,size) else size)) {
      val d=n+1+i-j; val idx = (n*(n+1)-d*(d-1))/2 + i // Must be sync'ed with BaseParser::Tabulate::idx(sw:Subword=(i,j))
      p.data(idx) = scala.List(a(i*n+j))
    }
    if (window>0) aggr(((0 to size-window).flatMap{x=>axiom.backtrack(x,window+x)}).toList, h) else axiom.backtrack(0,size)
  })

  private def bottomUp(in:Input) : List[(Tabulate,Array[(Answer,Backtrack)])] = {
    val as = rulesOrder.map{n=>(rules(n),new Array[(Answer,Backtrack)]( (in.size+1)*(in.size+1) ))}
    botUp(in,as.map(_._2)); as
  }

  private lazy val botUp:(Input,List[ Array[(Answer,Backtrack)] ])=>Unit = {
    val buf = new java.io.ByteArrayOutputStream;
    val pr = new java.io.PrintWriter(buf)
    implicit val manifestForAlphabet=tps._1
    implicit val manifestForAnswer=tps._2
    val className = freshClassName
    val source = new java.io.StringWriter()

    def botUpLMS(in1:Rep[Input],tabs: Rep[List[ Array[(Answer,Backtrack)] ]]) : Rep[Unit] = {
      named_val("in1",in1); named_val("size1",in1.length+unit(1))
      rulesOrder.zipWithIndex.foreach{case (n,i)=> named_val("tab_"+n,tabs(unit(i))) }
      val up = var_new(in1.length+unit(1)); if (window>0) if (up>unit(window+1)) var_assign(up,unit(window+1))
      range_foreach(range_until(unit(0),up),(l:Rep[Int])=>{
        range_foreach(range_until(unit(0),in1.length+unit(1)-l),(i:Rep[Int])=>{ val j=i+l
          rulesOrder.foreach{n=> genTabLMS(rules(n))(i,j) }
        })
      })
    }

    codegen.emitSource2(botUpLMS _, className, new java.io.PrintWriter(source))
    compiler.compile[(Input,List[ Array[(Answer,Backtrack)] ]) =>Unit](className,source.toString)
  }
}

// -----------------------------------------------------------------

trait LMSGenTT extends TTParsers with LMSGen { self:Signature =>
  // XXX: missing two-tracks

  // Two-track bottom-up parsing (Scala)
  private def bottomUpLMS(in1:Rep[Input],in2:Rep[Input],tabs: Rep[List[ Array[(Answer,Backtrack)] ]]) : Rep[Unit] = {
    implicit val manifestForAlphabet=tps._1
    implicit val manifestForAnswer=tps._2
    named_val("in1",in1); named_val("size1",in1.length+unit(1))
    named_val("in2",in2); named_val("size2",in2.length+unit(1))
    rulesOrder.zipWithIndex.foreach{case (n,i)=> named_val("tab_"+n,tabs(unit(i))) }
    range_foreach(range_until(unit(0),in1.length+unit(1)),(i:Rep[Int])=>{
      range_foreach(range_until(unit(0),in1.length+unit(1)),(j:Rep[Int])=>{
        rulesOrder.foreach{n=> genTabLMS(rules(n))(i,j) }
      })
    })
  }
}

// -----------------------------------------------------------------

trait LMSGen extends CodeGen with ScalaOpsPkgExp with DPExp { self:Signature =>
  val codegen = new ScalaCodeGenPkg with ScalaGenDP { val IR:self.type = self }
  val ccodegen = new CCodeGenPkg with CGenDP with CGenTupleOps { val IR:self.type = self
    override def emitSource[A:Manifest](args: List[Sym[_]], body: Block[A], functionName: String, out: java.io.PrintWriter) = { val sA=remap(manifest[A])
      withStream(out) { stream.print((args zip scala.List("i","j")).map{case (a,v) => remap(a.tp)+" "+quote(a)+" = "+v+";\n"}.mkString); emitBlock(body) }; Nil
    }
  }

  // Replaces LMS's ScalaCompiler
  private var compileCount = 0
  protected def freshClassName = { compileCount=compileCount+1; "staged$"+compileCount }
  def compile[A,B](f: Exp[A] => Exp[B])(implicit mA: Manifest[A], mB: Manifest[B]): A=>B = {
    val className=freshClassName; val source=new java.io.StringWriter()
    codegen.emitSource(f, className, new java.io.PrintWriter(source))
    compiler.compile[A=>B](className,source.toString)
  }

  // Helper to wrap LMS function appropriately
  import scala.language.implicitConversions
  implicit def lfun[T:Manifest,U:Manifest](f:Rep[T]=>Rep[U]) = new LFun(f)
  case class LFun[T:Manifest,U:Manifest](f:Rep[T]=>Rep[U]) extends Function1[T,U] with CFun {
    lazy val fs = self.compile(f);
    def apply(arg:T) = fs(arg)

    import java.io._
    private def getArgs(as:List[LMSGen.this.Sym[_]]) = as.map{x=>(ccodegen.quote(x), x.tp.toString) }
    private def getBody(bdy:ccodegen.Block[_]):String = {
      val os=new ByteArrayOutputStream; val stream=new PrintWriter(os)
      ccodegen.withStream(stream) {
        ccodegen.emitBlock(bdy); val y=ccodegen.getBlockResult(bdy)
        if(ccodegen.remap(y.tp) != "void") stream.println("return "+ ccodegen.quote(y)+";")
      }
      val temp=os.toString("UTF-8"); os.close; stream.close; temp
    }

    private val s = fresh[T]
    val args = getArgs(scala.List(s))
    val body = getBody(ccodegen.reifyBlock(f(s)))
    val tpe = manifest[U].toString
  }

  // Helpers to set manifest appropriately
  //private def _in1(idx:Rep[Int]):Rep[Alphabet] = in1_read(idx)(tps._1)
  //private def _in2(idx:Rep[Int]):Rep[Alphabet] = in2_read(idx)(tps._1)
  private def _valid(t:Tabulate,i:Rep[Int],j:Rep[Int]) = tab_valid(t.name,tab_idx(i,j))(tps._2)
  private def _read(t:Tabulate,i:Rep[Int],j:Rep[Int]) = { implicit val manifestForAnswer=tps._2; tab_read(t.name,tab_idx(i,j)) }
  private def _write(t:Tabulate,i:Rep[Int],j:Rep[Int],value:Rep[Answer],rule:Rep[Int],bt:Rep[Array[Int]]) = { implicit val manifestForAnswer=tps._2; tab_write(t.name,tab_idx(i,j),value,rule,bt) }

  // C/CUDA codegen
  private var genC = false
  override def genTab(t:Tabulate):String = { val buf = new java.io.ByteArrayOutputStream;
    genC=true; ccodegen.emitSource2(genTabLMS(t) _,"kern",new java.io.PrintWriter(buf)); genC=false
    buf.toString
  }

  def genTerminal[T](t:Terminal[T],i:Rep[Int],j:Rep[Int],cont:Rep[T]=>Rep[Unit]) = { // general case for seq()
    if (i+unit(t.min)<=j && (unit(t.max==maxN) || i+unit(t.max)>=j)) cont((i,j).asInstanceOf[Rep[T]])
  }

  type Cont[T] = (Rep[T],Rep[Int])=>Rep[Unit]
  def genTabLMS(t:Tabulate)(i0:Rep[Int],j0:Rep[Int]):Rep[Unit] = {
    val bt0 = bt_new(t.inner.cat) // best backtrack
    val bt = bt_new(t.inner.cat) // temporary backtrack
    t.inner match { case Aggregate(_,_) => case _ => sys.error("All tabulation must contain an aggregation") }
    gen[Answer](t.inner,(v:Rep[Answer],r:Rep[Int]) => _write(t,i0,j0,v,r,bt0),i0,j0,0,true)

    def gen[T](p0:Parser[T],cont:Cont[T],i:Rep[Int],j:Rep[Int],off:Int,top:Boolean=false) : Rep[Unit] = p0 match {
      case Aggregate(p,h) => 
        implicit val mT:Manifest[T]=tps._2.asInstanceOf[Manifest[T]] // FIXME: not necessarily, but do we care ?
        implicit val oT=new Ordering[T] { def compare(x:T,y:T): Int=0 } // FIXME: I love cheating
        def af[U](f:T=>U):Rep[T]=>Rep[T] = f match { case l@LFun(f0) => f0.asInstanceOf[Rep[T]=>Rep[T]] case _ => sys.error("Non-LMS function: "+f) }  // FIXME: T=>Numeric[U]
        var av = var_new(unit(null).asInstanceOf[Const[T]])
        var ar = var_new(unit(-1))
        def empty:Rep[Boolean] = if (genC) ar==unit(-1) else av==unit(null)
        gen(p,{(v:Rep[T],r:Rep[Int]) =>
          def set = { if (top) bt_copy(bt0,bt); var_assign(av,v); var_assign(ar,r) }
          h.toString match {
            case "$$max$$" => if (boolean_or(empty , v > av)) set
            case "$$min$$" => if (empty || v < av) set
            case "$$count$$" => var_plusequals(av,unit(1))
            case "$$sum$$" => var_plusequals(av,v)
            case "$$minBy$$" => val f=af(h.asInstanceOf[MinBy[Any,Any]].f); if (empty) set else if (f(v) < f(av)) set // fix for sequentiality
            case "$$maxBy$$" => val f=af(h.asInstanceOf[MaxBy[Any,Any]].f); if (empty || f(v) < f(av)) set
            case _ => sys.error("Unsupported aggregation "+h.toString)
          }
        },i,j,off)
        if (!empty) cont(av,ar)
      case Or(l,r) => gen(l,cont,i,j,off); gen(r,(v:Rep[T],r:Rep[Int])=>cont(v,r+unit(l.alt)),i,j,off)
      case Filter(p,LFun(f)) => if (f((i,j))) gen(p,cont,i,j,off);
      case Map(p,m@LFun(f)) => gen(p,(v:Rep[Any],r:Rep[Int])=>cont(f(v),r),i,j,off)
      case p:Tabulate => if (_valid(p,i,j)) cont(_read(p,i,j),unit(0)) // val v=_read(p,i,j); if (v!=unit(null)) cont(v,unit(0)) // XXX: fix emptiness check
      case t@Terminal(_,_,_) => genTerminal(t,i,j,(v:Rep[T])=>cont(v,unit(0)))
      case cc@Concat(left,right,track) => val (lL,lU,rL,rU) = cc.indices
        def loop(kmin:Rep[Int],kmax:Rep[Int],f:Rep[Int]=>Rep[Unit]) = {
          range_foreach(range_until(kmin,kmax+unit(1)),(k:Rep[Int])=> { bt_set(bt,left.cat,k); f(k) })
        }
        def inner(li:Rep[Int],lj:Rep[Int],ri:Rep[Int],rj:Rep[Int]) = {
          gen(left,(vl:Rep[Any],rl:Rep[Int])=>{
            gen(right,(vr:Rep[Any],rr:Rep[Int])=>{
              cont((vl,vr),rl*unit(right.alt)+rr)
            },ri,rj,off+left.cat+(if (cc.hasBt) 1 else 0))
          },li,lj,off)
        }
        if (track==0) loop(if (unit(rU==maxN) || i+unit(lL) > j-unit(rU)) i+unit(lL) else j-unit(rU),
                           if (unit(lU==maxN) || j-unit(rL) < i+unit(lU)) j-unit(rL) else i+unit(lU), k=>inner(i,k, k,j))
        else if (track==1) loop(if (unit(lU==maxN) || i-unit(lU) < unit(0)) unit(0) else i-unit(lU), i-unit(lL), k=>inner(k,i, k,j))
        else if (track==2) loop(if (unit(rU==maxN) || j-unit(rU) < unit(0)) unit(0) else j-unit(rU), j-unit(rL), k=>inner(i,k, k,j))
        else sys.error("Unimplemented track")
      case _ => sys.error("Bad parser")
    }
  }
}

// -----------------------------------------------------------------
// DP-specific operations

import scala.virtualization.lms.common._
import scala.reflect.SourceContext
import scala.virtualization.lms.internal.{Expressions,Effects}

trait DPOps extends Base with Expressions with Effects {
  def tab_idx(i:Rep[Int], j:Rep[Int])(implicit pos: SourceContext): Rep[Int] // to get common subexpression elimination
  def tab_valid[T](name:String, idx:Rep[Int])(mT:Manifest[T])(implicit pos: SourceContext) : Rep[Boolean]
  def tab_read[T:Manifest](name:String, idx:Rep[Int])(implicit pos: SourceContext): Rep[T]
  def tab_write[T:Manifest](name:String, idx:Rep[Int], value:Rep[T], rule:Rep[Int], bt:Rep[Array[Int]])(implicit pos: SourceContext): Rep[Unit]
  def in1_read[T](idx:Rep[Int])(mT:Manifest[T])(implicit pos: SourceContext): Rep[T]
  def in2_read[T](idx:Rep[Int])(mT:Manifest[T])(implicit pos: SourceContext): Rep[T]
  def bt_new(size:Int)(implicit pos: SourceContext) : Rep[Array[Int]] // int[] stack array storage for backtrack
  def bt_set(dst:Rep[Array[Int]], idx:Int, value:Rep[Int])(implicit pos: SourceContext) : Rep[Unit]
  def bt_copy(dst:Rep[Array[Int]],src:Rep[Array[Int]])(implicit pos: SourceContext) : Rep[Unit]
  def named_val[T](name:String,value:Rep[T]) : Rep[Unit]
}

trait DPExp extends DPOps with EffectExp {
  case class TabIdx(i:Exp[Int], j:Exp[Int])(implicit pos: SourceContext) extends Def[Int]
  case class TabValid[T:Manifest](name:String, idx:Exp[Int])(implicit pos: SourceContext) extends Def[Boolean]
  case class TabRead[T:Manifest](name:String, idx:Exp[Int])(implicit pos: SourceContext) extends Def[T]
  case class TabWrite[T:Manifest](name:String, idx:Exp[Int], value:Exp[T], rule:Rep[Int], bt:Exp[Array[Int]])(implicit pos: SourceContext) extends Def[Unit]
  case class In1Read[T:Manifest](idx:Exp[Int])(implicit pos: SourceContext) extends Def[T]
  case class In2Read[T:Manifest](idx:Exp[Int])(implicit pos: SourceContext) extends Def[T]
  case class BtNew(size:Int)(implicit pos: SourceContext) extends Def[Array[Int]]
  case class BtSet(dst:Exp[Array[Int]], idx:Int, value:Exp[Int]) extends Def[Unit]
  case class BtCopy(dst:Exp[Array[Int]], src:Exp[Array[Int]]) extends Def[Unit]
  case class NamedVal[T](name:String,value:Rep[T]) extends Def[Unit]

  def tab_idx(i:Rep[Int], j:Rep[Int])(implicit pos: SourceContext) = TabIdx(i,j)
  def tab_valid[T](name:String, idx:Rep[Int])(mT:Manifest[T])(implicit pos: SourceContext) = reflectEffect(TabValid(name,idx))
  def tab_read[T:Manifest](name:String, idx:Exp[Int])(implicit pos: SourceContext) = reflectEffect(TabRead(name,idx))
  def tab_write[T:Manifest](name:String, idx:Rep[Int], value:Rep[T], rule:Rep[Int], bt:Rep[Array[Int]])(implicit pos: SourceContext) = reflectEffect(TabWrite(name,idx,value,rule,bt))
  def in1_read[T](idx:Rep[Int])(mT:Manifest[T])(implicit pos: SourceContext) = reflectEffect(In1Read(idx))
  def in2_read[T](idx:Rep[Int])(mT:Manifest[T])(implicit pos: SourceContext) = reflectEffect(In2Read(idx))
  def bt_new(size:Int)(implicit pos: SourceContext) = reflectEffect(BtNew(size))
  def bt_set(dst:Rep[Array[Int]], idx:Int, value:Rep[Int])(implicit pos: SourceContext) = reflectEffect(BtSet(dst,idx,value))
  def bt_copy(dst:Rep[Array[Int]],src:Rep[Array[Int]])(implicit pos: SourceContext) = reflectEffect(BtCopy(dst,src))
  def named_val[T](name:String,value:Rep[T]) = reflectEffect(NamedVal(name,value))
}

trait ScalaGenDP extends ScalaGenEffect {
  val IR: DPExp
  import IR._
  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case TabIdx(i,j) => stream.println("val "+quote(sym)+" = "+quote(i)+" * size1 + "+quote(j)) // XXX: fix dimension
    case TabValid(name,idx) => stream.println("val "+quote(sym)+" = tab_"+name+"("+quote(idx)+")!=null")
    case TabRead(name,idx) => stream.println("val "+quote(sym)+" = tab_"+name+"("+quote(idx)+")._1")
    case TabWrite(name,idx,value,rule,bt) => stream.println("tab_"+name+"("+quote(idx)+") = ("+quote(value)+",("+quote(rule)+","+quote(bt)+".toList)); val "+quote(sym)+"=()")
    case In1Read(i) => stream.println("val "+quote(sym)+" = in1("+quote(i)+");")
    case In2Read(i) => stream.println("val "+quote(sym)+" = in2("+quote(i)+");")
    case BtNew(size) => stream.println("var "+quote(sym)+" = new Array[Int]("+size+");")
    case BtSet(dst, idx, value) => stream.println(quote(dst)+"("+idx+") = "+quote(value)+"; val "+quote(sym)+"=()")
    case BtCopy(dst, src) => stream.println(quote(dst)+" = "+quote(src)+".clone(); val "+quote(sym)+"=()")
    case NamedVal(name,value) => stream.println("val "+name+" = "+quote(value)+";")
    case _ => super.emitNode(sym, rhs)
  }
}

trait CGenDP extends CGenEffect {
  val IR: DPExp with VariablesExp
  import IR._
  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case NewVar(Const(null)) => stream.println(remap(sym.tp) + " " + quote(sym) + ";") // uninitialized variable
    case TabIdx(i,j) => stream.println("const int "+quote(sym)+" = idx("+quote(i)+","+quote(j)+");")
    case TabValid(name,idx) => stream.println("bool "+quote(sym)+" = back["+quote(idx)+"]."+name+".rule != -1;")
    case TabRead(name,idx) => stream.println(remap(sym.tp) + " " + quote(sym)+" = cost["+quote(idx)+"]."+name+";")
    case TabWrite(name,idx,value,rule,bt) =>
      stream.println("cost["+quote(idx)+"]."+name+" = "+quote(value)+";")
      stream.println("back["+quote(idx)+"]."+name+".rule = "+quote(rule)+";")
      //stream.println("back["+quote(idx)+"]."+name+".pos = "+quote(bt)+";")
      stream.println("memcpy(back["+quote(idx)+"]."+name+".pos,"+quote(bt)+",sizeof("+quote(bt)+"));")
    case In1Read(i) => stream.println("input_t "+quote(sym)+" = _in1["+quote(i)+"];")
    case In2Read(i) => stream.println("input_t "+quote(sym)+" = _in2["+quote(i)+"];")
    case BtNew(size) => stream.println("short "+quote(sym)+"["+size+"];")
    case BtSet(dst, idx, value) => stream.println(quote(dst)+"["+idx+"] = "+quote(value)+";")
    case BtCopy(dst, src) => 
      //stream.println(quote(dst)+" = "+quote(src)+";")
      stream.println("memcpy("+quote(dst)+","+quote(src)+",sizeof("+quote(src)+"));")



    case NamedVal(name,value) => sys.error("NamedVal should not appear") //stream.println(value.tp+" "+name+" = "+quote(value)+";")
    case _ => super.emitNode(sym, rhs)
  }
}

// -----------------------------------------------------------------
// Tuple operations operations

import scala.virtualization.lms.common._
import scala.reflect.RefinedManifest

trait CGenTupleOps extends CLikeGenBase {
  val IR: TupleOpsExp
  import IR._

  private val encounteredTuples = collection.mutable.HashMap.empty[String, Def[Any]]
  private def registerType[A](m: Manifest[A], rhs: Def[Any]) { encounteredTuples += tupleClassName(m) -> rhs }

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case e2@ETuple2(a,b) => registerType(sym.tp,rhs); emitValDef(sym, "("+tupleClassName(sym.tp)+"){"+ quote(a)+","+quote(b)+"}")
    case Tuple2Access1(t) => emitValDef(sym, quote(t) + "._1")
    case Tuple2Access2(t) => emitValDef(sym, quote(t) + "._2")
    case e3@ETuple3(a,b,c) => registerType(sym.tp,rhs); emitValDef(sym, "("+tupleClassName(sym.tp)+"){"+quote(a)+","+quote(b)+","+quote(c)+"}")
    case Tuple3Access1(t) => emitValDef(sym, quote(t) + "._1")
    case Tuple3Access2(t) => emitValDef(sym, quote(t) + "._2")
    case Tuple3Access3(t) => emitValDef(sym, quote(t) + "._3")
    case e4@ETuple4(a,b,c,d) => registerType(sym.tp,rhs); emitValDef(sym, "("+tupleClassName(sym.tp)+"){"+quote(a)+","+quote(b)+","+quote(c)+","+quote(d) + "}")
    case Tuple4Access1(t) => emitValDef(sym, quote(t) + "._1")
    case Tuple4Access2(t) => emitValDef(sym, quote(t) + "._2")
    case Tuple4Access3(t) => emitValDef(sym, quote(t) + "._3")
    case Tuple4Access4(t) => emitValDef(sym, quote(t) + "._4")
    case e5@ETuple5(a,b,c,d,e) => registerType(sym.tp,rhs); emitValDef(sym, "("+tupleClassName(sym.tp)+"){"+quote(a)+","+quote(b)+","+quote(c)+","+quote(d)+","+quote(e)+"}")
    case Tuple5Access1(t) => emitValDef(sym, quote(t) + "._1")
    case Tuple5Access2(t) => emitValDef(sym, quote(t) + "._2")
    case Tuple5Access3(t) => emitValDef(sym, quote(t) + "._3")
    case Tuple5Access4(t) => emitValDef(sym, quote(t) + "._4")
    case Tuple5Access5(t) => emitValDef(sym, quote(t) + "._5")
    case _ => super.emitNode(sym, rhs)
  }

  override def remap[A](m: Manifest[A]): String = m.toString match {
    case f if f.startsWith("scala.Tuple") => tupleClassName(m)
    case _ => super.remap(m)
  }

  // not public because should not be called with a manifest not describing a subtype of Manifest[Record]
  protected def tupleClassName[A](m: Manifest[A]): String = m.toString match {
    case f if f.startsWith("scala.Tuple") =>
      val targs = m.typeArguments
      val res = remap(m.typeArguments.last)
      def unwrapTupleStr(s: String): Array[String] = { //code borrowed from lms.Functions.scala
        if (s.startsWith("scala.Tuple")) s.slice(s.indexOf("[")+1,s.length-1).filter(c => c != ' ').split(",") else Array(s)
      }
      val targsUnboxed = targs.flatMap(t => unwrapTupleStr(remap(t)))
      "T" + targsUnboxed.size + targsUnboxed.map{_(0)}.mkString //+ "[" + targsUnboxed.mkString(",") + sep + res + "]"
    case _ => super.remap(m)
  }

  import java.io.PrintWriter
  def emitDataStructures(out: PrintWriter) { withStream(out) { for ((name,tuple) <- encounteredTuples) {
    stream.println{ tuple match {
      case e2@ETuple2(a,b) => "typedef struct {"+ remap(e2.m1) + " _1; " + remap(e2.m2) + " _2; } "+name+";"
      case e3@ETuple3(a,b,c) => "typedef struct {"+ remap(e3.m1) + " _1; " + remap(e3.m2) + " _2; "+ remap(e3.m3) +" _3; } "+name+";"
      case e4@ETuple4(a,b,c,d) => "typedef struct {"+ remap(e4.m1) + " _1; " + remap(e4.m2) + " _2; "+ remap(e4.m3) +" _3; " + remap(e4.m4) +" _4; } "+name+";"
      case e5@ETuple5(a,b,c,d,e) => "typedef struct {"+ remap(e5.m1) + " _1; " + remap(e5.m2) + " _2; "+ remap(e5.m3) +" _3; " + remap(e5.m4) +" _4; " + remap(e5.m5) +" _5 } "+name+";"
    }}
    // stream.println("case class " + name + "(" + (for ((n, e) <- fields) yield n + ": " + remap(e.tp)).mkString(", ") + ")")
  }}}
}
