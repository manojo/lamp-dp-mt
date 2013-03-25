package v4.l3
import v4._
import lms._

import scala.virtualization.lms.common._

object Test extends Signature with ADPParsers with LMSGen with App {
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
}

trait DPExp extends DPOps with EffectExp {
  case class TabIdx(i:Exp[Int], j:Exp[Int])(implicit pos: SourceContext) extends Def[Int]
  case class TabRead[T:Manifest](name:String, idx:Exp[Int])(implicit pos: SourceContext) extends Def[T]
  case class TabWrite[T:Manifest](name:String, idx:Exp[Int], value:Exp[T], rule:Rep[Int], bt:Exp[Array[Int]])(implicit pos: SourceContext) extends Def[Unit]
  case class In1Read[T:Manifest](idx:Exp[Int])(implicit pos: SourceContext) extends Def[T]
  case class In2Read[T:Manifest](idx:Exp[Int])(implicit pos: SourceContext) extends Def[T]

  case class BtNew(size:Int)(implicit pos: SourceContext) extends Def[Array[Int]]
  case class BtSet(dst:Exp[Array[Int]], idx:Int, value:Exp[Int]) extends Def[Unit]

  def tab_idx(i:Rep[Int], j:Rep[Int])(implicit pos: SourceContext) = TabIdx(i,j)
  def tab_read[T](name:String, idx:Exp[Int])(mT:Manifest[T])(implicit pos: SourceContext) = reflectEffect(TabRead(name,idx))
  def tab_write[T:Manifest](name:String, idx:Rep[Int], value:Rep[T], rule:Rep[Int], bt:Rep[Array[Int]])(implicit pos: SourceContext) = reflectEffect(TabWrite(name,idx,value,rule,bt))
  def in1_read[T](idx:Rep[Int])(mT:Manifest[T])(implicit pos: SourceContext) = reflectEffect(In1Read(idx))
  def in2_read[T](idx:Rep[Int])(mT:Manifest[T])(implicit pos: SourceContext) = reflectEffect(In2Read(idx))

  def bt_new(size:Int)(implicit pos: SourceContext) = reflectEffect(BtNew(size))
  def bt_set(dst:Rep[Array[Int]], idx:Int, value:Rep[Int])(implicit pos: SourceContext) = reflectEffect(BtSet(dst,idx,value))
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
    case _ => super.emitNode(sym, rhs)
  }
}

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
    case _ => super.emitNode(sym, rhs)
  }
}


// -----------------------------------------------------------------

trait LMSGen extends CodeGen with ScalaOpsPkgExp with GeneratorOpsExp with DPExp with BooleanOpsExp with CompileScala { self:Signature =>
  val codegen = new ScalaCodeGenPkg with ScalaGenGeneratorOps with ScalaGenDP { val IR:self.type = self }

  def toFun[T:Manifest,U:Manifest](f:Rep[T]=>Rep[U]) = new LFun(f)
  case class LFun[T:Manifest,U:Manifest](f:Rep[T]=>Rep[U]) extends Function1[T,U] { lazy val fs = self.compile(f); def apply(arg:T) = fs(arg) }

  // Helpers to set manifest appropriately
  private def _in1(idx:Rep[Int]):Rep[Alphabet] = in1_read(idx)(tps._1)
  private def _in2(idx:Rep[Int]):Rep[Alphabet] = in2_read(idx)(tps._1)
  private def _read(t:Tabulate,i:Rep[Int],j:Rep[Int]) = tab_read(t.name,tab_idx(i,j))(tps._2)
  private def _write(t:Tabulate,i:Rep[Int],j:Rep[Int],value:Rep[Answer],rule:Rep[Int],bt:Rep[Array[Int]]) = { implicit val manifestForAnswer=tps._2; tab_write(t.name,tab_idx(i,j),value,rule,bt) }
  
  def genTabLMS(t:Tabulate)(i:Rep[Int],j:Rep[Int]):Rep[Unit] = {
    var rule = var_new(unit(-1)) // best rule
    var bt = bt_new(t.inner.cat) // best backtrack
    var bt_tmp = bt_new(t.inner.cat) // temporary backtrack
    val tc = (value:Rep[Answer]) => _write(t,i,j,value,rule,bt) // tail continuation
    
    // Transform into generators/CPS
    def genParser[T](p0:Parser[T],cont:Rep[T]=>Rep[Unit],rid:Int,off:Int) : Rep[Unit] = p0 match { // rule id, backtrack index position
/*
      case Aggregate(p,h) => 
        implicit val manifestForH = tps._2
        var tmp = unit(null).asInstanceOf[Rep[T]]
        genParser(p,{(res:Rep[T]) =>
          h.toString match {
            case "$$max$$" => if (/*boolean_or(*/ rule==unit(-1) /*,r > tmp)*/) { tmp=res; rule=rid; }
            case "$$min$$" => if (/*boolean_or(*/ rule==unit(-1) /*,r < tmp)*/) { tmp=res; rule=rid; }
            case _ => sys.error("Unsupported LMS aggregation")
          }
        },rid,off)
        cont(tmp)
      /*
      case t:Terminal =>
      case p:Tabulate =>
      case Or(l,r) => 
      case Filter(p,f) => 
      case cc@Concat(l,r,tt) =>
      */
      case Or(l,r) => genParser(l,cont,rid,off); genParser(r,cont,rid+l.alt,off)
      case Map(p,LFun(f)) => genParser(l,{(r:Rep[U]) => cont(f(r)) } )
*/
      case _ =>
        //sys.error("Does not match")
        val value = _read(t,i,j)
        rule = unit(0)
        bt_set(bt,0,rule)
        cont(value)
    } 
    genParser(t.inner,(value:Rep[Answer]) => _write(t,i,j,value,rule,bt),t.id,0)
  }

  def genLMS:String = {
    val buf = new java.io.ByteArrayOutputStream;
    val pr = new java.io.PrintWriter(buf)
    analyze
    rulesOrder.foreach{n=>codegen.emitSource2(genTabLMS(rules(n)) _, "kernel", pr) }
    buf.toString
  }
}
