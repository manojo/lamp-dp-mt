import scala.util.parsing.combinator.syntactical.StandardTokenParsers

object CLangParser extends StandardTokenParsers {
  lexical.delimiters ++= List("(", ")",".",",","*","+",";")
  lexical.reserved ++= List("Int","Double","Float","Short","Long","Char","Boolean")
  import lexical.NumericLit
  import lexical.StringLit
  import scala.collection.mutable.HashMap

  // Types
  private var tid=0;
  private def tn(tp:String) = ts.getOrElseUpdate(tp,{ val r=tid; tid=tid+1; "tp"+r })
  val ts=new HashMap[String,String](); // struct body => name
  def tpe:Parser[String]=( "Boolean" ^^^ "bool"
    | ("Int"|"Double"|"Float"|"Short"|"Long"|"Char") ^^ { _.toLowerCase }
    | "(" ~> repsep(tpe,",") <~ ")" ^^ { a=>tn(a.zipWithIndex.map{case(s,i)=>s+" _"+(i+1) }.mkString("; ")) }
    | repsep(ident,".") ^^ { n=>n.last.toLowerCase+"_t" }
    | failure("illegal expression type")
  )
  def parseType(str:String):String = phrase(tpe)(new lexical.Scanner(str)) match {
    case Success(ccode, _) => ccode
    case e => sys.error(e.toString())
  }

  // Functions
  private var fid=0;
  private def fn(fun:(String,String,String)) = fs.getOrElseUpdate(fun,{ val r=fid; fid=fid+1; "fun"+r })
  val fs=new HashMap[(String,String,String),String](); // function (in,out,body) => name

  import scala.reflect.runtime.{universe => u}
  import scala.tools.reflect.ToolBox
  import scala.reflect.runtime.{currentMirror=>m}
  import u._

  def cc(tree:Tree):String = tree match {
    // see scala/reflect/internal/Trees.scala in scala-reflect-src
    case Apply(fun@Select(qual,name),args) => name.toString match {
      case "$times" => "("+cc(qual)+" * "+cc(args.head)+")"
      case "$plus" => "("+cc(qual)+" + "+cc(args.head)+")"
      case _ => "apply("+cc(fun)+","+args.map{x=>cc(x)}.mkString(",")+")"
    }
    case ValDef(_,name,tp,rhs) => parseType(tp.toString)+" "+name.toString+" = "+cc(rhs)+"; "
    case Literal(Constant(x)) => x.toString

    // case Apply(fun,args) => "apply("+cc(fun)+","+args.map{x=>cc(x)}.mkString(",")+")"
    case Select(qual,name) => cc(qual)+"."+name

    case Ident(name) => name.toString
    // Ident(newTermName("_arg"))
    //case _ => "unknown "+tree.getClass
    case _ => u.showRaw(tree)
  }

  def fun(in:String, out:String, body:String):String = {
    // Re-eval (to be done within macro BUT NOT the type transformation, so that we can keep track of multiple structs)
    val tb = m.mkToolBox()
    val b:String = tb.parse("def apply(_arg:"+in+"):"+out+" = { "+body+" }") match {
      case DefDef(_,_,_,_,_,rhs) => rhs match {
        case Block(stats, expr) => stats.map{x=>cc(x)}.mkString(";\n")+"res="+cc(expr)
        case _ => "res="+cc(rhs)
      }
      case _ => sys.error("Parsing error")
    }
    fn((parseType(in),parseType(out),b))
  }

  def headers = {
    ts.map{case (b,n) => "typedef struct __"+n+" "+n+";"}.mkString("\n") + "\n" +
    ts.map{case (b,n) => "struct __"+n+" { "+b+"; }"}.mkString("\n") + "\n\n" +
    fs.map{case ((i,o,b),n) => o+" "+n+"("+i+" _arg) { "+o+" _res; "+b+"; return res; }" }.mkString("\n")
  }
}

object Stringy extends App {
  println("Assuming mat_t { int rows; int cols; }")
  println(CLangParser.fun("TestMacros.Mat","Int","val x:Int=3; x*_arg.rows.*(_arg.cols)"));

  println(CLangParser.fun("(Int, (Int, Int))","Int","_arg._1.*(_arg._2._1).+(_arg._2._2)"));

  //println("Apply("+CLangParser.fun("TestMacros.Mat","Int","_arg.rows.*(_arg.cols)")+")");
  //println("Apply("+CLangParser.fun("(Int, (Int, Int))","Int","_arg._1.*(_arg._2._1).+(_arg._2._2)")+")");

  println(CLangParser.headers);

}
