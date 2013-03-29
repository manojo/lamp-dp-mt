package v4.l3
import v4._
import lms._

import scala.virtualization.lms.common._

object Test extends Signature with LMSGenADP with App {
  // Matrix multiplication
  type Alphabet = (Int,Int)
  type Answer = (Int,Int,Int) // col
  val tps=(manifest[Alphabet],manifest[Answer])

  override val h = minBy(toFun{ (a:Rep[Answer]) => a._2  })
  val single = toFun{(a: Rep[Alphabet]) => (a._1, unit(0), a._2)} 
  val mult = toFun{p:Rep[(Answer,Answer)] => { val l=p._1; val r=p._2; (l._1, l._2 + r._2 + l._1 * l._3 * r._3, r._3) } }
  val axiom:Tabulate = tabulate("M",(el ^^ single | axiom ~ axiom ^^ mult) aggregate h)

  scala.Console.println(genLMS)
}

/*
BOILS DOWN TO CORRECT CODE (SIMPLIFIED):
class kernel extends ((Int, Int)=>(Unit)) {
  def apply(x0:Int, x1:Int): Unit = {
    var x2: Int = -1
    val x3 = new Array[Int](1);
    val x4 = new Array[Int](1);
    var x5: scala.Tuple3[Int, Int, Int] = null
    val x6 = x0 + 1
    val x7 = x6 == x1
    val x26 = if (x7) {
      val x8 = _in1[x0];
      if (x2 == -1 || 0 < x5._2) {
        x5 = (x8._1,0,x8._2)
        x2 = 0
        x3 = x4.clone();
      }
    }
    val x30 = x6
    var x38 : Int = x30
    while (x38 < x1) {
      x4(0) = x38;
      val x41 = _cost.M[idx(x0,x38)];
      val x43 = _cost.M[idx(x38,x1)];
      val x50 = x43._3
      val x45 = x41._1
      val x54 = x41._2 + x43._2 + x45 * x41._3 * x50
      if (x2 == -1 || x54 < x5._2) {
        x5 = (x45,x54,x50)
        x2 = 0
        x3 = x4.clone();
      }
      x38 = x38 + 1
    }
    val x73 = idx(x0,x1);
    _cost.M[x73] = x5;
    _back.M[x73].rule = x2;
    _back.M[x73].pos = x3;
  }
}
*/

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

  def tab_idx(i:Rep[Int], j:Rep[Int])(implicit pos: SourceContext) = TabIdx(i,j)
  def tab_read[T](name:String, idx:Exp[Int])(mT:Manifest[T])(implicit pos: SourceContext) = reflectEffect(TabRead(name,idx))
  def tab_write[T:Manifest](name:String, idx:Rep[Int], value:Rep[T], rule:Rep[Int], bt:Rep[Array[Int]])(implicit pos: SourceContext) = reflectEffect(TabWrite(name,idx,value,rule,bt))
  def in1_read[T](idx:Rep[Int])(mT:Manifest[T])(implicit pos: SourceContext) = reflectEffect(In1Read(idx))
  def in2_read[T](idx:Rep[Int])(mT:Manifest[T])(implicit pos: SourceContext) = reflectEffect(In2Read(idx))

  def bt_new(size:Int)(implicit pos: SourceContext) = reflectEffect(BtNew(size))
  def bt_set(dst:Rep[Array[Int]], idx:Int, value:Rep[Int])(implicit pos: SourceContext) = reflectEffect(BtSet(dst,idx,value))
  def bt_copy(dst:Rep[Array[Int]],src:Rep[Array[Int]])(implicit pos: SourceContext) = reflectEffect(BtCopy(dst,src))
}

trait ScalaGenDP extends ScalaGenEffect {
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
    case _ => super.emitNode(sym, rhs)
  }
}

// -----------------------------------------------------------------

trait LMSGenADP extends ADPParsers with LMSGen { self:Signature =>
  def in(idx:Rep[Int]):Rep[Alphabet] = in1_read(idx)(tps._1)
  def genTerminal[T](t:Terminal[T],i:Rep[Int],j:Rep[Int],cont:Rep[T]=>Rep[Unit]) = t match {
    case `empty` => if (i==j) cont(unit(()).asInstanceOf[Rep[T]])
    case `emptyi` => if (i==j) cont(i.asInstanceOf[Rep[T]])
    case `el` => if (i+1==j) cont(in(i).asInstanceOf[Rep[T]])
    case `eli` => if (i+1==j) cont(i.asInstanceOf[Rep[T]])
    // XXX: missing seq(min,max) => create a class and pattern match
    case _ => sys.error("Unsupported terminal")
  }
}

// -----------------------------------------------------------------

// XXX: missing two-tracks

// -----------------------------------------------------------------

trait LMSGen extends CodeGen with ScalaOpsPkgExp with GeneratorOpsExp with DPExp with BooleanOpsExp with CompileScala { self:Signature =>
  val codegen = new ScalaCodeGenPkg with ScalaGenGeneratorOps with ScalaGenDP { val IR:self.type = self }

  // Helper to wrap LMS function appropriately
  def toFun[T:Manifest,U:Manifest](f:Rep[T]=>Rep[U]) = new LFun(f)
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
  
