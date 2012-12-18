package v4

trait CodeGen extends BaseParsers { this:Signature =>
  private val head = new CodeHeader(this) // User code and helpers store
  private var order:List[String]=Nil // Order of parsers evaluation

  // Dependency analysis: computation order between tabulations
  def tabsOrder:List[String] = {
    def deps[T](q:Parser[T]): List[String] = q match {
      case Aggregate(p,_) => deps(p) case Filter(p,_) => deps(p) case Map(p,_) => deps(p) case Or(l,r) => deps(l)++deps(r)
      case cc@Concat(l,r,_) => val(lm,_,rm,_)=cc.indices; (if (lm==0) deps(r) else Nil) ::: (if (rm==0) deps(l) else Nil)
      case _ => if (q.isInstanceOf[Tabulate]) List(q.asInstanceOf[Tabulate].name) else Nil
    }
    var order = List[String]()
    val cs = rules.map{case (n,p)=>(n,deps(p.inner)) }
    while (!cs.isEmpty) { var rem=false;
      cs.foreach { case (n,ds) if (ds.isEmpty||(true/:ds.map{d=>order.contains(d)}){case(a,b)=>a&&b}) => rem=true; order=n::order; cs.remove(n); case _ => }
      if (rem==false) sys.error("Loop between tabulations, error in grammar")
    }
    order.reverse
  }

  // Cost matrix : cost_t = parser_name -> cost
  // Backtracking: back_t = parser_name -> (rule, positions)
  def btTpe(n:Int) = head.getTypeC("short rule"+(if(n>0)"; short pos["+n+"]"else""),"bt"+n)
  override def analyze:Boolean = { if (!super.analyze) return false; order=tabsOrder;
    head.add("#define TI "+tpAlphabet)
    head.add("typedef struct { "+order.map{n=>tpAnswer+" "+n+";"}.mkString(" ")+" } cost_t;\n#define TC cost_t")
    head.add("typedef struct { "+order.map{n=>val c=rules(n).inner.cat; btTpe(c)+" "+n+";"}.mkString(" ")+" } back_t;\n#define TB back_t")
    true
  }

  // Typing informations
  import scala.reflect.runtime.universe.TypeTag
  val tags:(TypeTag[Alphabet],TypeTag[Answer]) = (null,null)
  lazy val tpAlphabet = head.getType(tags._1.tpe.toString)
  lazy val tpAnswer = head.getType(tags._2.tpe.toString)

  // Normalize the parsers towards code generation
  // Canonical : [Tabulate] > Aggregate > Or > Filter > Map > Concat > (Tabulate | Terminal)
  // C code    : [Tabulate] > Or > ForLoop+Filter > Aggregate1 > Map > (Tabulate | Terminal)
  // Invariant : Aggregate > Map > Concat (due to domain change)
  def norm[T](parser:Parser[T]):Parser[T] = parser match {
    case Or(l,r) => Or(norm(l),norm(r))
    case Filter(p0,c) => norm(p0) match {
      case Or(l,r) => Or(norm(Filter(l,c)),norm(Filter(r,c)))
      case p => Filter(p,c)
    }
    case Aggregate(p0,h) => norm(p0) match {
      case Filter(p,f) => Filter(norm(Aggregate(p,h)),f)
      case Or(l,r) => Or(norm(Aggregate(l,h)),norm(Aggregate(r,h)))
      case p => Aggregate(p,h)
    }
    case Map(p0,f) => norm(p0) match {
      case Filter(p,c) => Filter(norm(Map(p,f)),c)
      case Or(l,r) => Or(norm(Map(l,f)),norm(Map(r,f)))
      case p => Map(p,f)
    }
    case cc@Concat(l0,r0,t) => // Preserves alternatives numbering and correct min/max indices
      def c[T,U](l:Parser[T],r:Parser[U]) = new Concat(l,r,t){override lazy val indices=cc.indices}
      (norm(l0),norm(r0)) match {
        case (Or(a,b),r) => Or(norm(c(a,r)),norm(c(b,r)))
        case (l,Or(a,b)) => Or(norm(c(l,a)),norm(c(l,b)))
        case (l,r) => c(l,r)
      }
    case _ => parser
  }

