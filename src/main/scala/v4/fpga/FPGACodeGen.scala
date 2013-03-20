package v4.fpga
import v4._

// MMAlpha code generator
// See: http://www.irisa.fr/cosi/ALPHA/index.html
//
// Restriction that apply: (we may relax some later)
// - Two-track grammar (TTParsers)
// - We only care about result (aka no backtrack)
// - We have at most 1 rule in the grammar (axiom)
// - That rule _always_ generate some result (aka tabulate.alwaysValid=true)
// - No nested aggregation
// - Only serial dependencies, aka access M[i-k,j-l] with k,l bounded
// XXX: shall we encode them somewhere ?

trait FPGACodeGen extends CodeGen with TTParsers { this:Signature=>
  // Avoid CUDA to automatically kick-in when mixing CodeGen
  override def parse(in1:Input,in2:Input,ps:ParserStyle=psBottomUp):List[Answer] = super.parse(in1,in2,ps)
  override def backtrack(in1:Input,in2:Input,ps:ParserStyle=psBottomUp):List[(Answer,Trace)] = super.backtrack(in1,in2,ps)
  // ---- END ----

  val is = scala.collection.mutable.Set[Int]()
  val js = scala.collection.mutable.Set[Int]()

  def computeDomains[T](p: Parser[T]): Unit = p match {
    case Terminal(min,max,_) => is ++= Set(min,max); js ++= Set(min,max)
    case Filter(p,_) => computeDomains(p)
    case Aggregate(p,_) => computeDomains(p)
    case Map(p,_) => computeDomains(p)
    case Or(l,r) => computeDomains(l); computeDomains(r)
    case c@Concat(l,r,t) => computeDomains(l); computeDomains(r); val x=c.indices;
      t match {
        case 1 => is ++= Set(x._1, x._2)
        case 2 => js ++= Set(x._3, x._4)
        case _ => sys.error("Does not appear in TTParsers")
      }
    case t:Tabulate => ()
  }

  def getRulesFor[T](p: Parser[T], i: Int, j: Int): Option[Parser[T]] = p match {
    case t@Terminal(_,_,_) => t match {
      case `el1` => if(i > 0) Some(t) else None
      case `el2` => if(j > 0) Some(t) else None
      case `empty` => if(i == 0 && j == 0) Some(t) else None
      case _ => Some(t)
    }
    case Filter(p,f) => getRulesFor(p,i,j).map{ p2 => Filter(p2,f)}
    case Aggregate(p,h) => getRulesFor(p,i,j).map{ p2 => Aggregate(p2,h)}
    case Map(p,f) => getRulesFor(p,i,j).map{ p2 => Map(p2,f)}
    case Or(l,r) => (getRulesFor(l,i,j), getRulesFor(r,i,j)) match {
      case (None, None) => None
      case (x@Some(_), None) => x
      case (None, y@Some(_)) => y
      case (Some(x), Some(y)) => Some(Or(x,y))
    }
    case c@Concat(l,r,t) => (getRulesFor(l,i,j), getRulesFor(r,i,j)) match {
      case (None, _) | (_, None) => None
      case (Some(x), Some(y)) => Some(new Concat(x,y,t) { override lazy val indices=c.indices })
    }
    case p:Tabulate => Some(p)
  }

