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
  val axiom:Tabulate = tabulate("M",(el ^^ single | axiom ~ axiom ^^ mult) aggregate h)

  val mats = Utils.genMats() // scala.Array((1,2),(2,20),(20,2),(2,4),(4,2),(2,1),(1,7),(7,3)) // -> 1x3 matrix, 122 multiplications

  // Vanilla Scala version
  override val benchmark = true
  var (r1,b1) = time("Plain")(()=>backtrack(mats,psTopDown).head)
  scala.Console.println(r1)
  scala.Console.println(build(mats,b1))
  
  var (r2,b2) = time("LMS")(()=>backtrack(mats,psBottomUp).head)
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
  def genTerminal[T](t:Terminal[T],i:Rep[Int],j:Rep[Int],cont:Rep[T]=>Rep[Unit]) = t match {
    case `empty` => if (i==j) cont(unit(()).asInstanceOf[Rep[T]])
    case `emptyi` => if (i==j) cont(i.asInstanceOf[Rep[T]])
    case `el` => if (i+1==j) cont(in(i).asInstanceOf[Rep[T]])
    case `eli` => if (i+1==j) cont(i.asInstanceOf[Rep[T]])
    // XXX: missing seq(min,max) => create a case class to pattern match
    case _ => sys.error("Unsupported terminal")
  }

  override def parseBottomUp(in1:Input) {
    val buf = new java.io.ByteArrayOutputStream;
    val pr = new java.io.PrintWriter(buf)
    implicit val manifestForAlphabet=tps._1
    implicit val manifestForAnswer=tps._2
    val className = freshClassName
    val source = new java.io.StringWriter()

    codegen.emitSource2(bottomUpLMS _, className, new java.io.PrintWriter(source))
    //scala.Console.println("SOURCE CODE = "+source.toString)
    val bu = compiler.compile[(Input,List[ Array[(Answer,Backtrack)] ]) =>Unit](className,source.toString)
    
    val N = size+1
    val mem = N*N
    val as = rulesOrder.map{n=>(rules(n),new Array[(Answer,Backtrack)](mem))}

    bu(in1,as.map(_._2))
    // Push back into regular matrices
    for((p,a)<-as) {
      def idx(sw:Subword):Int = { val d=N+1+sw._1-sw._2; ( N*(N+1) - d*(d-1) ) /2 + sw._1 }
      for (i<-0 to size) {
        for (j<-0 to size) {
          if (i<=j) p.data(idx((i,j))) = scala.List(a(i*N+j))
        }
      }
    }
    // ---
  }
}

// -----------------------------------------------------------------

// XXX: missing two-tracks

// -----------------------------------------------------------------

trait LMSGen extends CodeGen with ScalaOpsPkgExp with GeneratorOpsExp with DPExp with BooleanOpsExp with ADPParsers { self:Signature =>
  val codegen = new ScalaCodeGenPkg with ScalaGenGeneratorOps with ScalaGenDP { val IR:self.type = self }
  //val ccodegen = new CCodeGenPkg with CGenGeneratorOps with CGenDP { val IR:self.type = self }

  // Replaces LMS's ScalaCompiler
  private var compileCount = 0
  /*private*/ def freshClassName = { compileCount=compileCount+1; "staged$"+compileCount }

  def compile[A,B](f: Exp[A] => Exp[B])(implicit mA: Manifest[A], mB: Manifest[B]): A=>B = {
    val className = freshClassName
    val source = new java.io.StringWriter()
    codegen.emitSource(f, className, new java.io.PrintWriter(source))
    compiler.compile[A=>B](className,source.toString)
  }

  // Helper to wrap LMS function appropriately
  def lfun[T:Manifest,U:Manifest](f:Rep[T]=>Rep[U]) = new LFun(f)
  case class LFun[T:Manifest,U:Manifest](f:Rep[T]=>Rep[U]) extends Function1[T,U] {
    //val mT = manifest[T] // to feed at LMS node construction
    //val mU = manifest[U]
    lazy val fs = self.compile(f);
    def apply(arg:T) = fs(arg)
  }

