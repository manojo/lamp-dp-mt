package lms.topdown

import lms._
import scala.virtualization.lms.common._
import scala.virtualization.lms.internal.Effects
import java.io.PrintWriter
import java.io.FileOutputStream

trait GenCharParsersProg extends CharParsers{
  //type Answer = Char
  val mAns = manifest[Char]

  def test1(in: Rep[Array[Char]]): Rep[(Char,Int)] = {

    var s = make_tuple2(unit('a'), unit(-1))
    val parser = acceptIf(in, x => x == 'h').apply(unit(0))
    parser{x: Rep[(Char, Int)] => s = x}
    s
  }

/*  def test2(in: Rep[Array[Char]]): Rep[Answer] = {
    val mat: Rep[Array[Char]] = NewArray(unit(2))
    var s = 'a'
    val parser = tabulate(char(in), "rule", mat, in.length)(0, 1)
    parser{x: Rep[Char] => s = x}
    s
  }
  */
}

class TestTopDownParsers extends FileDiffSuite {

  val prefix = "test-out/"

  def testParsers = {
    withOutFile(prefix+"gen-topdown-char"){
       new GenCharParsersProg with PackageExp with GeneratorOpsExp with MyScalaCompile{self =>

        val codegen = new ScalaGenPackage with ScalaGenGeneratorOps{ val IR: self.type = self }

        codegen.emitSource(test1 _ , "test1", new java.io.PrintWriter(System.out))
        val testc1 = compile(test1)
        val res1 = testc1("hello".toArray)
        scala.Console.println(res1)

/*        codegen.emitSource(test2 _ , "test2", new java.io.PrintWriter(System.out))
        val testc2 = compile(test2)
        val res2 = testc2(scala.Array('c'))
        scala.Console.println(res2)
*/
      }

    }

    assertFileEqualsCheck(prefix+"gen-topdown-char")
  }
}