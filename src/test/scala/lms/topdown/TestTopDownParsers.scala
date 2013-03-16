package lms.topdown

import lms._
import scala.virtualization.lms.common._
import scala.virtualization.lms.internal.Effects
import java.io.PrintWriter
import java.io.StringWriter
import java.io.FileOutputStream

trait GenCharParsersProg extends CharParsers with Structs{

  //some basic structs
  type Lettah = Record { val left: Char; val right: Char }
  def Lettah(l: Rep[Char], r: Rep[Char]): Rep[Lettah] = new Record {
    val left = l; val right = r
  }

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

  //ignoring left result
  def test6(in: Rep[Array[Char]]): Rep[(Char,Int)] = {
    var s = make_tuple2(unit('a'), unit(-1))
    val parser = (letter(in)~>letter(in)).apply(unit(0))
    parser{x: Rep[(Char, Int)] => s = x}
    s
  }

  //ignoring right result
  def test7(in: Rep[Array[Char]]): Rep[(Char,Int)] = {
    var s = make_tuple2(unit('a'), unit(-1))
    val parser = (letter(in)<~letter(in)).apply(unit(0))
    parser{x: Rep[(Char, Int)] => s = x}
    s
  }

  //a simple map
  def test8(in: Rep[Array[Char]], i: Rep[Int]): Rep[(Lettah,Int)] = {
    val l = Lettah(unit('a'), unit('a'))
    var s = make_tuple2(l, unit(-1))
    val parser = (letter(in)~letter(in) ^^ {x: Rep[(Char, Char)] =>
      Lettah(x._1, x._2)
    }).apply(unit(0))

    parser{x: Rep[(Lettah, Int)] => s = x}
    s
  }

  //or
  def test9(in: Rep[Array[Char]]): Rep[(Char,Int)] = {
    var s = make_tuple2(unit('a'), unit(-1))
    val parser = (letter(in) | digit(in)).apply(unit(0))
    parser{x: Rep[(Char, Int)] => s = x}
    s
  }

}

class TestTopDownParsers extends FileDiffSuite {

  val prefix = "test-out/"

  def testSimpleParsers = {
    withOutFile(prefix+"gen-topdown-char"){
       new GenCharParsersProg with PackageExp with GeneratorOpsExp
        with StructExp with StructExpOptCommon with MyScalaCompile{self =>

        val codegen = new ScalaGenPackage with ScalaGenGeneratorOps
          with ScalaGenStruct{ val IR: self.type = self }

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
        scala.Console.println(testc5("hello".toArray)) //succeeding a ~ b
        scala.Console.println(testc5("1ello".toArray)) //failing left
        scala.Console.println(testc5("h2llo".toArray)) //failing right

        codegen.emitSource(test6 _ , "test6", new java.io.PrintWriter(System.out))
        val testc6 = compile(test6)
        val res6 = testc6("hello".toArray)
        scala.Console.println(res6)

        codegen.emitSource(test7 _ , "test7", new java.io.PrintWriter(System.out))
        val testc7 = compile(test7)
        val res7 = testc7("hello".toArray)
        scala.Console.println(res7)


        val printWriter = new java.io.PrintWriter(System.out)
        codegen.emitSource2(test8 _, "test8", printWriter)
        codegen.emitDataStructures(printWriter)
        val source = new StringWriter
        codegen.emitDataStructures(new PrintWriter(source))
        val testc8 = compile2s(test8, source)
        scala.Console.println(testc8("hello".toArray, 1))

        codegen.emitSource(test9 _ , "test9", new java.io.PrintWriter(System.out))
        val testc9 = compile(test9)
        scala.Console.println(testc9("hello".toArray))
        scala.Console.println(testc9("12".toArray))

      }

    }

    assertFileEqualsCheck(prefix+"gen-topdown-char")
  }
}