  // Helpers to set manifest appropriately
  //private def _in1(idx:Rep[Int]):Rep[Alphabet] = in1_read(idx)(tps._1)
  //private def _in2(idx:Rep[Int]):Rep[Alphabet] = in2_read(idx)(tps._1)
  private def _read(t:Tabulate,i:Rep[Int],j:Rep[Int]) = tab_read(t.name,tab_idx(i,j))(tps._2)
  private def _write(t:Tabulate,i:Rep[Int],j:Rep[Int],value:Rep[Answer],rule:Rep[Int],bt:Rep[Array[Int]]) = { implicit val manifestForAnswer=tps._2; tab_write(t.name,tab_idx(i,j),value,rule,bt) }
  
  /*
  def parseLMS(in1:Input):(Answer,Trace) = {
    val buf = new java.io.ByteArrayOutputStream;
    val pr = new java.io.PrintWriter(buf)
    analyze
    implicit val manifestForAlphabet=tps._1
    implicit val manifestForAnswer=tps._2

    val className = freshClassName
    val source = new java.io.StringWriter()

    codegen.emitSource2(bottomUpLMS _, className, new java.io.PrintWriter(source))
    //scala.Console.println("SOURCE CODE = "+source.toString)
    val bu = compiler.compile[(Input,List[ Array[(Answer,Backtrack)] ]) =>Unit](className,source.toString)
    
    val N = in1.length+1
    val mem = N*N
    val as = rulesOrder.map{n=>(rules(n),new Array[(Answer,Backtrack)](mem))}

    bu(in1,as.map(_._2))

    tabInit(N,N)
    for((p,a)<-as) {

      def idx(sw:Subword):Int = { val d=N+1+sw._1-sw._2; ( N*(N+1) - d*(d-1) ) /2 + sw._1 }
      for (i<-0 to in1.length) {
        for (j<-0 to in1.length) {
          if (i<=j) {
            p.data(idx((i,j))) = scala.List(a(i*N+j))
          }
        }
      }

    }
    tabReset

    // XXX: from this point push back into original parser matrix


    //as.foreach(x=>x.foreach(y=> scala.Console.println(y) ))


    var res:(Answer,Trace)=null
    for((p,a)<-as) { if (p==axiom) res=a(in1.size) }
    //rulesOrder.zipWithIndex.foreach { case (n,i)=> if (rules(n)==axiom) res=as(i).apply(in1.size) }
    res
  }
  */

/*
  def backtrackLMS(as:Rep[List[ Array[(Answer,Backtrack)] ]]) : Rep[Unit] {

  }

  def btLMS2(p0:Parser[T],i:Rep[Int],j:Rep[Int],r:Rep[Int],idx:Array[Int],off:Rep[Int], /*within idx */ as:List[ Array[(Answer,Backtrack)] ]) {

  }

  // ----------------------------
  // This is only for Scala/LMS
  def btLMS[T](p0:Parser[T],i:Int,j:Int,r:Int,idx:Array[Int]) : Trace = p0 match { //  = List[(Subword,Backtrack)]
    case Aggregate(p,_) => btLMS(p,i,j,r,idx)
    case Filter(p,_) => btLMS(p,i,j,r,idx)
    case Map(p,_) => btLMS(p,i,j,r,idx)
    case Terminal(_,_,_) => Nil
    // XXX: tabulate ==> map to appropriate array index
    case Or(left,right) => var a=left.alt-1; if (r<=a) btLMS(left,i,j,r,idx) else btLMS(right,i,j,r-a,idx)
    case cc@Concat(left,right,track) =>
      val a=right.alt; val c=left.cat;
      val (bl,br,kb) = ((r/a,idx.take(c)), (r%a,idx.drop(c+(if (cc.hasBt)1 else 0))), if (cc.hasBt)idx(c) else -1)

      val (swl,swr) = (track,cc.indices) match {
        case (0,(lL,lU,rL,rU)) if i < j => // single track
          val k=if(cc.hasBt)kb else if (rU==maxN || i+lL>j-rU)i+lL else j-rU; ((i,k),(k,j))
        case (1,(l,u,_,_)) => val k=if(cc.hasBt)kb else i-l; ((k,i),(k,j)) // tt:concat1
        case (2,(_,_,l,u)) => val k=if(cc.hasBt)kb else j-l; ((i,k),(k,j)) // tt:concat2
        case _ => ((0,0),(0,0))
      }
      btLMS(left,swl._1,swl._2,bl._1,bl._2) ::: btLMS(right,swr._1,swr._2,br._1,br._2)
  }
  */
