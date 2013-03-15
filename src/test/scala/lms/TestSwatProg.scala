package lms

import scala.virtualization.lms.common._
import scala.virtualization.lms.internal._
import scala.virtualization.lms.util.OverloadHack
import java.io.PrintWriter
import java.io.StringWriter
import java.io.FileOutputStream
import scala.reflect.SourceContext

import scala.virtualization.lms.internal.GraphVizExport

trait SwatProg extends Variables with While with LiftVariables with ReadVarImplicit
  with RangeOps with NumericOps with OrderingOps with IfThenElse
  with PrimitiveOps with Equal with Structs with MiscOps
  with TupleOps with ArrayOps with MathOps with BooleanOps with OverloadHack{

  def matchQ(i : Rep[Int], j: Rep[Int]) : Rep[Int] = {
    if(i == j) unit(15) else unit(-12)
  }

  def computeElem(m: Rep[Array[Array[Int]]], matchq: Rep[Array[Array[Int]]],
                  i: Rep[Int], j: Rep[Int],
                  x:Rep[Array[Int]], y:Rep[Array[Int]]) : Rep[Int] = {
    if(i == 0) unit(0)
    else if(unit(1) <= i && j == unit(0)) unit(0)
    else if(unit(1) <= i && unit(1) <= j) {
      Math.max(Math.max(unit(0), m(i).apply(j - unit(1)) - unit(8)),
               Math.max(m(i - unit(1)).apply(j) - unit(8), m(i - unit(1)).apply(j - unit(1)) + matchQ(i, j))

      )
    }
    else unit(-1)
  }

  def bla(x:Rep[Array[Int]], y:Rep[Array[Int]]) : Rep[Int] = {
    val m: Rep[Array[Array[Int]]] = NewArray(x.length)
    (unit(0) until m.length).foreach{i =>
      m(i) = NewArray(y.length)
    }

    val matchq : Rep[Array[Array[Int]]] = NewArray(x.length)
    (unit(0) until matchq.length).foreach{i =>
      matchq(i) = NewArray(y.length)
    }

    computeElem(m, matchq,
                      unit(10), unit(1000),
                      x, y)
  }

/*  def testSwat(x:Rep[Array[Int]], y:Rep[Array[Int]]): Rep[Int] = {
    val m: Rep[Array[Array[Int]]] = NewArray(x.length)
    (unit(0) until m.length).foreach{i =>
      m(i) = NewArray(y.length)
    }

    val matchq : Rep[Array[Array[Int]]] = NewArray(x.length)
    (unit(0) until matchq.length).foreach{i =>
      matchq(i) = NewArray(y.length)
    }


    //solving
    (unit(0) until m.length).foreach{i =>
      (unit(0) until m(unit(0)).length).foreach{ j=>
        m(i).apply(j) = computeElem(m, matchq, i, j, x, y)
      }
    }

    m(x.length).apply(y.length)
  }
  */
}

trait SwatGenAlpha extends ScalaGenWhile with ScalaGenVariables
          with ScalaGenRangeOps with ScalaGenNumericOps
          with ScalaGenOrderingOps with ScalaGenPrimitiveOps
          with ScalaGenEqual with ScalaGenIfThenElse with ScalaGenArrayOps
          with ScalaGenStruct with ScalaGenMiscOps
          with ScalaGenTupleOps with ScalaGenMathOps with ScalaGenBooleanOps{

  val IR: EffectExp with VariablesExp with RangeOpsExp
        with WhileExp with NumericOpsExp with OrderingOpsExp
        with IfThenElseExp with PrimitiveOpsExp with EqualExp
        with StructExp with StructExpOptCommon with ArrayOpsExp
        with MiscOpsExp with TupleOpsExp with MathOpsExp with BooleanOpsExp
  import IR._

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
   // case Reflect(RangeForeach(Const(0),Sym(13),Sym(15),Block(Sym(18))),Summary(false,false,false,false,false,List(Sym(12)),List(),List(Sym(12)),List()),List(Sym(12), Sym(13))))
    //case IfThenElse(cond,thenE,elseE) =>
    case Equal(x,y) => stream.print("%s = %s".format(myquote(x), myquote(y)))
    case OrderingLTEQ(x,y) => stream.print("%s <= %s".format(myquote(x), myquote(y)))
    case BooleanAnd(x,y) => stream.print("%s : %s".format(quote(x), quote(y)))
    case ArrayApply(arr,elem) => stream.print("%s[%s]".format(quote(arr), myquote(elem)))
    case NumericMinus(x,y) => stream.print("%s - %s".format(quote(x), quote(y)))
    case NumericPlus(x,y) => stream.print("%s + %s".format(quote(x), quote(y)))

    case MathMax(x,y) => stream.print("max(%s,%s)".format(quote(x), quote(y)))

    case _ => super.emitNode(sym, rhs)
  }

  override def quote(x: Exp[Any]) : String = x match {
    case Const(i: Int) => i.toString + "[]"
    case _ => super.quote(x)
  }

  def myquote(x: Exp[Any]) : String = super.quote(x)

}

class TestSwatProg extends FileDiffSuite {

  val prefix = "test-out/"

  def testcomputeElem = {
    withOutFile(prefix+"swat-scala"){
       new SwatProg with EffectExp with VariablesExp with RangeOpsExp
        with WhileExp with NumericOpsExp with OrderingOpsExp
        with IfThenElseExp with PrimitiveOpsExp with EqualExp
        with StructExp with StructExpOptCommon with ArrayOpsExp
        with MiscOpsExp with TupleOpsExp with MathOpsExp with BooleanOpsExp with MyScalaCompile{ self =>

        val printWriter = new java.io.PrintWriter(System.out)

        val gviz = new GraphVizExport {
          val IR: self.type = self
        }


        //override val verbosity = 2

        //test1: mat mult
        val codegen = new SwatGenAlpha{ val IR: self.type = self }

         val s1 = fresh[Array[Int]]
         val s2 = fresh[Array[Int]]
         val body = codegen.reifyBlock(bla(s1, s2))
        codegen.buildScheduleForResult(body) foreach {x => Console.println(x)}
        //gviz.emitDepGraph(body, "test-out/swat")

        codegen.emitSource2(bla _ , "computeElem", printWriter)
      }
    }
    assertFileEqualsCheck(prefix+"swat-scala")
  }
}