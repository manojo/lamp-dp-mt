import scala.util.parsing.combinator.syntactical.StandardTokenParsers

object CLangParser extends StandardTokenParsers {
  lexical.delimiters ++= List("(", ")",".",",","*","+",";")
  lexical.reserved ++= List("Int","Double","Float","Short","Long","Char","Boolean","String")
  import lexical.NumericLit
  import lexical.StringLit
  import scala.collection.mutable.HashMap

  // Types
  private var tid=0;
  private def tn(tp:String) = ts.getOrElseUpdate(tp,{ val r=tid; tid=tid+1; "tp"+r })
  val ts=new HashMap[String,String](); // struct body => name
  def tpe:Parser[String]=( "Boolean" ^^^ "bool" | "String" ^^^ "const char*"
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

  val base_ops= HashMap[String,String](
    ("$times","*"),("$plus","+"),("$minus","-"),("$div","/"),("$percent","%"),
    ("$greater",">"),("$greater$eq",">="),("$less","<"),("$less$eq","<="),
    ("$eq$eq","=="),("$amp$amp","&&"),("$bar$bar","||")
  );

  // XXX: need to pass back a type to cast properly the tuple into corresponding struct
  def cc(tree:Tree):String = tree match {
    // see scala/reflect/internal/Trees.scala in scala-reflect-src
    case Apply(fun@Select(qual,name),args) => base_ops.get(name.toString) match {
      case Some(op) => "("+cc(qual)+" "+op+" "+cc(args.head)+")"
      case None => val f=cc(fun);
        // XXX: continue this
        if (f.startsWith("scala.Tuple")) "(tuple??){"+args.map{x=>cc(x)}.mkString(",")+"}"
        // XXX: ditto if we match a custom class as well.
        else f+"("+args.map{x=>cc(x)}.mkString(",")+")"
    }
    case ValDef(_,name,tp,rhs) => parseType(tp.toString)+" "+name.toString+" = "+cc(rhs)+"; "
    case Literal(Constant(x)) =>
      if (x.isInstanceOf[Char]) "'"+x.toString+"'"
      else if (x.isInstanceOf[String]) "\""+x.toString.replace("\"","\\\"")+"\""
      else x.toString
    case Select(This(_),name) => name.toString
    case Select(qual,name) => cc(qual)+"."+name
    case If(cond,thenp,elsep) => "(("+cc(cond)+")?("+cc(thenp)+"):("+cc(elsep)+"))"

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
        case Block(stats, expr) => stats.map{x=>cc(x)+"; "}.mkString("")+"res="+cc(expr)
        case _ => "res="+cc(rhs)
      }
      case _ => sys.error("Parsing error")
    }
    fn((parseType(in),parseType(out),b))
  }

  def headers = {
    val res = ts.map{case (b,n) => "typedef struct __"+n+" "+n+";"}.mkString("\n") + "\n" +
              ts.map{case (b,n) => "struct __"+n+" { "+b+"; }"}.mkString("\n") + "\n\n" +
              fs.map{case ((i,o,b),n) => o+" "+n+"("+i+" _arg) { "+o+" _res; "+b+"; return res; }" }.mkString("\n") + "\n"
    ts.clear(); fs.clear(); res
  }
}

object Stringy extends App {
  // Assuming mat_t { int rows; int cols; }
  CLangParser.fun("TestMacros.Mat","Int","val x:Int=3; x*_arg.rows.*(_arg.cols)")
  CLangParser.fun("(Int, (Int, Int))","Int","_arg._1.*(_arg._2._1).+(_arg._2._2)")
  println(CLangParser.headers)
  println("------------------------------------------------------")

  // Brackets
  CLangParser.fun("(Int, Int)","Boolean","_arg._2.>(_arg._1.+(1)).&&(TestMacros.this.in(_arg._1).==('(')).&&(TestMacros.this.in(_arg._2.-(1)).==(')'))")
  CLangParser.fun("(Char, (Int, Char))","Int","_arg._2._1")
  CLangParser.fun("(Int, Int)","Int","val z:String=\"foo\"; if (true) false else true; _arg._1.+(_arg._2)")
  CLangParser.fun("(Int, Int)","Int","if (_arg._1>_arg._2 || _arg._1<_arg._2 || _arg._1>=_arg._2 || _arg._1<=_arg._2 ) (3, 2) else (2, 3)")
  println(CLangParser.headers);
  println("------------------------------------------------------")

  //println("Apply("+CLangParser.fun("TestMacros.Mat","Int","_arg.rows.*(_arg.cols)")+")");
  //println("Apply("+CLangParser.fun("(Int, (Int, Int))","Int","_arg._1.*(_arg._2._1).+(_arg._2._2)")+")");


}