  // A simple variable generator that sequentially issues free variables
  class FreeVar(v0:Char) {
    private var v=v0
    def get = { var r=v; v=(v+1).toChar; Var(r,0) }
    def dup = new FreeVar(v0)
  }

  // Optimizations and conditions simplifications, voluntarily not comprehensive as C compiler re-optimize them later
  def simplify(conds: List[Cond]):List[Cond] = {
      var cs = conds.distinct.filter { case CEq(a,b,0) if (a==b) => false case _ => true } // 1. filter x+0=x
      cs = cs.map { case CFor(v,l,ld,u,ud) => var lm=ld; var um=ud; // 2. minimize the range of for loop
          cs.foreach { case CLeq(a,b,d) => if (a==l && b==v && d>lm) lm=d; if (a==v && b==u && d>um) um=d; case _ => }
          CFor(v,l,lm,u,um)
        case x => x
      }
      cs.foreach { // 3. drop useless Leq (either contained by a For or superseded by another constraint on the same pair)
        case CLeq(a,b,x) => cs=cs.filter { case CLeq(c,d,y) if (c==a && d==b && y<x) => false case _ => true }
        case CFor(v,l,_,u,_) => cs=cs.filter { case CLeq(c,d,_) if (c==l && d==v || c==v && d==u) => false case _ => true }
        case _ =>
      }; cs
  }

  def ind(s:String,n:Int=1) = { val i="  "*n; i+s.replaceAll(" +$","").replace("\n","\n"+i)+"\n" }

