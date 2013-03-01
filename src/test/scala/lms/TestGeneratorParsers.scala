package lms

import scala.virtualization.lms.common._
import scala.virtualization.lms.internal.Effects
import java.io.PrintWriter
import java.io.FileOutputStream

trait GenLexicalParsersProg extends LexicalGenParsers{this: Sig =>
  type Answer = Char
  val mAns = manifest[Char]

  def test1(in: Rep[Array[Char]]): Rep[Answer] = {
    var s = 'a'
    val parser = char(in)(0, 1)
    parser{x: Rep[Char] => s = x}
    s
  }

  def test2(in: Rep[Array[Char]]): Rep[Answer] = {
    val mat: Rep[Array[Char]] = NewArray(unit(2))
    var s = 'a'
    val parser = tabulate(char(in), "rule", mat, in.length)(0, 1)
    parser{x: Rep[Char] => s = x}
    s
  }
}

//matrix multiplication
trait GenMatMultProg extends GeneratorParsers{ this: Sig =>
  type Alphabet = (Int,Int)
  val mAlph = manifest[(Int,Int)]

  type Answer = (Int, Int, Int)
  val mAns = manifest[(Int,Int,Int)]

  def single(i: Rep[(Int,Int)]) =
    (i._1, unit(0), i._2)

  def mult(l: Rep[Answer],r : Rep[Answer]) = {
    (l._1, l._2 + r._2 + l._1 * l._3 * r._3 ,r._3)
  }

  def multParser(in:Input, a: Rep[Array[Answer]]) : TabulatedParser = {
    lazy val p : TabulatedParser = tabulate(
     (el(in) ^^ single
      | (p +~+ p) ^^ {(x: Rep[(Answer,Answer)]) => mult(x._1,x._2)}
     ),
     "mat",
     a, in.length
    )
   p
  }

  def testBottomup(in: Input): Rep[Answer] = {
    val a : Rep[Array[Answer]] = NewArray((in.length+1) * (in.length+1))

    val mParser = multParser(in, a)
    val res = bottomUp(in,mParser,a, (unit(0), unit(100000), unit(0)), {
      (x: Rep[Answer], y : Rep[Answer]) => if(x._2 < y._2) x else y
    })
    res
  }
}


class TestGeneratorParsers extends FileDiffSuite {

  val prefix = "test-out/"

  def testParsers = {
    withOutFile(prefix+"gen-parser-char"){
       new GenLexicalParsersProg with GeneratorParsersExp with Sig with MiscOpsExp with CompileScala{self =>

        val codegen = new ScalaGenArrayOps with ScalaGenGeneratorOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps with ScalaGenMiscOps{ val IR: self.type = self }

        codegen.emitSource(test1 _ , "test1", new java.io.PrintWriter(System.out))
        val testc1 = compile(test1)
        val res1 = testc1(scala.Array('c'))
        scala.Console.println(res1)

        codegen.emitSource(test2 _ , "test1", new java.io.PrintWriter(System.out))
        val testc2 = compile(test2)
        val res2 = testc2(scala.Array('c'))
        scala.Console.println(res2)
      }
    }

    assertFileEqualsCheck(prefix+"gen-parser-char")
  }

  def testBottomUp1 = {
    withOutFile(prefix+"gen-parser-matmult"){
       new GenMatMultProg with GeneratorParsersExp with Sig with MiscOpsExp with CompileScala{ self =>
        val codegen = new ScalaGenArrayOps with ScalaGenGeneratorOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps with ScalaGenMiscOps{ val IR: self.type = self }

        codegen.emitSource(testBottomup _ , "gen-parser-matmult", new java.io.PrintWriter(System.out))

        val testc = compile(testBottomup)
        val res = testc(scala.Array((10,100),(100,5),(5,50)))
        scala.Console.println(res)
        //val input = List((10,100),(100,5),(5,50)).toArray
        //println(parse(input))

      }
    }
    assertFileEqualsCheck(prefix+"gen-parser-matmult")
  }
}