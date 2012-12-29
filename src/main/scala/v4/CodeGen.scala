package v4

trait CodeGen extends BaseParsers { this:Signature =>
  private val head = new CodeHeader(this) // User code and helpers store
  private var order:List[String]=Nil // Order of parsers evaluation
  private lazy val tpAlphabet = if (tps._1==null) "XXX" else head.getType(tps._1.toString) // XXX: bad fix to avoid initialization issues
  private lazy val tpAnswer = if (tps._2==null) "XXX" else head.getType(tps._2.toString)
  
  // Additional typing informations required for codegen. We need to use Manifest due to following limitations:
  // - TypeTag: type (i.e. (Int,Int)) not necessary linked to class (examples.Test.Alphabet instead of examples.TestSig$Mat)
  // - ClassTag: provides only the class, no insight of Tuple inner types
  val tps:(Manifest[Alphabet],Manifest[Answer]) = (null,null)
  
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
  def btTpe(n:Int) = head.addType("short rule"+(if(n>0)"; short pos["+n+"]"else""),"bt"+n)
  override def analyze:Boolean = { if (!super.analyze) return false; order=tabsOrder;
    head.add("#define input_t "+tpAlphabet)
    head.add("typedef struct { "+order.map{n=>tpAnswer+" "+n+";"}.mkString(" ")+" } cost_t;")
    head.add("typedef struct { "+order.map{n=>val c=rules(n).inner.cat; btTpe(c)+" "+n+";"}.mkString(" ")+" } back_t;")
    true
  }

