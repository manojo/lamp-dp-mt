package lms

import scala.virtualization.lms.common._

trait CLikeGenTupleOps extends CLikeGenBase{
  val IR: TupleOpsExp
  import IR._

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case e2@ETuple2(a,b) =>
      emitValDef(sym, "T2{"+ remap(e2.m1) + " t1 = " + quote(a) + ";" + remap(e2.m2) + " t2 = " + quote(b) + "}")
    case Tuple2Access1(t) => emitValDef(sym, quote(t) + ".t1")
    case Tuple2Access2(t) => emitValDef(sym, quote(t) + ".t2")

    case e3@ETuple3(a,b,c) =>
      emitValDef(sym, "T3{"+ remap(e3.m1) + " t1 = " + quote(a) + ";" + remap(e3.m2) + " t2 = " + quote(b) + ";" + remap(e3.m3) + " t3 = " + quote(c) + "}")
      emitValDef(sym, "("+ quote(a) + "," + quote(b) + "," + quote(c) + ")")
    case Tuple3Access1(t) => emitValDef(sym, quote(t) + ".t1")
    case Tuple3Access2(t) => emitValDef(sym, quote(t) + ".t2")
    case Tuple3Access3(t) => emitValDef(sym, quote(t) + ".t3")

    case e4@ETuple4(a,b,c,d) =>
      emitValDef(sym, "T4{"+ remap(e4.m1) + " t1 = " + quote(a) + ";" + remap(e4.m2) + " t2 = " + quote(b) + ";"
                           + remap(e4.m3) + " t3 = " + quote(c) + ";" + remap(e4.m4) + " t4 = " + quote(d) + "}")
    case Tuple4Access1(t) => emitValDef(sym, quote(t) + ".t1")
    case Tuple4Access2(t) => emitValDef(sym, quote(t) + ".t2")
    case Tuple4Access3(t) => emitValDef(sym, quote(t) + ".t3")
    case Tuple4Access4(t) => emitValDef(sym, quote(t) + ".t4")

    case e5@ETuple5(a,b,c,d,e) =>
    emitValDef(sym, "T5{"+ remap(e5.m1) + " t1 = " + quote(a) + ";" + remap(e5.m2) + " t2 = " + quote(b) + ";"
                         + remap(e5.m3) + " t3 = " + quote(c) + ";" + remap(e5.m4) + " t4 = " + quote(d) + ";"
                         + remap(e5.m5) + " t5 = " + quote(e) + "}")
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
      val targs = m.typeArguments//.dropRight(1)
      val res = remap(m.typeArguments.last)
      val targsUnboxed = targs.flatMap(t => unwrapTupleStr(remap(t)))
      val sep = if (targsUnboxed.length > 0) "," else ""
      "T" + (targsUnboxed.length) //+ "[" + targsUnboxed.mkString(",") + sep + res + "]"

    case _ => super.remap(m)
  }

}