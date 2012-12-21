package lms

import scala.virtualization.lms.common._
import scala.reflect.RefinedManifest

trait CLikeGenTupleOps extends CLikeGenBase{
  val IR: TupleOpsExp
  import IR._

  private val encounteredTuples = collection.mutable.HashMap.empty[String, Def[Any]]
  private def registerType[A](m: Manifest[A], rhs: Def[Any]) {
    val name = tupleClassName(m)
    encounteredTuples += name -> rhs
    //emitValDef(sym, "("+tupleClassName(sym.tp)+")"+ remap(e2.m1) + " t1 = " + quote(a) + ";" + remap(e2.m2) + " t2 = " + quote(b) + "}")
  }

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case e2@ETuple2(a,b) =>
      registerType(sym.tp,rhs)
      emitValDef(sym, "("+tupleClassName(sym.tp)+"){"+ quote(a) + "," + quote(b) + "}")
    case Tuple2Access1(t) => emitValDef(sym, quote(t) + ".t1")
    case Tuple2Access2(t) => emitValDef(sym, quote(t) + ".t2")

    case e3@ETuple3(a,b,c) =>
      registerType(sym.tp,rhs)
      emitValDef(sym, "("+tupleClassName(sym.tp)+"){" + quote(a) + "," +quote(b) + "," + quote(c) + "}")
    case Tuple3Access1(t) => emitValDef(sym, quote(t) + ".t1")
    case Tuple3Access2(t) => emitValDef(sym, quote(t) + ".t2")
    case Tuple3Access3(t) => emitValDef(sym, quote(t) + ".t3")

    case e4@ETuple4(a,b,c,d) =>
      registerType(sym.tp,rhs)
      emitValDef(sym, "("+tupleClassName(sym.tp)+"){"+ quote(a) + "," + quote(b) + "," + quote(c) + "," + quote(d) + "}")
    case Tuple4Access1(t) => emitValDef(sym, quote(t) + ".t1")
    case Tuple4Access2(t) => emitValDef(sym, quote(t) + ".t2")
    case Tuple4Access3(t) => emitValDef(sym, quote(t) + ".t3")
    case Tuple4Access4(t) => emitValDef(sym, quote(t) + ".t4")

    case e5@ETuple5(a,b,c,d,e) =>
      registerType(sym.tp,rhs)
      emitValDef(sym, "("+tupleClassName(sym.tp)+"){"+ quote(a) + "," + quote(b) + "," + quote(c) + "," + quote(d) + ","
                         + quote(e) + "}")
    case Tuple5Access1(t) => emitValDef(sym, quote(t) + ".t1")
    case Tuple5Access2(t) => emitValDef(sym, quote(t) + ".t2")
    case Tuple5Access3(t) => emitValDef(sym, quote(t) + ".t3")
    case Tuple5Access4(t) => emitValDef(sym, quote(t) + ".t4")
    case Tuple5Access5(t) => emitValDef(sym, quote(t) + ".t5")

    case _ => super.emitNode(sym, rhs)
  }

  //code borrowed from lms.Functions.scala
  def unwrapTupleStr(s: String): Array[String] = {
    if (s.startsWith("scala.Tuple")) s.slice(s.indexOf("[")+1,s.length-1).filter(c => c != ' ').split(",")
    else Array(s)
  }

  override def remap[A](m: Manifest[A]): String = m.toString match {
    case f if f.startsWith("scala.Tuple") =>
      tupleClassName(m)
    case _ => super.remap(m)
  }

  // not public because should not be called with a manifest not describing a subtype of Manifest[Record]
  protected def tupleClassName[A](m: Manifest[A]): String = m.toString match {
    case f if f.startsWith("scala.Tuple") =>
      val targs = m.typeArguments
      val res = remap(m.typeArguments.last)
      val targsUnboxed = targs.flatMap(t => unwrapTupleStr(remap(t)))
      "T" + targsUnboxed.map{_(0)}.mkString //+ "[" + targsUnboxed.mkString(",") + sep + res + "]"

    case _ => super.remap(m)
  }

  import java.io.PrintWriter
  def emitDataStructures(out: PrintWriter) {
    withStream(out) {
      for ((name, tuple) <- encounteredTuples) {
        stream.println{ tuple match {
          case e2@ETuple2(a,b) =>
            "struct "+name+"{"+ remap(e2.m1) + " t1; " + remap(e2.m2) + " t2 }"
          case e3@ETuple3(a,b,c) =>
            "struct "+name+"{"+ remap(e3.m1) + " t1; " + remap(e3.m2) + " t2; "+ remap(e3.m3) +" t3 }"
          case e4@ETuple4(a,b,c,d) =>
            "struct "+name+"{"+ remap(e4.m1) + " t1; " + remap(e4.m2) + " t2; "+ remap(e4.m3) +" t3; " + remap(e4.m4) +" t4 }"
          case e5@ETuple5(a,b,c,d,e) =>
            "struct "+name+"{"+ remap(e5.m1) + " t1; " + remap(e5.m2) + " t2; "+ remap(e5.m3) +" t3; " + remap(e5.m4) +" t4; " + remap(e5.m5) +" t5 }"
        }
        }
//        stream.println("case class " + name + "(" + (for ((n, e) <- fields) yield n + ": " + remap(e.tp)).mkString(", ") + ")")
      }
    }
  }

}