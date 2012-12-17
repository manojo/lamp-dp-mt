package v4

import scala.util.parsing.combinator.syntactical.StandardTokenParsers

// Signature for C-generable functions
trait CFun {
  val body:String // C function body
  val args:List[(String,String)] // arguments as (name,Scala type)
  val tpe:String // result's Scala type (format as in 'type Foo = ...')
  override def hashCode = (body+args+tpe).hashCode
  override def equals(that:Any) = that match {
    case f:CFun => f.body==body && f.args==args && f.tpe==tpe
    case _ => false
  }
}

// -----------------------------------------------------------
// Helper to decode types uniquely and store functions
class CodeHeader(within:Any) {
  import scala.collection.mutable.HashMap
  val c_types = Map(("Boolean","bool"),("Byte","unsigned char"),("Char","char"),("Short","short"),("Int","int"),("Long","long"),
                    ("Float","float"),("Double","double"),("String","const char*"))

  // Struct name of a typed tuple
  def tupleStruct(tps:List[String]) = { "T"+tps.size+tps.map {n=>n match {
    case "bool"|"char"|"short"|"int"|"long"|"float"|"double" => n.substring(0,1)
    case "unsigned char" => "a" case "const char*" => "e" // primitives
    case _ => "_"+n.substring(n.lastIndexOf('.')+1).toLowerCase // custom class
  }}.mkString("")}

  // Converts Scala type into C type
  private object typeParser extends StandardTokenParsers {
    import lexical.{NumericLit,StringLit}
    lexical.reserved ++= c_types.keys.toList ++ List("scala")
    lexical.delimiters ++= List("(",")",",",".")
    private def p:Parser[String]=(opt("scala"~".")~>("Boolean"|"Byte"|"String"|"Char"|"Short"|"Int"|"Long"|"Float"|"Double") ^^ { c_types(_) }
      | "(" ~> repsep(p,",") <~ ")" ^^ { a=>tps.getOrElseUpdate(a.zipWithIndex.map{case(s,i)=>s+" _"+(i+1) }.mkString("; "),tupleStruct(a)) }
      | repsep(ident,".") ^^ { x=>tp_cls(x.mkString(".")) } | failure("Illegal type expression"))
    def parse(str:String):String = phrase(p)(new lexical.Scanner(str)) match { case Success(res, _)=>res case e=>sys.error(e.toString) }
  }

  // Converts a Scala value into its C representation
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

  // XXX: normalize the structures names instead of an incrementing counter => avoids interoperability problems
  // XXX: do we want to alias equivalent types/classes ? prepare a section '#define fancy_class_t tpXX' ahead of struct definition
  // XXX: do we want to get the subtypes of some elements ?
  // XXX: reverse lookup to get the correct type for one element ?
  // Values (ScalaExpr,CTypeName => CExpr,CTypeName)
  // def value(v:String,tp:String):(String,String) = {}

  // Structs and types management
  private var tpc=0;
  val tps=new HashMap[String,String](); // struct body -> name
  def getTypeC(tp:String,name:String):String = tps.getOrElseUpdate(tp,name)
  def getType(str:String):String = typeParser.parse(str)
  def getVal(str:String):String = valParser.parse(str)
  // def typeNamed(n:String):String = XXX: maintain revert hash map

  private val tp_ctx = within.getClass.getCanonicalName
  private def tp_cls(n:String):String = {
    val cls = Class.forName(tp_ctx+n.substring(n.lastIndexOf('.')+1))
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
  private val fns=new HashMap[CFun,String](); // function => name
  def add(f:CFun):String = {
    f.args.foreach { case (n,tp)=> getType(tp) }; getType(f.tpe)
    fns.getOrElseUpdate(f,{ val r=fnc; fnc=fnc+1; "fun"+r })
  }

  // Raw C code (put after all definitions)
  private var raw=""
  def add(str:String) { raw = raw + str + "\n" }
  def flush = {
    val res = tps.map{case (b,n) => "typedef struct __"+n+" "+n+";"}.mkString("\n") + "\n" +
              tps.map{case (b,n) => "struct __"+n+" { "+b+"; };"}.mkString("\n") + "\n" +
              fns.map{case (f,n) => "inline "+getType(f.tpe)+" "+n+"("+
                           f.args.map{case (n,tp)=>(getType(tp)+" "+n) }.mkString(", ")+") { "+f.body+" }" }.mkString("\n") + "\n" + raw
    tps.clear(); fns.clear(); tpc=0; fnc=0; raw=""; res
  }
}