  // Normalize the parsers towards code generation
  // Canonical : [Tabulate] > Aggregate > Or > Filter > Map > Concat > (Tabulate | Terminal)
  // C code    : [Tabulate] > Or > ForLoop+Filter > Aggregate1 > Map > (Tabulate | Terminal)
  // Invariant : Aggregate > Map > Concat (due to domain change)
  def norm[T](parser:Parser[T]):Parser[T] = parser match {
    case Aggregate(p0,h) => norm(p0) match {
      case Aggregate(p,h1) if (h1==h) => p0
      case Or(l,r) => Or(norm(Aggregate(l,h)),norm(Aggregate(r,h)))
      case Filter(p,f) => Filter(norm(Aggregate(p,h)),f)
      case p => Aggregate(p,h)
    }
    case Or(l0,r0) => (norm(l0),norm(r0)) match {
      case (Filter(p1,c1),Filter(p2,c2)) if (c1==c2) => Filter(Or(p1,p2),c1)
      case (Or(a,b),c) if (a==c) => norm(Or(b,c))
      case (Or(a,b),c) if (b==c) => norm(Or(a,c))
      case (a,Or(b,c)) if (a==b) => norm(Or(a,c))
      case (a,Or(b,c)) if (a==c) => norm(Or(a,b))
      case (l,r) if (l==r) => l
      case (l,r) => Or(l,r)
    }
    case Map(p0,f) => norm(p0) match {
      case Or(l,r) => Or(norm(Map(l,f)),norm(Map(r,f)))
      case Filter(p,c) => Filter(norm(Map(p,f)),c)
      case p => Map(p,f)
    }
    case Filter(p,c) => Filter(norm(p),c)
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

  // Code indentation helper
  def ind(s:String,n:Int=1) = { val i="  "*n; i+s.replaceAll(" +$","").replace("\n","\n"+i)+"\n" }

  // --------------------------------------------------------------------------
  // Tabulation and kernel code generation

  def genFun[T,U](f0:T=>U):String = { val f1 = f0 match { case d:DeTuple => d.f case f => f }
    f1 match { case f:CFun => head.add(f) case _ => "UnsupportedFunction" } // TODO: error
  }

  def genTab(t:Tabulate):String = {
    var aggid=0; // nested aggregation intermediate result id
    def scs(min:Int,max:Int,i:Var,j:Var) = if (min==max) List(i.eq(j,min)) else (if (max==maxN) Nil else List(j.leq(i,-max))):::(if (min>0) List(i.leq(j,min)) else Nil)
    // Generate C parser for subword (i,j): collect conditions, hoisted/content and backtrack indices
    // (parser, i,j,k?, subrule, aggregation_depth) => (Conditions+for loops, hoisted, body, backtrack indices)
    def gen[T](p0:Parser[T],i:Var,j:Var,g:FreeVar,rule:Int,aggr:Int):(List[Cond],String,String,List[String]) = p0 match {
      case Terminal(min,max,f) => val (cs,s)=f(i,j); (scs(min,max,i,j):::cs,"",s,Nil)
      case p:Tabulate => ( (if (p.alwaysValid) Nil else List(CUser("VALID("+i+","+j+","+p.name+")"))):::scs(p.min,p.max,i,j),"","cost[idx("+i+","+j+")]."+p.name,Nil)
      case Aggregate(p,h) => val (c,hb,b,bti)=gen(p,i,j,g,rule,aggr+1);
        def bodyTpe:String = { // fallback if untypable: typeof(body) where body has no fresh variable
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
        val (tc,tb) = if(aggr==0) ("_cost."+t.name,"_back."+t.name) else { aggid=aggid+1; ("_c"+aggid, "_b"+aggid) }
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
          (List(CUser(tb+".rule!=-1")),nv+emit((c,hb,cc,bti)),tc,(0 until p.cat).map{x=>tb+".pos["+x+"]"}.toList)
        }
      case Or(l,r) => (Nil,"",emit(gen(l,i,j,g.dup,rule,aggr))+"\n"+emit(gen(r,i,j,g.dup,rule+l.alt,aggr)),Nil)
      case Map(p,f) => val (c,hb,b,bti)=gen(p,i,j,g,rule,aggr); (c,hb,genFun(f)+"("+b+")",bti)
      case Filter(p,f) => val (c,hb,b,bti)=gen(p,i,j,g,rule,aggr); (CUser(genFun(f)+"("+i+","+j+")")::c,hb,b,bti)
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
        (simplify(c:::lc:::rc), lhb+(if (lhb!=""&&rhb!="") "\n" else "")+rhb, lb+","+rb, lbt:::(if(cc.hasBt) List(k.toString) else Nil):::rbt)
      case _ => sys.error("Unknown parser")
    }
    // Generate the loops and size conditions (conditions, hoisted, body, indices)
    def emit(cb:(List[Cond],String,String,List[String])):String = cb match { case (cs0,hbody,body,_) =>
      val cs = (simplify(cs0).map{ 
        case CEq(a,b,d) => CUser(a+(if(d>0)"+"+d else "")+"=="+b)
        case CLeq(a,b,d) => CUser(a+(if(d>0)"+"+d else "")+"<="+b)
        case c => c
      } foldRight List[Cond]()) { case (CUser(c1),CUser(c2)::as) => CUser(c1+" && "+c2)::as case (c,acc)=>c::acc }
      var hb=false; var br=false
      val cc=(cs foldRight body){
        case (CFor(v,l,ld,u,ud),b) => val b2=(if ((hbody+body).contains("_unroll")) "" else "_unroll ")+
          "for(int "+v+"="+l+(if(ld>0)"+"+ld else "")+(ud match {
            case 0 => "; "+v+"<="+u case 1 => "; "+v+"<"+u
            case _ => ","+v+"u="+u+"-"+ud+"; "+v+"<="+v+"u"
          })+"; ++"+v+") {\n"+ind((if (!hb) hbody else "")+b)+"}\n"; hb=true; br=true; b2
        case (CUser(c),b) => val b2="if ("+c+") "+(if (!br) "{\n"+ind(b)+"}" else b); br=true; b2
        case _ => "" // does not happen
      }
      if (hb==false) hbody+cc else cc
    }
    // Generate the whole tabulation
    emit(gen(norm(Aggregate(t.inner,h)),Var('i',0),Var('j',0),new FreeVar('k'),t.id,0))
  }

  def genKern = {
    val kern="back_t _back = {"+order.map{n=>val c=rules(n).inner.cat;"{-1"+(if(c>0) ",{"+(0 until c).map{_=>"0"}.mkString(",")+"}" else "")+"}" }.mkString(",")+"};\n"+
             "cost_t _cost = {}; // init to 0\n#define VALID(I,J,RULE) (back[idx(I,J)].RULE.rule!=-1)\n"+
             order.map{n=>val r=rules(n); "/* --- "+n+"[i,j] --- */\n"+genTab(r)}.mkString+"\ncost[idx(i,j)] = _cost;\nback[idx(i,j)] = _back;"
    val loops = "for (unsigned jj=s_start; jj<s_stop; ++jj) {\n"+
      (if (twotracks) "  for (unsigned i=tI; i<M_H; i+=tN) {\n    unsigned j = jj-tI;"
                 else "  for (unsigned ii=tI; ii<M_H; ii+=tN) {\n    unsigned i = M_H-1-ii, j = i+jj;")
    "__global__ void gpu_solve(const input_t* in1, const input_t* in2, cost_t* cost, back_t* back, volatile unsigned* lock, unsigned s_start, unsigned s_stop) {\n"+
    "  const unsigned tI = threadIdx.x + blockIdx.x * blockDim.x;\n"+
    "  const unsigned tN = blockDim.x * gridDim.x;\n"+
    "  const unsigned tB = blockIdx.x;\n"+
    "  unsigned tP=s_start; // block progress\n"+ind(loops,1)+"      if (j<M_W) {\n"+ind(kern,4)+"      }\n"+
    "    }\n    // Sync between blocks, removing __threadfence() here is incorrect but works\n    // __threadfence();\n"+
    "    if (threadIdx.x==0) { lock[tB]=++tP; if (tB) while(lock[tB-1]<tP) {} }\n    __syncthreads();\n  }\n}\n"
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

  def genBT = {
    val catMax=rules.map{case (n,t)=>t.inner.cat}.max
    val altMax=rules.map{case (n,t)=>t.inner.alt}.sum
    def switch(f:Int=>String) = "    switch (rd->rule) {\n"+(0 until altMax).map{x=>"      case "+x+":"+f(x)+" break;"}.mkString("\n")+"\n    }\n"
    val trLen = "const unsigned trace_len["+altMax+"] = {"+(0 until altMax).map{x=>findTab(x)._1.inner.cat}.mkString(",")+"};" // subrule->#indices
    head.add("typedef struct { short i,j,rule; short pos["+catMax+"]; } trace_t;")
    head.add("#define input_t "+tpAlphabet)
    head.add(trLen)

// XXXX: fix trace_len used in both CUDA and JNI
/*
    head.add("#define TRACE_LEN {"+(0 until altMax).map{x=>findTab(x)._1.inner.cat}.mkString(",")+"}")
    head.add("const unsigned trace_len["+altMax+"] = ;\n"+ // subrule->#indices
*/

    "__global__ void gpu_backtrack(trace_t* trace, unsigned* size, back_t* back, int i0, int j0) {\n"+ // from (i0,j0), trace=trace_t[2*N], provided by CPU
    "  "+trLen+ // "const unsigned trace_len["+altMax+"] = {"+(0 until altMax).map{x=>findTab(x)._1.inner.cat}.mkString(",")+"};\n"+ // subrule->#indices
    "  trace_t *rd=trace, *wr=trace; *size=0;\n"+
    "  #define PUSH_BACK(I,J,RULE) { wr->i=I; wr->j=J; wr->rule=RULE; ++wr; ++(*size); }\n"+
    "  PUSH_BACK(i0,j0,"+axiom.id+");\n"+
    "  for(;rd<wr;++rd) {\n"+
    "    "+btTpe(catMax)+"* bt;\n"+
    switch((x:Int)=>" bt=("+btTpe(catMax)+"*)&back[idx(rd->i,rd->j)]."+findTab(x)._1.name+";")+
    "    rd->rule=bt->rule;\n"+  // parser_id -> actual_subrule
    "    for (int i=0,l=trace_len[rd->rule]; i<l; ++i) rd->pos[i]=bt->pos[i];\n"+ // decode fully the read indices
    switch((x:Int)=>{val t=findTab(x)._1; genUnapp(t.inner,("rd->i","rd->j"),x-t.id,0).map{case((i,j),r)=>" PUSH_BACK("+i+","+j+","+r+");" }.mkString("")})+
    "  }\n}\n"
  }

  // --------------------------------------------------------------------------
  // CUDA helpers

  def genHelpers(splits:Int=1, stripe:Int=32) = {
    if (twotracks) {
      head.addPriv("#define B_H "+stripe) // blocks stripe height (coalesce diagonal elements along the same stripe)
      head.addPriv("#define MEM_MATRIX (M_W* ((M_H+B_H-1)/B_H)*B_H  +B_H*B_H)")
      head.addPriv("#define idx(i,j) ({ unsigned _i=(i); (B_H*((j)+(_i%B_H)) + (_i%B_H) + (_i/B_H)*M_W*B_H); })")
    } else { // idx(i,j) = MEM_MATRIX-UP_TRI+i, UP_TRI=d*(d+1)/2, d=M_H+1+_i-_j (smallest triangle including position element)
      head.addPriv("#define MEM_MATRIX ((M_H*(M_H+1))/2)") // upper right triangle, including diagonal
      head.addPriv("#define idx(i,j) ({ unsigned _i=(i),_d=M_H+1+_i-(j); MEM_MATRIX - (_d*(_d-1))/2 +_i; })")
    }
    head.addPriv("static input_t *g_in1 = NULL, *g_in2 = NULL;\nstatic cost_t *g_cost = NULL;\nstatic back_t *g_back = NULL;")
    head.add("void g_init(input_t* in1, input_t* in2);\nvoid g_free();\nvoid g_solve();\n"+tpAnswer+" g_backtrack(trace_t** trace, unsigned* size);")

    val init = "void g_init(input_t* in1, input_t* in2) {\n"+ind("cuMalloc(g_in1,sizeof(input_t)*(M_H-1));\ncuPut(in1,g_in1,sizeof(input_t)*(M_H-1),NULL);\n"+
      (if (twotracks) "cuMalloc(g_in2,sizeof(input_t)*(M_W-1));\ncuPut(in2,g_in2,sizeof(input_t)*(M_W-1),NULL);\n" else "g_in2=NULL;\n")+
      "cuMalloc(g_cost,sizeof(cost_t)*MEM_MATRIX);\ncuMalloc(g_back,sizeof(back_t)*MEM_MATRIX);",1)+"}\n\nvoid g_free() { "+
      "cuFree(g_in1); "+(if(twotracks)"cuFree(g_in2); " else "")+"cuFree(g_cost); cuFree(g_back); cudaDeviceReset(); }\n\n"

// XXX: fix this
    val steps = if (!twotracks&&window>0) ""+(window+1) else "(M_W"+(if(twotracks) "+M_H" else "")+")"

    val solve = "void g_solve() {\n"+
    "  #define WARP_SIZE 32 // constant over CUDA devices\n"+
    "  unsigned blk_size = WARP_SIZE;\n"+
    "  unsigned blk_num = (M_H+blk_size-1)/blk_size;\n"+
    "  unsigned* lock; cuMalloc(lock,sizeof(unsigned)*blk_num);\n"+
    "  cuErr(cudaMemset(lock,0,sizeof(unsigned)*blk_num));\n"+
    (if (splits>1)
      "  cudaStream_t stream; cuErr(cudaStreamCreate(&stream));\n"+
      "  for (int i=0;i<"+splits+";++i) {\n"+
      "    unsigned s0=("+steps+"*i)/"+splits+", s1=("+steps+"*(i+1))/"+splits+";\n"+
      "    gpu_solve<<<blk_num, blk_size, 0, stream>>>(g_in1, g_in2, g_cost, g_back, lock, s0, s1);\n"+
      "  }\n"+
      "  cuSync(stream); cuErr(cudaStreamDestroy(stream));\n"
    else "  gpu_solve<<<blk_num, blk_size, 0, NULL>>>(g_in1, g_in2, g_cost, g_back, lock, 0, "+steps+");\n"
    )+"  cuFree(lock);\n}\n\n"


    val aggr=h.toString match {
      case "$$count$$"|"$$sum$$" => "true"
      case "$$max$$" => "c>(*res)"
      case "$$min$$" => "c<(*res)"
      case "$$maxBy$$" => val f=genFun(h.asInstanceOf[MaxBy[Any,Any]].f); f+"(c)>"+f+"(*res)"
      case "$$minBy$$" => val f=genFun(h.asInstanceOf[MinBy[Any,Any]].f); f+"(c)<"+f+"(*res)"
      case _ => "UnsupportedAggr("+h+")" // TODO: error
    }
    val best = if (window==0) "" else 
      "__global__ void gpu_window(cost_t* cost, back_t* back, unsigned* pos, "+tpAnswer+"* res) {\n  bool valid=false;\n"+
      "  for (unsigned i=0,j="+window+"; j<M_W; ++i, ++j) "+(if (axiom.alwaysValid)"" else "if (back[idx(i,j)]."+axiom.name+".rule!=-1) ")+"{\n"+
      "    "+tpAnswer+" c = cost[idx(i,j)]."+axiom.name+";\n    if (!valid || "+aggr+") { "+
      "*res"+(h.toString match {case "$$count$$"=>"+=1" case "$$sum$$"=>"+=c" case _=>"=c"})+"; pos[0]=i; pos[1]=j; valid=true; }\n  }\n}\n\n"
    val backtrack = tpAnswer+" g_backtrack(trace_t** trace, unsigned* size) {\n"+
    "  "+tpAnswer+" res; unsigned i0="+(if(twotracks) "M_H-1" else "0")+", j0=M_W-1;\n"+
    (if (window>0)
      "  unsigned* g_pos; cuMalloc(g_pos,sizeof(unsigned)*2);\n"+
      "  "+tpAnswer+"* g_res; cuMalloc(g_res,sizeof("+tpAnswer+"));\n"+
      "  gpu_window<<<1,1,0,NULL>>>(g_cost, g_back, g_pos, g_res);\n"+
      "  cuGet(&res,g_res,sizeof("+tpAnswer+"),NULL); cuFree(g_res);\n"+
      "  unsigned pos[2]; cuGet(pos,g_pos,sizeof(unsigned)*2,NULL); cuFree(g_pos); i0=pos[0]; j0=pos[1];\n"
      //"  printf(\"i,j = %d,%d\\n\",i0,j0); return res;\n"
      // XXX: bug after this

    else "  cuGet(&res,&g_cost[idx(i0,j0)]."+axiom.name+",sizeof("+tpAnswer+"),NULL);\n")+ // get value at position
    "  if (trace && size) {\n"+
    "    unsigned mem=(M_W+M_H)*sizeof(trace_t);\n"+
    "    trace_t *g_trace=NULL; cuMalloc(g_trace,mem);\n"+
    "    unsigned *g_size=NULL; cuMalloc(g_size,sizeof(unsigned));\n"+
    "    gpu_backtrack<<<1,1,0,NULL>>>(g_trace, g_size, g_back, i0, j0);\n"+
    "    cuGet(size,g_size,sizeof(unsigned),NULL); cuFree(g_size); mem=(*size)*sizeof(trace_t);\n"+
    "    *trace=(trace_t*)malloc(mem); cuGet(*trace,g_trace,mem,NULL); cuFree(g_trace);\n"+
    "  }\n"+
    "  return res;\n}\n"

    best+init+solve+backtrack
  }

  // --------------------------------------------------------------------------
  // JNI transfers

  def genJNI = {
    val call = "JNIEXPORT jobject JNICALL Java_{className}_"
    val parm = "(JNIEnv* env, jobject obj, jobjectArray input1"+(if (twotracks) ", jobjectArray input2" else "")+")"
    val solve = "  input_t *in1=NULL; jni_read(env,input1,&in1);\n"+
     (if (twotracks) "  input_t *in2=NULL; jni_read(env,input2,&in2);\n  g_init(in1,in2); free(in2);"
                else "  g_init(in1,NULL);")+" free(in1); g_solve();\n"
    "#include <jni.h>\n#include <stdio.h>\n#include <stdlib.h>\n#include \"{file}.h\"\n#ifdef __cplusplus\n"+
    "extern \"C\" {\n#endif\n"+call+"parse"+parm+";\n"+call+"backtrack"+parm+";\n#ifdef __cplusplus\n}\n#endif\n\n"+
    head.jniRead(head.parse(tps._1.toString))+"\n"+head.jniWrite(head.parse(tps._2.toString))+"\n"+
    "jobject Java_{className}_parse"+parm+" {\n"+solve+
    "  "+tpAnswer+" score=g_backtrack(NULL,NULL);\n"+
    "  jobject result = jni_write(env, score, NULL, 0);\n"+
    "  g_free(); return result;\n}\n\n"+
    "jobject Java_{className}_backtrack"+parm+" {\n"+solve+
    "  trace_t *trace=NULL; unsigned size=0;\n"+
    "  "+tpAnswer+" score=g_backtrack(&trace,&size);\n"+
    "  jobject result = jni_write(env, score, trace, size); free(trace);\n"+
    "  g_free(); return result;\n}\n"
  }

  // --------------------------------------------------------------------------
  // C code generator

  lazy val (code_h,code_cu,code_c) = {
    analyze
    val kern = genKern
    val bt = genBT
    var hlp = genHelpers()
    var jni = genJNI
    var (hpub,hpriv) = head.flush
    val info = "// Type: "+(if (twotracks) "sequence alignment" else "sequence parser" )+(if (window>0) ", window="+window else "")+"\n"+order.zipWithIndex.map { case(n,i)=>
      val p=rules(n); "// Rule #%-2d %-8s : id=%-2d alt=%-2d cat=%-2d min=%-2d max=%-2d\n".format(i,"'"+n+"'",p.id,p.inner.alt,p.inner.cat,p.min,p.max)
    }.mkString
    (info+hpub, hpriv+"\n"+kern+"\n"+bt+"\n"+hlp, jni)
  }

  // ------------------------
  // XXX: (Manohar) Transform plain Scala function to CFun functions using Macros or LMS
  // XXX: 3. Add the two-track for CUDA (SequAlign)
  // XXX: 4. Fix the Zuker coefficients (Scala)
  // XXX: 5. Make the Zuker coefficients work for CUDA
  // Write report => make implementation detailed plan and benchmarking strategy
  // Benchmark

  def gen:String = {
    "------------ begin ------------\n"+code_h+
    "------------- gpu -------------\n"+code_cu+
    "------------- jni -------------\n"+code_c+
    "------------- end -------------\n"
  }

  // ------------------------

  abstract class CodeCompiler extends CCompiler with ScalaCompiler {
    def genCode(size1:Int,size2:Int):String = {
      val className = "CompWrapper"+CompileCount.get // fresh namespace for the problem (code+in1+in2)
      val map = scala.collection.immutable.Map(("className",className),("MAT_HEIGHT",""+(size1+1)),("MAT_WIDTH",""+(size2+1)))
      add("h", code_h, map)
      add("c", code_c, map)
      add("cu", "#include \"{file}.h\"\n#include \"../src/main/c/include/common.h\"\n"+ // XXX: fix path or inline
                "#define _unroll _Pragma(\"unroll 5\")\n#define M_W {MAT_WIDTH}\n#define M_H {MAT_HEIGHT}\n"+code_cu, map)
      gen; className
    }
  }

  val compiler = new CodeCompiler {
    override val outPath = "bin"
    override val cudaPath = "/usr/local/cuda"
    override val cudaFlags = "-m64 -arch=sm_30"
    override val ccFlags = "-O2 -I/System/Library/Frameworks/JavaVM.framework/Headers"
    override val ldFlags = "-L"+cudaPath+"/lib -lcudart -shared -Wl,-rpath,"+cudaPath+"/lib"
  }

  lazy val parseCU = (in1:Input) => {
    val className = compiler.genCode(in1.size,in1.size)
    val f = compiler.compile[Input=>Answer](className,"class "+className+" extends Function1[Array[Any],Any] {\n"+
      "@native def parse(in1:Array[Any]):Any\n"+
      "@native def backtrack(in1:Array[Any]):Any\n"+
      "override def apply(in1:Array[Any]) = this.parse(in1)\n}")
    f(in1)
  }

  lazy val backtrackCU = (in1:Input) => {
    val className = compiler.genCode(in1.size,in1.size)
    val f = compiler.compile[Input=>(Answer,List[(Subword,Backtrack)])](className,"class "+className+" extends Function1[Array[Any],Any] {\n"+
      "@native def parse(in1:Array[Any]):Any\n"+
      "@native def backtrack(in1:Array[Any]):Any\n"+
      "override def apply(in1:Array[Any]) = this.backtrack(in1)\n}")
    f(in1)
  }

}