  /*
  def prettyPrint[T](p: Parser[T]):String = p match{
    case el1 => "Seq1[i]"
    case el2 => if(j > 0) Some(el2) else None
    case empty => if(i == 0 && j == 0) Some(empty) else None
    case t : Terminal => Some(t)
    case Filter(p,f) => getRulesFor(p,i,j).map{ p2 => Filter(p2,f)}
    case Aggregate(p,h) => getRulesFor(p,i,j).map{ p2 => Aggregate(p2,h)}
    case Map(p,f) => getRulesFor(p,i,j).map{ p2 => Map(p2,f)}
    case Or(l,r) => (getRulesFor(l,i,j), getRulesFor(r,i,j)) match {
      case (None, None) => None
      case (x : Some, None) => x
      case (None, y : Some) => y
      case (Some(x), Some(y)) => Some(Or(x,y))
    }
    case c@Concat(l,r,t) => (getRulesFor(l,i,j), getRulesFor(r,i,j)) match {
      case (None, _) | (_, None) => None
      case (Some(x), Some(y)) => Some(new Concat(x,y,t) { override lazy val indices=c.indices })
    }
    case p:Tabulate => Some(p)
  }
  */

/*
  private val head = new CodeHeader(this) // User code and helpers store
  override def genTab(t:Tabulate):String = {
    var aggid=0; // nested aggregation intermediate result id
    def scs(min:Int,max:Int,i:Var,j:Var) = if (min==max) List(i.eq(j,min)) else (if (max==maxN) Nil else List(j.leq(i,-max))):::(if (min>0) List(i.leq(j,min)) else Nil)
    // Generate C parser for subword (i,j): collect conditions, hoisted/content and backtrack indices
    // (parser, i,j,k?, subrule, aggregation_depth) => (Conditions+for loops, hoisted, body, backtrack indices)
    def gen[T](p0:Parser[T],i:Var,j:Var,g:FreeVar,rule:Int,aggr:Int):(List[Cond],String,String,List[String]) = p0 match {
      case Terminal(min,max,f) => val (cs,s)=f(i,j); (scs(min,max,i,j):::cs,"",s,Nil)
      case p:Tabulate => ( (if (p.alwaysValid) Nil else List(CUser("VALID("+i+","+j+","+p.name+")"))):::scs(p.min,p.max,i,j),"","cost[idx("+i+","+j+")]."+p.name,Nil)
      case Aggregate(p,h) => val (c,hb,b,bti)=gen(p,i,j,g,rule,aggr+1);
        def bodyTpe:String = { // fallback to "typeof(body)" if untypable, where body has no fresh variable
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
        val (tc,tb) = if(aggr==0) (if (cudaEmpty!=null) "_c0" else "_cost."+t.name,"_b0") else { aggid=aggid+1; ("_c"+aggid, "_b"+aggid) }
        // Generate aggregation body
        val cc = "{ "+(h.toString match {
          case "$$max$$" => "Max("+b+", _c)"
          case "$$min$$" => "Min("+b+", _c)"
          case _ => sys.error("Unsupported aggregation: "+b)
        })+" }"
        if (aggr==0) (c,hb,cc,bti) // hoist aggregation if contained
        else { val nv = tpe+" "+tc+"; "+btTpe(p.cat)+" "+tb+"={-1"+(if (p.cat>0)",{}" else "")+"};\n";
          (List(CUser(tb+".rule!=-1")),nv+emit((c,hb,cc,bti)),tc,(0 until p.cat).map{x=>tb+".pos["+x+"]"}.toList)
        }
      case Or(l,r) => (Nil,"",emit(gen(l,i,j,g.dup,rule,aggr))+"\n"+emit(gen(r,i,j,g.dup,rule+l.alt,aggr)),Nil)
      case Map(p,f) => val (c,hb,b,bti)=gen(p,i,j,g,rule,aggr); (c,hb,genFun(f)+"("+b+")",bti)
      case Filter(p,f) => val (c,hb,b,bti)=gen(p,i,j,g,rule,aggr); (CUser(genFun(f)+"("+i+","+j+")")::c,hb,b,bti)
      case cc@Concat(l,r,tt) =>
        def bf1(f:Int, l:Int, u:Int):List[Cond] = { val ls=List(i.leq(j,f+l)); if (u!=maxN) j.leq(i,-f-u)::ls else ls }
        val (c,k):(List[Cond],Var) = (tt,cc.indices) match {
          // low=up in at least one side
          case (0,(iL,iU,jL,jU)) if (iL==iU && jL==jU) => (List(i.eq(j,iL+jL)), i.add(iL))
          case (0,(iL,iU,jL,jU)) if (iL==iU) => (bf1(iL,jL,jU), i.add(iL))
          case (0,(iL,iU,jL,jU)) if (jL==jU) => (bf1(jL,iL,iU), j.add(-jL))
          // most general case
          case (0,(iL,iU,jL,jU)) => val k0=g.get; var cs:List[Cond]=Nil;
            if (jU!=maxN) cs = j.leq(k0,-jU) :: cs
            if (iU!=maxN) cs = k0.leq(i,-iU) :: cs // we might want to simplify if min_k==i || max_k==j
            (CFor(k0.v,i.v,iL,j.v,jL)::cs, k0)
          // concat1,concat2
          case (t,(a,b,c,d)) if (t==1||t==2) => val (l,u,v) = if (t==1) (a,b,i) else (c,d,j)
            if (l==u) (List(zero.leq(v,l)), v.add(-l))
            else { val k0=g.get; val cu=if (u==maxN) Nil else List(k0.leq(v,u)); (CFor(k0.v,'0',0,v.v,l)::cu, k0) }
        }
        val (lc,lhb,lb,lbt) = if (tt==1) gen(l,k,i,g,rule,aggr) else gen(l,i,k,g,rule,aggr)
        val (rc,rhb,rb,rbt) = gen(r,k,j,g,rule,aggr)
        (simplify(c:::lc:::rc), lhb+(if (lhb!=""&&rhb!="") "\n" else "")+rhb, lb+","+rb, lbt:::(if(cc.hasBt) List(k.toString) else Nil):::rbt)
      case _ => sys.error("Unknown parser")
    }
    // Generate the loops and size conditions (conditions, hoisted, body, indices)
    def emit(cb:(List[Cond],String,String,List[String])):String = cb._3
    // Generate the whole tabulation
    emit(gen(norm(Aggregate(t.inner,h)),Var('i',0),Var('j',0),new FreeVar('k'),t.id,0))
  }
*/
  var ctr=0;
  override def genFun[T,U](f0:T=>U):String = { val f1 = f0 match { case d:DeTuple => d.f case f => f }
    f1 match { case f:CFun => ctr=ctr+1; println("fun"+ctr+" = ("+f.args.map{_._1}.mkString(",")+") => "+f.body); "fun"+ctr case _ => sys.error("Unsupported function: "+f1) }
  }