  // Tabulation code generation
  def genTab(t:Tabulate):String = {
    def scs(min:Int,max:Int,i:Var,j:Var) = if (min==max) List(i.eq(j,min)) else (if (max==maxN) Nil else List(j.leq(i,-max))):::(if (min>0) List(i.leq(j,min)) else Nil)
    def genFun[T,U](f0:T=>U):String = { val f1 = f0 match { case d:DeTuple => d.f case f => f }
      f1 match { case f:CFun => head.add(f) case _ => "UnsupportedFunction" } // TODO: error
    }
    var aid=0; // aggregate id
    // Generate C parser for subword (i,j): collect conditions, content and backtrack indices
    // [ parser, i,j,k?, subrule(backtrack), aggregation_depth ] => [ Conditions(for loops), hoisted_body, body, backtrack indices ]
    def gen[T](p0:Parser[T],i:Var,j:Var,g:FreeVar,rule:Int,aggr:Int):(List[Cond],String,String,List[String]) = p0 match {
      case Terminal(min,max,f) => val (cs,s)=f(i,j); (scs(min,max,i,j):::cs,"",s,Nil)
      case p:Tabulate => (scs(p.min,p.max,i,j),"","cost[idx("+i+","+j+")]."+p.name,Nil)
      case Aggregate(p,h) => val (c,hb,b,bti)=gen(p,i,j,g,rule,aggr+1);

        def bodyTpe:String = { // typeof(body with no fresh variable)
          val g0:FreeVar = new FreeVar('0') { override def get=zero; override def dup=this }
          val (_,_,lb,_)=gen(p,zero,zero,g0,0,0); "typeof("+lb+")"
        }
        val tpe = (p,h) match {
          case (_,MinBy(f:CFun)) => head.getType(f.args.head._2)
          case (_,MaxBy(f:CFun)) => head.getType(f.args.head._2)
          case (Map(_,f0),_) => val f1 = f0 match { case d:DeTuple => d.f case f => f }
            f1 match { case f:CFun => head.getType(f.tpe) case _ => bodyTpe }
          case _ => bodyTpe
        }

        val (tc,tb) = if(aggr==0) ("_cost."+t.name,"_back."+t.name) else { aid=aid+1; ("_c"+aid, "_b"+aid) }
        // Generate aggregation body
        val updt = "{ "+tc+"=_c; "+tb+"=("+btTpe(if (aggr==0) t.inner.cat else p.cat)+"){"+rule+(if (p.cat>0)",{"+bti.mkString(",")+"}" else "")+"}; }";
        val cc = h.toString match {
          case "$$max$$" => tpe+" _c="+b+"; if (_c>"+tc+" || "+tb+".rule==-1) "+updt
          case "$$min$$" => tpe+" _c="+b+"; if (_c<"+tc+" || "+tb+".rule==-1) "+updt
          case "$$count$$" => tc+"+=1;"
          case "$$sum$$" => tc+"+="+b+";"
          case "$$maxBy$$" => val f=genFun(h.asInstanceOf[MaxBy[Any,Any]].f); tpe+" _c="+b+"; if ("+f+"(_c)>"+f+"("+tc+") || "+tb+".rule==-1) "+updt
          case "$$minBy$$" => val f=genFun(h.asInstanceOf[MinBy[Any,Any]].f); tpe+" _c="+b+"; if ("+f+"(_c)<"+f+"("+tc+") || "+tb+".rule==-1) "+updt
          case _ => "UnsupportedAggr("+b+")" // TODO: error
        }
        if (aggr==0) (c,hb,cc,bti) // hoist aggregation if contained
        else { val nv = tpe+" "+tc+"; "+btTpe(p.cat)+" "+tb+"={-1"+(if (p.cat>0)",{}" else "")+"};\n";
          (Nil,nv+emit((c,hb,cc,bti)),tc,(0 until p.cat).map{x=>tb+".pos["+x+"]"}.toList)
        }
      case Or(l,r) => (Nil,"",emit(gen(l,i,j,g.dup,rule,aggr))+"\n"+emit(gen(r,i,j,g.dup,rule+l.alt,aggr)),Nil)
      case Map(p,f) => val (c,hb,b,bti)=gen(p,i,j,g,rule,aggr); (c,hb,genFun(f)+"("+b+")",bti)
      case Filter(p,f) => val (c,hb,b,bti)=gen(p,i,j,g,rule,aggr); (c,hb,"if ("+genFun(f)+"(("+head.getType("(Int,Int)")+"){"+i+","+j+"})) { "+b+" }",bti)
      case cc@Concat(l,r,tt) =>
        def bf1(f:Int, l:Int, u:Int):List[Cond] = { val ls=List(i.leq(j,f+l)); if (u>0) j.leq(i,-f-u)::ls else ls }
        val (c,k):(List[Cond],Var) = (tt,cc.indices) match {
          // low=up in at least one side
          case (0,(0,0,0,0)) => val k0=g.get; (List(k0.loop(i,j)), k0)
          case (0,(iL,iU,0,0)) if (iL==iU) => (List(i.leq(j,iL)), i.add(iL))
          case (0,(0,0,jL,jU)) if (jL==jU) => (List(i.leq(j,jL)), j.add(-jL))
          case (0,(iL,iU,jL,jU)) if (iL==iU && jL==jU) => (List(i.eq(j,iL+jL)), i.add(iL))
          case (0,(iL,iU,jL,jU)) if (iL==iU) => (bf1(iL,jL,jU), i.add(iL))
          case (0,(iL,iU,jL,jU)) if (jL==jU) => (bf1(jL,iL,iU), j.add(-jL))
          // most general case
          case (0,(iL,iU,jL,jU)) => val k0=g.get; var cs:List[Cond]=Nil;
            if (jU>0) cs = j.leq(k0,-jU) :: cs
            if (iU>0) cs = i.leq(k0,iU) :: cs // we might want to simplify if min_k==i || max_k==j
            (CFor(k0.v,i.v,iL,j.v,jL)::cs, k0)
          // concat[12]
          case (1,(a,b,_,_)) => if (a==b && a>0) (List(zero.leq(i,1)), i.add(-a)) else { val k0=g.get; (List(CFor(k0.v,'0',1,i.v,1)), k0) }
          case (2,(_,_,a,b)) => if (a==b && a>0) (List(zero.leq(j,1)), j.add(-a)) else { val k0=g.get; (List(CFor(k0.v,'0',1,j.v,1)), k0) }
        }
        val (lc,lhb,lb,lbt) = if (tt==1) gen(l,k,i,g,rule,aggr) else gen(l,i,k,g,rule,aggr)
        val (rc,rhb,rb,rbt) = gen(r,k,j,g,rule,aggr)
        (simplify(c:::lc:::rc), lhb+rhb, lb+","+rb, lbt:::(if(cc.hasBt) List(k.toString) else Nil):::rbt)
      case _ => sys.error("Unknown parser")
    }
    // Generate the loops and size conditions (conditions, hoisted, body, indices)
    def emit(cb:(List[Cond],String,String,List[String])):String = cb match { case (cs0,hbody,body,_) => val cs=simplify(cs0)
      val nl=cs.exists{case CFor(_,_,_,_,_)=>true case _=>false}
      val cc = cs.map{
        case CFor(v,l,ld,u,ud) => "for(int "+v+"="+l+(if(ld>0)"+"+ld else "")+(ud match {
            case 0 => "; "+v+"<="+u case 1 => "; "+v+"<"+u
            case _ => ","+v+"u="+u+"-"+ud+"; "+v+"<="+v+"u"
          })+"; ++"+v+")"
        case CEq(a,b,d) => "if ("+a+(if(d>0)"+"+d else "")+"=="+b+")"
        case CLeq(a,b,d) => "if ("+a+(if(d>0)"+"+d else "")+"<="+b+")"
      }
      val a = cc.map{x=>x+" { "}.mkString("")
      val b = cc.map{x=>" }"}.mkString("")
      if (nl) a+"\n"+ind(hbody+body)+b.trim+"\n" else a+hbody+body+b
    }
    // Generate the whole tabulation
    emit(gen(norm(t.inner),Var('i',0),Var('j',0),new FreeVar('k'),t.id,0))
  }

