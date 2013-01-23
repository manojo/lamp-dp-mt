import java.io._

object Bench {
  // write in a file
  def write(path:String,data:String) {
    val p = new java.io.PrintWriter(new java.io.File(path))
    try { p.print(data) } finally { p.close }
  }

  // execute arbitrary command, return (out,err), print elapsed time
  private def run(cmd:String,time:Boolean=true,input:String=null):(String,String) = {
    val start=System.currentTimeMillis;
    val p = Runtime.getRuntime.exec(cmd);
    def gobble(in:InputStream) = new Runnable {
      var out = new StringBuilder
      var thr = new Thread(this); thr.start
      override def toString = { thr.join; out.toString.trim }
      override def run {
        val r = new BufferedReader(new InputStreamReader(in))
        var l = r.readLine; while(l != null) { /*println(l);*/ /*out.append(l+"\n");*/ l = r.readLine }; r.close
      }
    }
    val out=gobble(p.getInputStream); val err=gobble(p.getErrorStream);
    if (input!=null) {
      val writer = new BufferedWriter(new OutputStreamWriter(p.getOutputStream));
      writer.write(input); writer.close
    }
    p.waitFor
    val d=System.currentTimeMillis-start; if (time) { print(" %d.%03d".format(d/1000,d%1000)); System.out.flush }
    (out.toString,err.toString)
  }

  import scala.util.Random
  Random.setSeed(123456748299L)
  def genDNA(n:Int,fasta:Boolean=true):String = {
    def sp(h:String,t:String):String = if (t.size<=70) h+t+"\n" else sp(h+t.substring(0,70)+"\n",t.substring(70))
    val s = Seq.fill(n)(Math.abs(Random.nextInt)%4).map {case 0=>'A' case 1=>'C' case 2=>'G' case 3=>'T'}.mkString
    if (!fasta) s else sp(">gi|2925"+(Math.abs(Random.nextInt)%3247)+"|gb|AE00"+(Math.abs(Random.nextInt)%6913)+"| Random incomplete genome\n",s)
  }
  def genRNA(n:Int):String = {
    def sp(h:String,t:String):String = if (t.size<=70) h+t+"\n" else sp(h+t.substring(0,70)+"\n",t.substring(70))
    Seq.fill(n)(Math.abs(Random.nextInt)%4).map {case 0=>'a' case 1=>'c' case 2=>'g' case 3=>'u'}.mkString
  }

  def test(s:String,n:Int,f:Int=>Unit) {
    print("sprintf('%.3f',median(["); System.out.flush
    for (i <- 0 until n) f(i); println(" ])) % "+s)
  }

  def cudalign(n:Int,len:Int) = test("CUDAlign ("+len+")",n,(i:Int)=>{
    write("seq"+i+"_1.fasta",genDNA(len))
    write("seq"+i+"_2.fasta",genDNA(len))
    run("../cudalign/src/cudalign seq"+i+"_1.fasta seq"+i+"_2.fasta")
    run("rm -r work.tmp status.out",false)
  })

  def gapc_mm(n:Int,len:Int) = test("GAPC MatrixMult ("+len+")",n,(i:Int)=>{
    write("in.txt",Seq.fill(len)(Math.abs(Random.nextInt)%1021).mkString(","))
    run("../gapc/matmult -f in.txt")
  })

  def gapc_swat(n:Int,len:Int) = test("GAPC SWat ("+len+")",n,(i:Int)=>{
    write("in1.txt",genDNA(len,false))
    write("in2.txt",genDNA(len,false))
    run("../gapc/affine -f in1.txt -f in2.txt")
  })

  def rnafold_rl(n:Int,len:Int,gpu:Boolean=true) = test("RNAfold-RL-"+(if (gpu) "CUDA" else "CPU")+" ("+len+")",n,(i:Int)=>{
    write("in.txt",genRNA(len))
    run("../rnafold/"+(if (gpu)"cuda" else "cpu")+"/RNAfold -f in.txt")
  })

  def gapc_adpfold(n:Int,len:Int,gpu:Boolean=true) = test("GAPC ADPfold ("+len+")",n,(i:Int)=>{
    write("in.txt",genRNA(len))
    run("../gapc/adpfold -f in.txt")
  })

  def vienna_rna(n:Int,len:Int,original:Boolean=true) = test("Vienna RNA ("+len+")",n,(i:Int)=>{
    val seq = genRNA(len)
    run((if (original)"../../resources/RNAfold_orig_mac" else "../../src/librna/rfold")+" --noPS --noLP -d2",true,seq)
  })

  def main(args: Array[String]) {
    val lr = List(64,96,128,192,256,384,512,768,1024,1536,2048,3072,4096,6144,8192)
    // --- Matrix multiplication
    //for (l<-lr) gapc_mm(20,l)

    // --- Smith-Waterman
    //for (l<-lr) cudalign(20,l)
    //for (l<-lr) gapc_swat(20,l)

    // --- RNA folding
    //for (l<-lr) rnafold_rl(20,l,true)
    //for (l<-lr) rnafold_rl(20,l,false) // Erratic behavior
    //for (l<-lr) gapc_adpfold(20,l)
    //for (l<-lr) vienna_rna(7,l)

  }
}
