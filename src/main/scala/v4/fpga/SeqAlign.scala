package v4.fpga
import v4._
import v4.report._

object SeqAlign extends SeqAlignGrammar with SmithWatermanAlgebra with FPGACodeGen with App {
  override val tps=(manifest[Alphabet],manifest[Answer])

  val seq1 = "CGATTACA".toArray
  val seq2 = "CCCATTAGAG".toArray

  println("Hi!")

/*  SWat2.analyze
  SWat2.computeDomains(SWat2.axiom.inner)
  //is -= -1; js -= -1
  val(sortedis, sortedjs) = ((is - (-1)).toArray.sorted,  (js - (-1)).toArray.sorted)
  println(is); println(js)
  println((sortedis, sortedjs))

  println("case")

  for(i <- 0 until sortedis.length;
      j <- 0 until sortedjs.length
  ){
    print("{ |")
    print(  "i >= " + sortedis(i) + (if(i == sortedis.length -1) "" else "; i < " + sortedis(i+1)))
    print("; j >= " + sortedjs(j) + (if(j == sortedjs.length -1) "" else "; j < " + sortedjs(j+1)))
    print("} : ")
    println(getRulesFor(axiom, sortedis(i), sortedjs(j))))
  }
  println("esac;")
*/
  analyze
  println(genTab(axiom))

  //backtrack(s1,s2).head
  /*
  def align(name:String,s1:String,s2:String,g:SeqAlignGrammar) = {
    val (score,bt) = 
    println(name+" alignment\n- Score: "+score)
    println("- Seq1: "+a1+"\n- Seq2: "+a2+"\n")
  }
  align("Smith-Waterman",seq1,seq2,SWat)
  align("Needleman-Wunsch",seq1,seq2,SWat)
  */
}