  def genTerminal[T](t:Terminal[T],i:Rep[Int],j:Rep[Int],cont:Rep[T]=>Rep[Unit]) : Rep[Unit] // abstract

  def genTabLMS(t:Tabulate)(i0:Rep[Int],j0:Rep[Int]):Rep[Unit] = {
    val rule = var_new(unit(-1)) // best rule
    val bt = bt_new(t.inner.cat) // best backtrack
    val bt_tmp = bt_new(t.inner.cat) // temporary backtrack
    val tc = (value:Rep[Answer]) => _write(t,i0,j0,value,rule,bt) // tail continuation
    genParser(t.inner,tc,i0,j0,t.id,0)
    
    // Transform into delimited CPS
    def genParser[T](p0:Parser[T],cont:Rep[T]=>Rep[Unit],i:Rep[Int],j:Rep[Int],rid:Int,off:Int) : Rep[Unit] = p0 match { // rule id, backtrack index position
      case Aggregate(p,h) => 
        implicit val manifestForH:Manifest[T] = tps._2.asInstanceOf[Manifest[T]] // FIXME: not necessarily, but do we care ?
        var tmp = var_new(unit(null).asInstanceOf[Const[T]])
        genParser(p,{(res:Rep[T]) =>
          implicit val ord = new Ordering[T] { def compare(x:T,y:T): Int=0 } // FIXME: I love cheating
          def do_assign = {
            var_assign(tmp,res);
            var_assign(rule,unit(rid)); // XXX: fetch recursively instead !!
            scala.Console.println("RID="+rid); // must be passed by the terminal in the continuation
            bt_copy(bt,bt_tmp)
          }
          h.toString match {
            case "$$max$$" => if (rule==unit(-1) || res > tmp) do_assign
            case "$$min$$" => if (rule==unit(-1) || res < tmp) do_assign
            case "$$count$$" => var_plusequals(tmp,unit(1))
            case "$$sum$$" => var_plusequals(tmp,res)
            case "$$minBy$$" => (h.asInstanceOf[MinBy[Any,Any]].f) match {
              case l@LFun(f0) => val f=f0.asInstanceOf[Rep[T]=>Rep[T]] // FIXME: T=>Numeric[Any]
                if (rule==unit(-1) || f(res) < f(tmp)) do_assign
              case _ => sys.error("Non-LMS minBy")
            }
            case "$$maxBy$$" => (h.asInstanceOf[MinBy[Any,Any]].f) match {
              case l@LFun(f0) => val f=f0.asInstanceOf[Rep[T]=>Rep[T]] // FIXME: T=>Numeric[Any]
                if (rule==unit(-1) || f(res) > f(tmp)) do_assign
              case _ => sys.error("Non-LMS maxBy")
            }
            case _ => sys.error("Unsupported aggregation "+h.toString)
          }
        },i,j,rid,off)
        cont(tmp)
      case Or(l,r) => genParser(l,cont,i,j,rid,off); genParser(r,cont,i,j,rid+l.alt,off)
      case Filter(p,LFun(f)) => if (f((i,j))) genParser(p,cont,i,j,rid,off);
      case Map(p,m@LFun(f)) => genParser(p,{ (r:Rep[Any]) => cont(f(r)) },i,j,rid,off)
      case p:Tabulate => cont(_read(p,i,j))
      case t@Terminal(_,_,_) => genTerminal(t,i,j,cont)
      case cc@Concat(left,right,track) => val (lL,lU,rL,rU) = cc.indices
        def loop(kmin:Rep[Int],kmax:Rep[Int],f:Rep[Int]=>Rep[Unit]) = {
          range_foreach(range_until(kmin,kmax+unit(1)),(k:Rep[Int])=> { bt_set(bt_tmp,left.cat,k); f(k) })
        }
        def inner(li:Rep[Int],lj:Rep[Int],ri:Rep[Int],rj:Rep[Int]) = {
          genParser(left,(x:Rep[Any])=>{
            genParser(right,(y:Rep[Any])=>{
              cont(x,y)
            },ri,rj,rid,off+left.cat+(if (cc.hasBt) 1 else 0))
          },li,lj,rid,off)
        }
        if (track==0) loop(if (unit(rU==maxN) || i+unit(lL) > j-unit(rU)) i+unit(lL) else j-unit(rU),
                           if (unit(lU==maxN) || j-unit(rL) < i+unit(lU)) j-unit(rL) else i+unit(lU), k=>inner(i,k, k,j))
        else if (track==1) loop(if (unit(lU==maxN) || i-unit(lU) < unit(0)) unit(0) else i-unit(lU), i-unit(lL), k=>inner(k,i, k,j))
        else if (track==2) loop(if (unit(rU==maxN) || j-unit(rU) < unit(0)) unit(0) else j-unit(rU), j-unit(rL), k=>inner(i,k, k,j))
        else sys.error("Unimplemented track")
      case _ => sys.error("Bad parser")
    } 
  }

  def genLMS:String = {
    val buf = new java.io.ByteArrayOutputStream;
    val pr = new java.io.PrintWriter(buf)
    analyze
    rulesOrder.foreach{n=>codegen.emitSource2(genTabLMS(rules(n)) _, "kernel", pr) }
    buf.toString
  }
}
