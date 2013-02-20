package lms

import scala.virtualization.lms.common._
import scala.virtualization.lms.internal.Effects
import java.io.PrintWriter
import java.io.FileOutputStream

trait ParsersProg extends LexicalParsers {this: Sig =>
  type Answer = Char
  val mAns = manifest[Char]

  def test1(in: Rep[Array[Char]]) = char(in)(0, 1)

  def test2(in: Rep[Array[Char]]) = charf(in, 'm')(0,1)

  def test3(in: Rep[Array[Char]]) = {
    lazy val p = char(in) ^^ ((x: Rep[Char]) => x)
    p(0,1)
  }

  def test4(in: Input) = {
    lazy val p = (charf(in,'m') | charf(in,'a'))
    p(0,1)
  }

  def test5(in: Input) : Rep[List[Char]] = {
    lazy val p = (charf(in,'m') | charf(in,'a')) aggregate((x: Rep[List[Char]]) => List(x.head))
    p(0,1)
  }

  def test6(in: Input) : Rep[List[(Char,Char)]] = {
    lazy val p = (charf(in, 'm') ~~+ charf(in, 'a'))
    p(0,2)
  }

  def testTab1(in: Input) : Rep[Answer] = {
    lazy val myParser : Parser[Char] = {
      val a : Rep[Array[Array[Char]]] = NewArray(in.length+1)
      (0 until in.length + 2).foreach{ i=>
        a(0) = NewArray(in.length+1)
      }

      tabulate(charf(in, 'm'),
        "myParser",
        a
      )
    }

    myParser(0,1).head
  }
}

trait StringParsersProg extends LexicalParsers {this: Sig =>
  type Answer = List[Char]
  val mAns = manifest[List[Char]]

  def testRec1(in: Input) : Rep[Answer] = {
    def concatenate(t : Rep[(Char, List[Char])]) = t._1 :: t._2

    lazy val myParser : Parser[Answer] = {
      val a : Rep[Array[Array[List[Char]]]]
        = NewArray(in.length+1)
      (0 until in.length + 2).foreach{ i=>
        a(0) = NewArray(in.length+1)
      }

      lazy val p: Parser[Answer] =
        tabulate((charf(in, 'm') -~~ p) ^^ concatenate,
          "myParser",
          a
        )
      p
    }

    myParser(0,in.length).head
  }
}

//matrix multiplication
trait MatMultProg extends Parsers{ this: Sig =>
  type Alphabet = (Int,Int)
  val mAlph = manifest[(Int,Int)]

  type Answer = (Int, Int, Int)
  val mAns = manifest[(Int,Int,Int)]

  def single(i: Rep[(Int,Int)]) =
    (i._1, unit(0), i._2)

  def mult(l: Rep[Answer],r : Rep[Answer]) = {
    (l._1, l._2 + r._2 + l._1 * l._3 * r._3 ,r._3)
  }

  def multWithArray(in: Input) = {
    val a : Rep[Array[Array[Answer]]] = NewArray(in.length+1)
    (0 until in.length + 1).foreach{ i=>
      a(0) = NewArray(in.length+1)
    }
    multParser(in, a)
  }

  def multParser(in:Input, a: Rep[Array[Array[Answer]]]) : TabulatedParser = {
    lazy val p : TabulatedParser = tabulate(
     (el(in) ^^ single
      | (p +~+ p) ^^ {(x: Rep[(Answer,Answer)]) => mult(x._1,x._2)}
     ).aggfold((unit(0),unit(100000),unit(0)), (x,y) => if(x._2 < y._2) x else y),
     "mat",
     a
    )
   p
  }

  def testMult1(in : Input): Rep[Answer] = {
    multWithArray(in)(0, in.length).head
  }

  def testMult2(in: Input) : Rep[Answer] = {
    val opti = transform(multWithArray(in))//.asInstanceOf[Parser[Answer]]
    opti(0, in.length).head
  }

  def testBottomup(in: Input): Rep[Answer] = {
    val a : Rep[Array[Array[Answer]]] = NewArray(in.length+1)
    (0 until in.length + 1).foreach{ i=>
      a(i) = NewArray(in.length+1)
    }

    val mParser = multParser(in, a)
    val res = bottomUp(in,mParser,a)
    res
  }

  def testBottomup2(in: Input): Rep[Answer] = {
    val a : Rep[Array[Array[Answer]]] = NewArray(in.length+1)
    (0 until in.length + 1).foreach{ i=>
      a(i) = NewArray(in.length+1)
    }

    val mParser = transform(multParser(in, a))
    val res = bottomUp(in,mParser,a)
    res
  }
}