  def genParser[T](p0:Parser[T],i:Var,j:Var):List[String] = p0 match {
    case Aggregate(p,h) => 
      val f = h.toString match { case "$$max$$"=>"max" case "$$min$$"=>"min" case _=>sys.error("Unsupported aggregation: "+h) }
      val l = genParser(p,i,j); List((l.head /: l.tail){(a,b)=>"max("+a+","+b+")"  })
    case Or(l,r) => genParser(l,i,j):::genParser(r,i,j)
    case Map(p,f) => List(genFun(f)+"("+genParser(p,i,j).mkString(",")+")")
    case cc@Concat(l,r,t) =>
        val k:Var = (t,cc.indices) match { // only support serial dependencies
          case (0,(l,u,_,_)) if (l==u) => i.add(l)
          case (0,(_,_,l,u)) if (l==u) => j.add(-l)
          case (1,(l,u,_,_)) if (l==u) => i.add(-l)
          case (2,(_,_,l,u)) if (l==u) => j.add(-l)
          case _ => sys.error("Unsupported non-serial dependencies")
        }
        List((if (t==1) genParser(l,k,i) else genParser(l,i,k)).head,genParser(r,k,j).head)
    case `el1` => List("s1["+i+"]")
    case `el2` => List("s2["+i+"]")
    case `empty` => List("")
    case t:Tabulate => List(t.name+"["+i+","+j+"]")
    case _ => sys.error("Unsupported parser "+p0)
  }

  override def gen:String = {
    analyze; val rs=rulesOrder.map{n=>rules(n)}
    // Split the domain in tiles where different set of parsers apply
    computeDomains(axiom.inner) //for (r<-rs) computeDomains(r.inner)
    val(ix, jx) = ((is - (-1)).toArray.sorted,  (js - (-1)).toArray.sorted)

    //println(ix.toList); println(jx.toList)

    println("case")
    for(i <- 0 until ix.length; j <- 0 until jx.length){
      print("{ |")
      print(  "i >= " + ix(i) + (if(i == ix.length -1) "" else "; i < " + ix(i+1)))
      print("; j >= " + jx(j) + (if(j == jx.length -1) "" else "; j < " + jx(j+1)))
      print("} : ")
      getRulesFor(axiom.inner, ix(i), jx(j)) match {
        case Some(p) => println(genParser(p,Var('i',0),Var('j',0)).head)
        //case Some(p) => println(genTab(tabulate("tab"+i+"_"+j,p))) // XXX: use a Tabulation -> Parser transform => XXX: use custom codegen instead
        case _ => sys.error("No parser applies")
      }
      //println(getRulesFor(axiom, ix(i), jx(j)))
    }
    println("esac;")
    ""
  }

}
