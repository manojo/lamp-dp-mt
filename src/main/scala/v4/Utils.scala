package v4

// Here we put useful functoins, nevertheless problem-specific,
// for our environment or mainly for benchmarking

object Utils {
  import scala.util.Random
  Random.setSeed(123456748299L)

  def runBenchmark(fc:Int=>Unit,fs:Int=>Unit) {
    val sz=List(128,256,512,1024,2048,4096,8192)
    println("====( CUDA warm-up )==============================================")
    for (i<-0 until 2) fc(1024)
    println("====( CUDA )======================================================")
    for (s<-sz) {
      println("---- Size = "+s+" ----------------")
      for (i<-0 until (if (s>2048) 10 else 20)) fc(s)
    }
    println("====( Scala warm-up )=============================================")
    fs(512)
    println("====( Scala )=====================================================")
    for (s<-sz) {
      println("---- Size = "+s+" ----------------")
      for (i<-0 until (if (s>2048) 5 else 20)) fs(s)
    }
  }

  // --------------------------------------------------------------------------
  // Matrix multiplication
  def genMats(n:Int=512) = {
    def rnd:Int = Math.abs(Random.nextInt)%253+1
    val s = Seq.fill(n)(rnd)
    (Seq(rnd) ++ s).zip(s).map{case(x,y)=>(x,y)/*unbox ints!!*/}.toArray
  }
  def genMats0(n:Int=512)= {
    def r(x:Int) = (x*2309 ^ (x+2)*947) % 173 + 3
  	(0 until n).map { x=>(r(x),r(x+1)) }.toArray
  }

  // --------------------------------------------------------------------------
  // RNA folding

  // Generate a reproducible random RNA sequence
  def genSeq(n:Int=80) = Seq.fill(n)(Math.abs(Random.nextInt)%4).map {case 0=>'a' case 1=>'c' case 2=>'g' case 3=>'u'}.mkString

  // Debugging helper, program must be Vienna/RNAfold-compatible
  def refFold(seq:String,prog:String="./RNAfold --noPS --noLP -d2"):String = {
    import java.io._
    val p = Runtime.getRuntime.exec(prog);
    val in = new PrintStream(p.getOutputStream());
    def gobble(in:InputStream) = new Runnable {
      var out = new StringBuilder
      var thr = new Thread(this); thr.start
      override def toString = { thr.join; out.toString.trim }
      override def run { val r = new BufferedReader(new InputStreamReader(in))
        var l = r.readLine; while(l != null) { out.append(l+"\n"); l = r.readLine }; r.close
      }
    }
    val out=gobble(p.getInputStream);
    in.println(seq); in.close
    p.waitFor; out.toString.split("\n")(1)
  }

}