  // --------------------------------------------------------------------------
  // Backtrack generation
  def genUnapp[T](p0:Parser[T],sw:(String,String),rule:Int,bti:Int) : List[((String,String),Int)] = p0 match { // i,j,rule
    case Terminal(_,_,_) => Nil
    case p:Tabulate => List((sw,p.id))
    case Aggregate(p,h) => genUnapp(p,sw,rule,bti)
    case Filter(p,f) => genUnapp(p,sw,rule,bti)
    case Map(p,f) => genUnapp(p,sw,rule,bti)
    case Or(l,r) => var a=l.alt-1; if (rule<=a) genUnapp(l,sw,rule,bti) else genUnapp(r,sw,rule-a,bti)
    case cc@Concat(left,right,track) => val a:Int=right.alt; val c:Int=left.cat; val kb = "rd->pos["+(bti+c)+"]"
      val (swl,swr):((String,String),(String,String)) = (sw,track,cc.indices) match {
        case ((i,j),0,(lL,lU,rL,rU)) =>
          val k=if (cc.hasBt) kb else if (rU==maxN) i+"+"+lL else "MAX("+i+"+"+lL+","+j+"-"+rU+")"; ((i,k),(k,j))
        case ((i,j),1,(l,u,_,_)) => val k=if (cc.hasBt) kb else i+"-"+l; ((k,i),(k,j)) // tt:concat1
        case ((i,j),2,(_,_,l,u)) => val k=if (cc.hasBt) kb else j+"-"+l; ((i,k),(k,j)) // tt:concat2
        case _ => (("0","0"),("0","0"))
      }
      genUnapp(left,swl,rule/a,bti) ::: genUnapp(right,swr,rule%a,bti+c+(if (cc.hasBt)1 else 0))
    case _ => sys.error("Unknown parser")
  }

