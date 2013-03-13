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
    val parser = acceptIf(in, x => x == unit('h')).apply(unit(0))
    parser{x: Rep[(Char, Int)] => s = x}
    s
  }

  def test2(in: Rep[Array[Char]]): Rep[(Char,Int)] = {
    var s = make_tuple2(unit('a'), unit(-1))
    val parser = accept(in, unit('h')).apply(unit(0))
    parser{x: Rep[(Char, Int)] => s = x}
    s
  }

  def test3(in: Rep[Array[Char]]): Rep[(Char,Int)] = {
    var s = make_tuple2(unit('a'), unit(-1))
    val parser = letter(in).apply(unit(0))
    parser{x: Rep[(Char, Int)] => s = x}
    s
  }

  def test4(in: Rep[Array[Char]]): Rep[(Char,Int)] = {
    var s = make_tuple2(unit('a'), unit(-1))
    val parser = digit(in).apply(unit(0))
    parser{x: Rep[(Char, Int)] => s = x}
    s
  }

  //two letters
  def test5(in: Rep[Array[Char]]): Rep[((Char, Char),Int)] = {
    var s = make_tuple2(make_tuple2(unit('a'), unit('a')), unit(-1))
    val parser = (letter(in)~letter(in)).apply(unit(0))
    parser{x: Rep[((Char, Char), Int)] => s = x}
    s
  }
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

        codegen.emitSource(test2 _ , "test2", new java.io.PrintWriter(System.out))
        val testc2 = compile(test2)
        val res2 = testc2("hello".toArray)
        scala.Console.println(res2)

        codegen.emitSource(test3 _ , "test3", new java.io.PrintWriter(System.out))
        val testc3 = compile(test3)
        val res3 = testc3("hello".toArray)
        scala.Console.println(res3)

        codegen.emitSource(test4 _ , "test4", new java.io.PrintWriter(System.out))
        val testc4 = compile(test4)
        scala.Console.println(testc4("hello".toArray))
        scala.Console.println(testc4("12".toArray))

        codegen.emitSource(test5 _ , "test5", new java.io.PrintWriter(System.out))
        val testc5 = compile(test5)
        val res5 = testc5("hello".toArray)
        scala.Console.println(res5)

      }

    }

    assertFileEqualsCheck(prefix+"gen-topdown-char")
  }
}