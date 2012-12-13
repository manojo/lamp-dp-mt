package v4.examples

object Tests extends App {
  def tests(s:String,ts:List[Boolean]) = {
    print("- "+s+": "); ts.foreach{r=>print(if(r) "." else "FAIL")}; println
  }
  println("Test suite:")

  tests("Brackets",List(Brackets.parse("(((3)))((2))(1)((6))((((8))))(3)((4))".toArray)==List(7)))
  tests("ElMamoun",List(ElMamun.buyer.bargain("1+2*3*4+5").head==30,ElMamun.seller.bargain("1+2*3*4+5").head==81))

  val mIn = List((10,100),(100,5),(5,50)).toArray
  val (mS,mBt)=MatrixMult2.a.backtrack(mIn).head
  tests("MatrixMul",List(mS==(10,7500,50),
    MatrixMult2.b.build(mIn,mBt)=="((|10x100|*|100x5|)*|5x50|)",
    MatrixMult.parse(mIn)==List(((10,7500,50),"((|10x100|*|100x5|)*|5x50|)"))
  ))

  val (zS,_,zRes)=Zuker.parse("guacgucaguacguacgugacugucagucaac")
  tests("Zuker",List(zS==2500,zRes=="((((((.((((......)).))))..))..))")) // INCORRECT DUE TO BAD COEFFICIENTS
  
  val (s1,s2)=("CGATTACA","CCCATTAGAG")
  val (swScore,sw1,sw2) = SeqAlign.SWat.align(s1,s2).head
  val (nwScore,nw1,nw2) = SeqAlign.NWun.align(s1,s2).head
  tests("SeqAlign",List(
  	swScore==51,sw1==".--CGATTACA-",sw2==".CCC-ATTAGAG",
  	nwScore== -12,nw1==".CG-ATTACA-",nw2==".CCCATTAGAG"
  ))
}
