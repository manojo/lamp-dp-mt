package v4

import scala.util.parsing.combinator.syntactical.StandardTokenParsers

// Signature for C-generable functions
trait CodeFun {
  val tpIn:String // Scala type (as you would write in 'type Foo = ...')
  val tpOut:String // Scala type
  val body:String // C code 'int x=33; _res=x'
  // val tps:Map[String,String] // additional types used in the body: name->type
}

// Helper to decode types uniquely and store functions
class CodeHeader(within:Any) {
  import scala.collection.mutable.HashMap
  val c_types = Map(("Boolean","bool"),("Byte","unsigned char"),("Char","char"),("Short","short"),("Int","int"),("Long","long"),
                    ("Float","float"),("Double","double"),("String","const char*"))

  private object typeParser extends StandardTokenParsers {
    import lexical.{NumericLit,StringLit}
    lexical.reserved ++= c_types.keys.toList
    lexical.delimiters ++= List("(",")",",",".")
    private def p:Parser[String]=( ("Boolean"|"Byte"|"String"|"Char"|"Short"|"Int"|"Long"|"Float"|"Double") ^^ { c_types(_) }
      | "(" ~> repsep(p,",") <~ ")" ^^ { a=>tpn(a.zipWithIndex.map{case(s,i)=>s+" _"+(i+1) }.mkString("; ")) }
      | repsep(ident,".") ^^ { x=>tp_cls(x.mkString(".")) } | failure("Illegal type expression"))
    def parse(str:String):String = phrase(p)(new lexical.Scanner(str)) match { case Success(res, _)=>res case e=>sys.error(e.toString) }
  }

  private object valParser extends StandardTokenParsers {
    import lexical.{NumericLit,StringLit}
    lexical.reserved ++= c_types.keys.toList ++ List("e","E")
    lexical.delimiters ++= List("(",")",",","-",".")
    private def pr[T](o:Option[T]) = o match { case Some(v)=>v.toString case None => "" }
    private def num:Parser[String] = opt("-") ~
      ( opt(numericLit)~("."~>numericLit)^^{case o~d=>pr(o)+"."+d} | numericLit ) ~
      opt( ("e"|"E")~>(opt("-")~numericLit)^^{case o~d=> "e"+pr(o)+d} ) ^^ { case s~m~e => pr(s)+m+pr(e) }
    private def p:Parser[String] = (num ^^ { n=>n.toString }
      | "(" ~> repsep(p,",") <~ ")" ^^ { a=>"{"+a.mkString(",")+"}" }
      | repsep(ident,".") ^^ { x=> "("+x.mkString(".")+")" } | failure("Illegal type expression"))
    def parse(str:String):String = phrase(p)(new lexical.Scanner(str)) match { case Success(res, _)=>res case e=>sys.error(e.toString) }
  }

  // XXX: do we want to alias equivalent types/classes ? prepare a section '#define fancy_class_t tpXX' ahead of struct definition
  // XXX: do we want to get the subtypes of some elements ?
  // XXX: reverse lookup to get the correct type for one element ?
  // Values (ScalaExpr,CTypeName => CExpr,CTypeName)
  // def value(v:String,tp:String):(String,String) = {}

  // Structs and types management
  private var tpc=0;
  private val tps=new HashMap[String,String](); // struct body -> name
  private def tpn(tp:String) = tps.getOrElseUpdate(tp,{ val r=tpc; tpc=tpc+1; "tp"+r })
  def addType(str:String):String = typeParser.parse(str)
  def getVal(str:String):String = valParser.parse(str)
  // def typeNamed(n:String):String = XXX: maintain revert hash map

  private val tp_ctx = within.getClass.getCanonicalName
  private def tp_cls(n:String):String = {
    val cls = Class.forName(tp_ctx+n)
    // try mutliple attempt to find that class: absolute class
    // within.getDeclaredClasses(), getDeclaringClass, getEnclosingClass, getSuperclass
    val td = cls.getDeclaredFields.map{x=>(x.getType.toString,x.getName)}
    val tp = td.map{case (t,n)=>c_types(t.substring(0,1).toUpperCase+t.substring(1))+" "+n}.mkString("; ")
    tps.getOrElseUpdate(tp, n.substring(n.lastIndexOf('.')+1).toLowerCase+"_t")
  }

  // Scala Type of an composite Tuple/case classes/primary types
  def tpOf[T](a:T):String = {
    val s=a.getClass.toString;
    if (a.isInstanceOf[Product]) { val p=a.asInstanceOf[Product]; "("+(0 until p.productArity).map{x=>tpOf(p.productElement(x))}.mkString(",")+")" }
    else s match {
      case "boolean"|"byte"|"char"|"short"|"int"|"long"|"float"|"double" => s.substring(0,1).toUpperCase+s.substring(1,s.length)
      case _ if (s.startsWith("class java.lang.")) => s.substring(16) match { case "Character"=>"Char" case "Integer"=>"Int" case t=>t }
      case _ => s.substring(6) // seems that case classes extend Product, enforce that?
    }
  }

  // Functions
  private var fnc=0;
  private val fns=new HashMap[(String,String,String),String](); // function (in,out,body) => name
  def add(f:CodeFun):String = {
    val in = addType(f.tpIn); val out=addType(f.tpOut); val fun=(in,out,f.body)
    fns.getOrElseUpdate(fun,{ val r=fnc; fnc=fnc+1; "fun"+r })
  }

  // Raw C code (put after all definitions)
  private var raw=""
  def add(str:String) { raw = raw + str + "\n" }
  def flush = {
    val res = tps.map{case (b,n) => "typedef struct __"+n+" "+n+";"}.mkString("\n") + "\n" +
              tps.map{case (b,n) => "struct __"+n+" { "+b+"; };"}.mkString("\n") + "\n" +
              fns.map{case ((i,o,b),n) => "inline "+o+" "+n+"("+i+" _arg) { "+o+" _res; "+b+"; return _res; }" }.mkString("\n") + "\n" + raw
    tps.clear(); fns.clear(); tpc=0; fnc=0; raw=""; res
  }
}