/*
  class Tabulate(in: => Parser[Answer], val name:String, val alwaysValid:Boolean=false) extends Parser[Answer] {
    def apply(sw: Subword) = get(sw) map {x=>(x._1,bt0)}
    def unapply(sw:Subword,bt:Backtrack) = get(sw).map{ case (c,b) => List((sw,b)) }.head

    def backtrack(sw:Subword) = {
      val e=get(sw).head;
      def bt0(tail:Trace,pending:Trace):List[Trace] = pending match {
        case Nil => List(tail)
        case (sw,(rule,bt))::ps => val (t,rr) = findTab(rule)
          val res = t.inner.unapply(sw,(rr,bt))
          bt0((sw,(rule,bt))::tail, res:::ps)
      }
      bt0(Nil,List((sw,e._2))).map{x=>(e._1,x)}
    } 
  }

  def findTab(rule:Int):(Tabulate,Int) = {
    rules.find{ case (n,t)=> val rr=rule-t.id; rr >= 0 && rr < t.inner.alt} match {
      case Some((n,t)) => (t,rule-t.id)
      case None => sys.error("No tabulation for subrule #"+rule)
    }
  }
*/



  // XXX: also make a wrapper that alloc/free tables and does the backtrack
  def bottomUpLMS(in1:Rep[Input], /*in2:Rep[Input],*/ tabs: Rep[List[ Array[(Answer,Backtrack)] ]]) : Rep[Unit] = {
    implicit val manifestForAlphabet=tps._1
    implicit val manifestForAnswer=tps._2

    named_val("in1",in1)
    named_val("size1",in1.length+unit(1))
    // named_val("input_2",in2)
    rulesOrder.zipWithIndex.foreach{case (n,i)=>
      named_val("tab_"+n,tabs(unit(i)))
    }
    // explicitly name tables
    range_foreach(range_until(unit(0),in1.length+unit(1)),(l:Rep[Int])=>{
      range_foreach(range_until(unit(0),in1.length+unit(1)-l),(i:Rep[Int])=>{ val j=i+l
        rulesOrder.foreach{n=> genTabLMS(rules(n))(i,j) } // XXX: address the rule names in codegen
      })
    })
  }


  def genLMS:String = {
    val buf = new java.io.ByteArrayOutputStream;
    val pr = new java.io.PrintWriter(buf)
    analyze
    rulesOrder.foreach{n=>codegen.emitSource2(genTabLMS(rules(n)) _, "kernel", pr) }
    buf.toString
  }

  def genTerminal[T](t:Terminal[T],i:Rep[Int],j:Rep[Int],cont:Rep[T]=>Rep[Unit]) : Rep[Unit] // abstract

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
        def empty:Rep[Boolean] = av==unit(null) // in C: ar==unit(-1)
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
      case p:Tabulate => val v=_read(p,i,j); if (v!=unit(null)) cont(v,unit(0)) // XXX: fix emptiness check
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

import scala.virtualization.lms.common._
import scala.reflect.SourceContext
import scala.virtualization.lms.internal.{Expressions,Effects}

