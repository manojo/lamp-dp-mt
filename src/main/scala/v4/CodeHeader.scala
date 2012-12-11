package v4

import scala.util.parsing.combinator.syntactical.StandardTokenParsers

// Signature for C-generable functions
trait CFun {
  val name:String // Scala name
  val tpIn:String // Scala type (as you would write in 'type Foo = ...')
  val tpOut:String // Scala type
  val body:String // C code 'int x=33; _res=x'
  // val tps:Map[String,String] // additional types used in the body: name->type
}

// Helper to decode types uniquely and store functions
class CHeader(within:Any) extends StandardTokenParsers {
  import scala.collection.mutable.HashMap
  import lexical.{NumericLit,StringLit}
  val c_types = Map(("Boolean","bool"),("Byte","unsigned char"),("Char","char"),("Short","short"),("Int","int"),("Long","long"),
                    ("Float","float"),("Double","double"),("String","const char*"))
  lexical.reserved ++= c_types.keys.toList
  lexical.delimiters ++= List("(", ")",",",".")

  // Structs and types management
  private var tpc=0;
  private val tps=new HashMap[String,String](); // struct body -> name
  private def tpn(tp:String) = tps.getOrElseUpdate(tp,{ val r=tpc; tpc=tpc+1; "tp"+r })
  private def tpp:Parser[String]=( ("Boolean"|"Byte"|"String"|"Char"|"Short"|"Int"|"Long"|"Float"|"Double") ^^ { c_types(_) }
    | "(" ~> repsep(tpp,",") <~ ")" ^^ { a=>tpn(a.zipWithIndex.map{case(s,i)=>s+" _"+(i+1) }.mkString("; ")) }
    | repsep(ident,".") ^^ { x=>tp_cls(x.mkString(".")) } | failure("Illegal type expression"))

  def tpParse(str:String):String = phrase(tpp)(new lexical.Scanner(str)) match { case Success(ccode, _) => ccode case e => sys.error(e.toString) }

  private val tp_ctx = within.getClass.getCanonicalName
  private def tp_cls(n:String):String = {
    val cls = Class.forName(tp_ctx+n)
    // try mutliple attempt to find that class: absolute class
    // within.getDeclaredClasses(), getDeclaringClass, getEnclosingClass, getSuperclass
    val td = cls.getDeclaredFields.map{x=>(x.getType.toString,x.getName)}
    val tp = td.map{case (t,n)=>c_types(t.substring(0,1).toUpperCase+t.substring(1))+" "+n}.mkString("; ")
    tps.getOrElseUpdate(tp, n.substring(n.lastIndexOf('.')+1).toLowerCase+"_t")
  }

  // Functions
  private var fid=0;
  val fs=new HashMap[(String,String,String),String](); // function (in,out,body) => name
  def add(f:CFun):String = {
    val in = tpParse(f.tpIn); val out=tpParse(f.tpOut); val fun=(in,out,f.body)
    fs.getOrElseUpdate(fun,{ val r=fid; fid=fid+1; "fun"+r })
  }

  def code = {
    val res = tps.map{case (b,n) => "typedef struct __"+n+" "+n+";"}.mkString("\n") + "\n" +
              tps.map{case (b,n) => "struct __"+n+" { "+b+"; };"}.mkString("\n") + "\n\n" +
              fs.map{case ((i,o,b),n) => "inline "+o+" "+n+"("+i+" _arg) { "+o+" _res; "+b+"; return _res; }" }.mkString("\n") + "\n"
    tps.clear(); tpc=0; res
  }
}

object CodeHeaderTest extends App {
  val h=new CHeader(this)
  case class Mat(rows:Int, cols:Int)

  val foo = new CFun{ // tree{ (x:Mat) => Mat(x.cols,x.rows) }
    val name="foo"
    val tpIn="Mat"
    val tpOut="Mat"
    val body="_res=(mat_t){_arg.cols,_arg.rows}"
  }
  val foo2 = new CFun { //(x:(Int,(Int,Int))) => x._1 * x._2._1 + x._2._2
    val name="foo2"
    val tpIn="(Int,(Int,Int))"
    val tpOut="Int"
    val body="_res=_arg._1 * _arg._2._1 + _arg._2._2"
  }

  println(h.add(foo))
  println(h.add(foo2))
  println(h.code)
}

