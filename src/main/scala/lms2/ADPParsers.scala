package lms2

trait ADPParsers extends BaseParsers { this:Signature =>
  // I/O interface
  private var input: Input = null
  def in(k:Int):Alphabet = input(k)
  def size:Int = input.size
  def parse(in:Input):List[Answer] = run(in,()=>{parseBottomUp; axiom(0,size).map(_._1)})
  def backtrack(in:Input):List[(Answer,Trace)] = run(in,()=>{parseBottomUp; axiom.backtrack(0,size)})
  def build(in:Input,bt:Trace):Answer = run(in,()=>axiom.build(bt))
  private def run[T](in:Input, f:()=>T) = { input=in; analyze; tabInit(in.size+1,in.size+1); val res=f(); tabReset; input=null; res }
  private def parseBottomUp:Unit = {
    val rs=rulesOrder map {n=>rules(n)}; var d=0; while (d<=size) { for (r<-rs) { val iu=size-d; var i=0; while (i<=iu) { r((d+i,d+i)); i=i+1 } }; d=d+1; }
  }

  // Concatenation operations
  import scala.language.implicitConversions
  implicit def parserADP[T](p1:Parser[T]) = new ParserADP(p1)
  class ParserADP[T](p1:Parser[T],idx:(Int,Int,Int,Int)=null) {
    def ~ [U](p2:Parser[U]) = if (idx!=null) new Concat(p1,p2,0) { override lazy val indices=idx } else new Concat(p1,p2,0)
    def ~ (minl:Int,maxl:Int,minr:Int,maxr:Int):ParserADP[T] = new ParserADP[T](p1,(minl,maxl,minr,maxr))
  }

  // Terminal parsers
  val empty = new Terminal[Unit](0,0) {
    def apply(sw:Subword) = { val (i,j)=sw; if (i==j) List(({},bt0)) else Nil }
  }
  val emptyi = new Terminal[Int](0,0) {
    def apply(sw:Subword) = { val (i,j)=sw; if (i==j) List((i,bt0)) else Nil }
  }
  val el = new Terminal[Alphabet](1,1) {
    def apply(sw:Subword) = { val (i,j)=sw; if(i+1==j) List((in(i),bt0)) else Nil }
  }
  val eli = new Terminal[Int](1,1) {
    def apply(sw:Subword) = { val (i,j)=sw; if(i+1==j) List((i,bt0)) else Nil }
  }
  def seq(min:Int=1, max:Int=maxN) = new Terminal[Subword](min,max) {
    def apply(sw:Subword) = { val (i,j)=sw; if (i+min<=j && (max==maxN || i+max>=j)) List(((i,j),bt0)) else Nil }
  }
}

trait LexicalParsers extends ADPParsers { this:Signature =>
  override type Alphabet = Char
  // Predefined terminals
  val char = el
  val chari = eli
  //val letter = char filter cf((c:Char)=>(c>='a' && c<='z') || (c>='A' && c<='Z'),"return (c>='a' && c<='z') || (c>='A' && c<='Z');")
  //val digit = (char filter cf((c:Char)=>c>='0' && c<='9',"return c>='0' && c<='9';"))
  /*
  //def charf(s:String) = char filter cf((c:Char)=>s.indexOf(c)!= -1,"const char* s=\""+esc(s)+"\"; for(;*s;++s) { if (*s==c) return true; } return false;")
  //def charf(c0:Char) = char filter cf((c:Char)=>c==c0,"return c=='"+esc(""+c0)+"';")

  // Predefined filters
  def length(min:Int=0,max:Int= -1) = cfun2((i:Int,j:Int)=> (j-i)>=min && (max < 0 || j-i<=max), "i,j","return j-i>="+min+(if(max>=0)" && j-i<="+max else "")+";")

  import scala.language.implicitConversions
  implicit def toCharArray(s:String):Array[Char] = s.toArray
  private def esc(s:String) = (s /: List(('\\','\\'),('"','"'),('\'','\''),('\n','n'),('\r','r'),('\t','t'),('\0','0'),('\b','b'),('\f','f'))) {case (s,(a,b))=>s.replace(""+a,"\\"+b)}
  private def cf(f:Char=>Boolean,cc:String) = cfun1((i:Int,j:Int) => (i+1==j) && f(in(i)),"i,j","if (i+1!=j) return false; c=_in1[i]; "+cc)
  def in(k:Int):Char
  */
}