trait ListFoldProg extends MyListOps with NumericOps with MiscOps{
  def testListFold(in: Rep[List[Int]]): Rep[Int] = {
    list_fold(in, unit(0), {(x: Rep[Int], y: Rep[Int]) => x + y})
  }
}

class TestSimpleParsers extends FileDiffSuite {

  val prefix = "test-out/"

  def testParsers = {
    withOutFile(prefix+"simpleParsers"){
       new ParsersProg with ParsersExp with Sig with MiscOpsExp { self =>

        val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps{ val IR: self.type = self }

        codegen.emitSource(test1 _ , "test1", new java.io.PrintWriter(System.out))
        codegen.emitSource(test2 _ , "test2", new java.io.PrintWriter(System.out))
        codegen.emitSource(test3 _ , "test3", new java.io.PrintWriter(System.out))
        codegen.emitSource(test4 _ , "test4", new java.io.PrintWriter(System.out))
        codegen.emitSource(test5 _ , "test5", new java.io.PrintWriter(System.out))
        codegen.emitSource(test6 _ , "test6", new java.io.PrintWriter(System.out))
      }
    }

    assertFileEqualsCheck(prefix+"simpleParsers")
  }

  def testTabulation1 = {
    withOutFile(prefix+"tabulation1"){
       new ParsersProg with ParsersExp with Sig with MiscOpsExp{ self =>
        val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps{ val IR: self.type = self }

        codegen.emitSource(testTab1 _ , "test-tabulation", new java.io.PrintWriter(System.out))
      }
    }
    assertFileEqualsCheck(prefix+"tabulation1")
  }

  def testTabulation2 = {
    withOutFile(prefix+"tabulation2"){
       new StringParsersProg with ParsersExp with Sig with MiscOpsExp{ self =>
        val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps{ val IR: self.type = self }

        codegen.emitSource(testRec1 _ , "test-recursion", new java.io.PrintWriter(System.out))
      }
    }
    assertFileEqualsCheck(prefix+"tabulation2")
  }

  def testMatMult1 = {
    withOutFile(prefix+"matmult"){
       new MatMultProg with ParsersExp with Sig with MiscOpsExp{ self =>
        val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps with ScalaGenMiscOps{ val IR: self.type = self }

        codegen.emitSource(testMult1 _ , "test-matmult", new java.io.PrintWriter(System.out))

      }
    }
    assertFileEqualsCheck(prefix+"matmult")
  }

  def testMatMult2 = {
    withOutFile(prefix+"matmult2"){
       new MatMultProg with ParsersExp with Sig with MiscOpsExp{ self =>
        val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps with ScalaGenMiscOps { val IR: self.type = self }

        codegen.emitSource(testMult2 _ , "test-matmult2", new java.io.PrintWriter(System.out))

      }
    }
    assertFileEqualsCheck(prefix+"matmult2")
  }

  def testBottomUp1 = {
    withOutFile(prefix+"bottomup1"){
       new MatMultProg with ParsersExp with Sig with MiscOpsExp with CompileScala{ self =>
        val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps with ScalaGenMiscOps{ val IR: self.type = self }

        codegen.emitSource(testBottomup _ , "test-bottomup1", new java.io.PrintWriter(System.out))

        val testc = compile(testBottomup)
        val res = testc(scala.Array((10,100),(100,5),(5,50)))
        scala.Console.println(res)
        //val input = List((10,100),(100,5),(5,50)).toArray
        //println(parse(input))

      }
    }
    assertFileEqualsCheck(prefix+"bottomup1")
  }

  def testBottomUp2 = {
    withOutFile(prefix+"bottomup2"){
       new MatMultProg with ParsersExp with Sig with MiscOpsExp with CompileScala{ self =>
        val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenHackyRangeOps with ScalaGenTupleOps with ScalaGenMiscOps{ val IR: self.type = self }

        codegen.emitSource(testBottomup2 _ , "test-bottomup2", new java.io.PrintWriter(System.out))

        val testc = compile(testBottomup2)
        val res = testc(scala.Array((10,100),(100,5),(5,50)))
        scala.Console.println(res)

      }
    }
    assertFileEqualsCheck(prefix+"bottomup2")
  }

  def testfold = {
    withOutFile(prefix+"testfold"){
       new ListFoldProg with MyListOpsExp with NumericOpsExp with MiscOpsExp with CompileScala{ self =>
        val codegen = new ScalaGenMyListOps with ScalaGenNumericOps
          with ScalaGenMiscOps{ val IR: self.type = self }

        codegen.emitSource(testListFold _ , "test-fold", new java.io.PrintWriter(System.out))

        val testc = compile(testListFold)
        val res = testc(scala.List(1,2,3,4))
        scala.Console.println(res)

      }
    }
    assertFileEqualsCheck(prefix+"testfold")
  }
}