  def genBT:String = {
    val catMax=rules.map{case (n,t)=>t.inner.cat}.max
    val altMax=rules.map{case (n,t)=>t.inner.alt}.sum
    def switch(f:Int=>String) = "    switch (rd->rule) {\n"+(0 until altMax).map{x=>"      case "+x+":"+f(x)+" break;"}.mkString("\n")+"\n    }\n"
    head.add("typedef struct { short i,j,rule; short pos["+catMax+"]; } trace_t;")
    head.add("const int trace_len["+altMax+"] = {"+(0 until altMax).map{x=>findTab(x)._1.inner.cat}.mkString(",")+"};") // subrule->#indices
    val sb=new StringBuilder
    sb.append("size_t gpu_backtrack(trace_t* trace, int i0, int j0) {\n"); // from (i0,j0), trace=trace_t[2*N], provided by CPU
    sb.append("  size_t size = 0;\n  trace_t *rd=trace, *wr=trace;\n")
    sb.append("  #define PUSH_BACK(I,J,RULE) { wr->i=I; wr->j=J; wr->rule=RULE; ++wr; ++size; }\n")
    sb.append("  PUSH_BACK(i0,j0,"+axiom.id+");\n")
    sb.append("  for(;rd<wr;++rd) {\n")
    sb.append("    "+btTpe(catMax)+"* bt;\n")
    sb.append(switch((x:Int)=>" bt=("+btTpe(catMax)+"*)&g_back[idx(rd->i,rd->j)]."+findTab(x)._1.name+";"))
    sb.append("    rd->rule=bt->rule;\n")  // parser_id -> actual_subrule
    sb.append("    for (int i=0,l=trace_len[rd->rule]; i<l; ++i) rd->pos[i]=bt->pos[i];\n"); // decode fully the read indices
    sb.append(switch((x:Int)=>{val t=findTab(x)._1; genUnapp(t.inner,("rd->i","rd->j"),x-t.id,0).map{case((i,j),r)=>" PUSH_BACK("+i+","+j+","+r+");" }.mkString("")}))
    sb.append("  }\n  return size;\n}\n"); sb.toString
  }

  /*
  TODO:
  1. Automatically transform plain Scala function to CFun functions => Macros/LMS
  2. Automate JNI transfer to and from CUDA arrays for
     - Input/s (arbitrary type)
     - Bactrack (array of varying-length structures) => fixed-length to max
  3. Use CCompiler-like to wire everything together and execute it
  */
  // XXX: make sure we handle case class as I/O appropriately in codegen

  // --------------------------------------------------------------------------
  // C code generator

  def gen:String = { analyze
    val kern="back_t _back = {"+order.map{n=>val c=rules(n).inner.cat;"{-1"+(if(c>0) ",{"+(0 until c).map{_=>"0"}.mkString(",")+"}" else "")+"}" }.mkString(",")+"};\n"+
             "cost_t _cost = {};\n"+order.map{n=>val r=rules(n); "/* --- "+n+"[i,j] --- */\n"+genTab(r)}.mkString
    val bt = genBT
    val info = "// Type: "+(if (twotracks) "sequence alignment" else "parser" )+(if (window>0) ", window="+window else "")+"\n"+order.zipWithIndex.map { case(n,i)=>
      val p=rules(n); "// Rule #%-2d %-8s : id=%-2d alt=%-2d cat=%-2d min=%-2d, max=%-2d\n".format(i,"'"+n+"'",p.id,p.inner.alt,p.inner.cat,p.min,p.max)
    }.mkString
    print(info)
    if (twotracks) println("#define SH_RECT") else println("#define SH_TRI")
    print(head.flush)
    println("------------ kernel -----------")
    // #include <unistd.h>
    // #define idx(i,j) 0
    // back_t g_back[0]; cost_t cost[1]; TI in[1];
    // int main(int argc, char** argv) { int i=0,j=0;
    print(ind(kern,3))
    // }
    println("---------- backtrack ----------")
    print(bt)
    println("------------- end -------------")
    ""
  }
}