trait DPOps extends Base with Expressions with Effects {
  def tab_idx(i:Rep[Int], j:Rep[Int])(implicit pos: SourceContext): Rep[Int] // to get common subexpression elimination
  def tab_read[T](name:String, idx:Rep[Int])(mT:Manifest[T])(implicit pos: SourceContext): Rep[T]
  def tab_write[T:Manifest](name:String, idx:Rep[Int], value:Rep[T], rule:Rep[Int], bt:Rep[Array[Int]])(implicit pos: SourceContext): Rep[Unit]
  def in1_read[T](idx:Rep[Int])(mT:Manifest[T])(implicit pos: SourceContext): Rep[T]
  def in2_read[T](idx:Rep[Int])(mT:Manifest[T])(implicit pos: SourceContext): Rep[T]

  // int[] stack array storage for backtrack
  def bt_new(size:Int)(implicit pos: SourceContext) : Rep[Array[Int]]
  def bt_set(dst:Rep[Array[Int]], idx:Int, value:Rep[Int])(implicit pos: SourceContext) : Rep[Unit]
  def bt_copy(dst:Rep[Array[Int]],src:Rep[Array[Int]])(implicit pos: SourceContext) : Rep[Unit]

  def named_val[T](name:String,value:Rep[T]) : Rep[Unit]
}

trait DPExp extends DPOps with EffectExp {
  case class TabIdx(i:Exp[Int], j:Exp[Int])(implicit pos: SourceContext) extends Def[Int]
  case class TabRead[T:Manifest](name:String, idx:Exp[Int])(implicit pos: SourceContext) extends Def[T]
  case class TabWrite[T:Manifest](name:String, idx:Exp[Int], value:Exp[T], rule:Rep[Int], bt:Exp[Array[Int]])(implicit pos: SourceContext) extends Def[Unit]
  case class In1Read[T:Manifest](idx:Exp[Int])(implicit pos: SourceContext) extends Def[T]
  case class In2Read[T:Manifest](idx:Exp[Int])(implicit pos: SourceContext) extends Def[T]

  case class BtNew(size:Int)(implicit pos: SourceContext) extends Def[Array[Int]]
  case class BtSet(dst:Exp[Array[Int]], idx:Int, value:Exp[Int]) extends Def[Unit]
  case class BtCopy(dst:Exp[Array[Int]], src:Exp[Array[Int]]) extends Def[Unit]

  case class NamedVal[T](name:String,value:Rep[T]) extends Def[Unit]

  def tab_idx(i:Rep[Int], j:Rep[Int])(implicit pos: SourceContext) = TabIdx(i,j)
  def tab_read[T](name:String, idx:Exp[Int])(mT:Manifest[T])(implicit pos: SourceContext) = reflectEffect(TabRead(name,idx))
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
    // XXX: store into single cell arrays instead of Array[List[...]]
    case TabIdx(i,j) => stream.println("val "+quote(sym)+" = "+quote(i)+" * size1 + "+quote(j)) // XXX: fix dimension
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

/*
trait CGenDP extends CGenEffect {
  val IR: DPExp
  import IR._
  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case TabIdx(i,j) => stream.println("val "+quote(sym)+" = idx("+quote(i)+","+quote(j)+");")
    case TabRead(name,idx) => stream.println("val "+quote(sym)+" = _cost."+name+"["+quote(idx)+"];")
    case TabWrite(name,idx,value,rule,bt) =>
      stream.println("_cost."+name+"["+quote(idx)+"] = "+quote(value)+";")
      stream.println("_back."+name+"["+quote(idx)+"].rule = "+quote(rule)+";")
      stream.println("_back."+name+"["+quote(idx)+"].pos = "+quote(bt)+";")
    case In1Read(i) => stream.println("val "+quote(sym)+" = _in1["+quote(i)+"];")
    case In2Read(i) => stream.println("val "+quote(sym)+" = _in2["+quote(i)+"];")
    case BtNew(size) => stream.println("val "+quote(sym)+" = new Array[Int]("+size+");")
    case BtSet(dst, idx, value) => stream.println(quote(dst)+"("+idx+") = "+quote(value)+";")
    case BtCopy(dst, src) => stream.println(quote(dst)+" = "+quote(src)+".clone();")
    case NamedVal(name,value) => stream.println("val n_"+name+" = "+quote(value)+";")
    case _ => super.emitNode(sym, rhs)
  }
}
*/