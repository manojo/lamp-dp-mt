package lms.topdown

import lms._
import scala.virtualization.lms.common._
import scala.virtualization.lms.internal.Effects

import java.io.PrintWriter
import java.io.StringWriter
import java.io.FileOutputStream


trait GenCharParsersProg extends TokenParsers with Structs{

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

  //rep
  def test10(in: Rep[Array[Char]]): Rep[(String,Int)] = {
    var s = make_tuple2(unit(""), unit(-1))
    val parser = (rep(letter(in)) ^^ {x: Rep[List[Char]] => x.mkString}).apply(unit(0))
    parser{x: Rep[(String, Int)] => s = x}
    s
  }

  //keyword parse
  def keywordParse(in: Rep[Array[Char]]): Rep[(String,Int)] = {
    var s = make_tuple2(unit(""), unit(-1))
    val parser = (keyword(in)).apply(unit(0))
    parser{x: Rep[(String, Int)] => s = x}
    s
  }

  //keyword parse
  def twoWordParse(in: Rep[Array[Char]]): Rep[((String,String),Int)] = {
    var s = make_tuple2(make_tuple2(unit(""), unit("")), unit(-1))
    val parser = ((stringLit(in) <~ whitespaces(in)) ~ stringLit(in)).apply(unit(0))
    parser{x: Rep[((String, String), Int)] => s = x}
    s
  }
}

trait GenRecParsersProg extends TokenParsers with Functions {

  class LambdaOps[A:Manifest,B:Manifest](f: Rep[A=>B]) {
    def apply(x:Rep[A]): Rep[B] = doApply(f, x)
  }

  //def expr: Parser[String] = term ~ rep("+" ~ term | "-" ~ term)
/*
  def ~ [U:Manifest](that: => Parser[U]) = Parser[(T,U)]{ pos =>
    self(pos).flatMap{ x: Rep[(T,Int)] =>
      that(x._2).map{ y: Rep[(U,Int)] =>
        make_tuple2((x._1, y._1), y._2)
      }
    }
  }
*/
/*  term(in) = digit(in) ~ opt(term(in))

  digit(in)(i).flatMap{ x: Rep[(Char, Int)] =>
    term(in)(x._2).map{ y:Rep[(String,Int)] =>
      if(y._2 == x._2) {()} else {
        (unit(x._1)+y._1 , y._2)
      }
    }
  }

  {
    self(pos).flatMap{ x: Rep[(T,Int)] =>
      that(x._2).map{ y: Rep[(U,Int)] =>
        make_tuple2((x._1, y._1), y._2)
      }
    }

    digit(in)
  }

  expr = term ~ rep("+" ~ term | "-" ~ term)
  term = factor ~ rep(" * " ~ factor | "/" ~ factor)
  factor = floatingPointNumber | "(" ~ expr ~ ")"

  def expr(in: Rep[Input]): Parser[String] = Parser{ i: Rep[Int] =>
    new Generator[(String,Int)]{

    }

  }

*/

  def term(in: Rep[Input]): Parser[String] = Parser{ i: Rep[Int] =>
    new Generator[(String, Int)]{
      def apply(f: Rep[(String,Int)] => Rep[Unit]) = {
        lazy val termg: Rep[((String,Int))=>Unit] = doLambda{ t: Rep[(String,Int)] =>
          digit(in)(t._2).apply{ x: Rep[(Char,Int)] =>
            val param = make_tuple2(t._1 + (unit("")+x._1), x._2 )
            f(param)
            termg(param)
          }
//          val param = make_tuple2( (unit("")+x._1)+t._1, x._2 )
        }
        termg(make_tuple2(unit(""), i))
      }
    }
  }

  def testTerm(in:Rep[Input]) = {
    var s = make_tuple2(unit(""), unit(-1))
    term(in).apply(unit(0)).apply{x : Rep[(String, Int)] => s =x }
    s
  }
}

class TestTopDownParsers extends FileDiffSuite {

  val prefix = "test-out/"
/*
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

        codegen.emitSource(test10 _ , "test10", new java.io.PrintWriter(System.out))
        val testc10 = compile(test10)
        scala.Console.println(testc10("hello21".toArray))

      }

    }

    assertFileEqualsCheck(prefix+"gen-topdown-char")
  }


  def testTokenParsers = {
    withOutFile(prefix+"gen-topdown-token"){
       new GenCharParsersProg with PackageExp with GeneratorOpsExp
        with StructExp with StructExpOptCommon with MyScalaCompile{self =>

        val codegen = new ScalaGenPackage with ScalaGenGeneratorOps
          with ScalaGenStruct{ val IR: self.type = self }

        codegen.emitSource(keywordParse _ , "test1", new java.io.PrintWriter(System.out))
        val testc1 = compile(keywordParse)
        val res1 = testc1("true false".toArray)
        scala.Console.println(res1)

        codegen.emitSource(twoWordParse _ , "test2", new java.io.PrintWriter(System.out))
        val testc2 = compile(twoWordParse)
        val res2 = testc2("\"hello\" \"carol\"".toArray)
        scala.Console.println(res2)

      }

    }

    assertFileEqualsCheck(prefix+"gen-topdown-token")
  }
*/
  def testRec = {
    withOutFile(prefix+"gen-topdown-rec") {
      new GenRecParsersProg with FunctionsExternalDef
       with GeneratorOpsExp with PackageExp with MyScalaCompile {self =>

        val codegen = new ScalaGenPackage with ScalaGenGeneratorOps
         with ScalaGenFunctionsExternal {
          val IR: self.type = self
        }

        codegen.emitSource(testTerm, "LiftTerm", new java.io.PrintWriter(System.out))
        val testc2 = compile(testTerm)
        scala.Console.println(testc2("23".toArray))
        //val testc1 = compile(f)
        //scala.Console.println(testc1("\"hello\" \"carol\"".toArray))


      }
    }
    assertFileEqualsCheck(prefix+"gen-topdown-rec")
  }
}