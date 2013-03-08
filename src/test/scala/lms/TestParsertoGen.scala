package lms

import scala.virtualization.lms.common._
import java.io.PrintWriter
import java.io.FileOutputStream



//matrix multiplication List to Gen
trait MatMultToGenProg extends Parsers{ this: Sig =>
  type Alphabet = (Int,Int)
  val mAlph = manifest[(Int,Int)]

  type Answer = (Int, Int, Int)
  val mAns = manifest[(Int,Int,Int)]

  def single(i: Rep[(Int,Int)]) =
    (i._1, unit(0), i._2)

  def mult(l: Rep[Answer],r : Rep[Answer]) = {
    (l._1, l._2 + r._2 + l._1 * l._3 * r._3 ,r._3)
  }
}

//ElMamun
trait ElMamunToGenProg extends LexicalParsers with MyCharOps{ this: Sig =>

  type Answer = Int
  val mAns = manifest[Int]

  def isDigit(c: Rep[Char]) : Rep[Boolean] = {
    c >= unit('0') && c < unit('9')
  }

  def add(i: Rep[Answer], j:Rep[Answer]) = i+j
  def mult(l: Rep[Answer],r : Rep[Answer]) = l * r
}

class TestParsersToGen extends FileDiffSuite {

  val prefix = "test-out/"

  //listogen transform
  def testParserToGenMatmult = {
    withOutFile(prefix+"parser-to-gen-matmult"){
       new MatMultToGenProg with ParsersExp with Sig with MiscOpsExp
        with ListToGenTransform with CompileScala{ self =>
        val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenMyRangeOps with ScalaGenTupleOps with ScalaGenMiscOps
          with ScalaGenGeneratorOps{ val IR: self.type = self }


        def multParser(in:Input, a: Rep[Array[Array[Answer]]]) : TabulatedParser2 = {
          lazy val p /*: Parser[Answer]*/ : TabulatedParser2 = tabulate2(
           (el(in) ^^ single
            | (p +~+ p) ^^ {(x: Rep[(Answer,Answer)]) => mult(x._1,x._2)}
           ),//.aggfold((unit(0),unit(100000),unit(0)), (x,y) => if(x._2 < y._2) x else y),
           "mat",
           a,
           (unit(0),unit(100000),unit(0)),
           (x,y) => if(x._2 < y._2) x else y
          )
         p
        }

        def bottomUp2(in: Input, p :  => TabulatedParser2,
            costMatrix: Rep[Array[Array[Answer]]], z: Rep[Answer])(implicit mAlph: Manifest[Alphabet], mA: Manifest[Answer]) : Rep[Answer] = {
          (1 until in.length + 1).foreach{l =>
            (0 until in.length + 1 -l).foreach{i =>
              val j = i+l

              var s = z
              val res = p(i,j)

              val genned = transform(res)
              genned{x : Rep[Answer] =>
                if(x._2 < readVar(s)._2) s = x
              }

              val a = costMatrix(i);a(j) = s
            }
          }
          val temp = costMatrix(0);temp(in.length)
        }

        //with listtogen transform
        def testBottomup3(in: Input): Rep[Answer] = {
          val a : Rep[Array[Array[Answer]]] = NewArray(in.length+1)
          (0 until in.length + 1).foreach{ i=>
            a(i) = NewArray(in.length+1)
          }

          val mParser = multParser(in, a)
          val res = bottomUp2(in,mParser,a, (unit(0), unit(100000), unit(0)))(mAlph, mAns)
          res
        }

        codegen.emitSource(testBottomup3 _ , "parser-to-gen-matmult", new java.io.PrintWriter(System.out))

        val testc = compile(testBottomup3)
        val res = testc(scala.Array((10,100),(100,5),(5,50)))
        scala.Console.println(res)

      }
    }
    assertFileEqualsCheck(prefix+"parser-to-gen-matmult")
  }


  //el mamun as a second test
  def testParserToGenElMamun = {
    withOutFile(prefix+"parser-to-gen-elmamun"){
       new ElMamunToGenProg with ParsersExp with Sig with MiscOpsExp
        with ListToGenTransform with MyCharOpsExp with CompileScala{ self =>
        val codegen = new ScalaGenArrayOps with ScalaGenMyListOps with ScalaGenNumericOps with ScalaGenIfThenElse with ScalaGenBooleanOps
          with ScalaGenEqual with ScalaGenOrderingOps with ScalaGenMathOps
          with ScalaGenMyRangeOps with ScalaGenTupleOps with ScalaGenMiscOps
          with ScalaGenGeneratorOps with ScalaGenMyCharOps{ val IR: self.type = self }


        def billGrammar(in:Input, a: Rep[Array[Array[Answer]]]) : TabulatedParser2 = {
          def plus = charf(in, {x: Rep[Char] => x == unit('+')})
          def times = charf(in, {x: Rep[Char] => x == unit('*')})

          lazy val p : TabulatedParser2 = tabulate2(
           (charf(in, {x: Rep[Char] => isDigit(x)}) ^^ {x: Rep[Char] => (x.toInt - unit('0'.toInt))}
           | (p ~~- plus ~~~ p) ^^ {x:Rep[((Answer,Alphabet),Answer)] => add(x._1._1, x._2)}
           | (p ~~- times ~~~ p) ^^ {x:Rep[((Answer,Alphabet),Answer)] => mult(x._1._1, x._2)}
           ),
           "mat",
           a,
           unit(0),
           (x,y) => if(x > y) x else y
          )
         p
        }

        def bottomUp2(in: Input, p :  => TabulatedParser2,
            costMatrix: Rep[Array[Array[Answer]]], z: Rep[Answer])(implicit mAlph: Manifest[Alphabet], mA: Manifest[Answer]) : Rep[Answer] = {
          (1 until in.length + 1).foreach{l =>
            (0 until in.length + 1 -l).foreach{i =>
              val j = i+l

              var s = z
              val res = p(i,j)

              val genned = transform(res)
              genned{x : Rep[Answer] =>
                if(x > s) s = x
              }

              val a = costMatrix(i);a(j) = s
            }
          }
          val temp = costMatrix(0);temp(in.length)
        }

        //with listtogen transform
        def testBottomup3(in: Input): Rep[Answer] = {
          val a : Rep[Array[Array[Answer]]] = NewArray(in.length+1)
          (0 until in.length + 1).foreach{ i=>
            a(i) = NewArray(in.length+1)
          }

          val mParser = billGrammar(in, a)
          val res = bottomUp2(in,mParser,a, unit(0))(mAlph, mAns)
          res
        }

        codegen.emitSource(testBottomup3 _ , "parser-to-gen-matmult", new java.io.PrintWriter(System.out))

        val testc = compile(testBottomup3)
        val res = testc("1+2*3*4+5".toArray)
        scala.Console.println(res)

      }
    }
    assertFileEqualsCheck(prefix+"parser-to-gen-elmamun")
  }
}