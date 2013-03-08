package lms

import scala.virtualization.lms.common._
import java.io.{File, FileWriter, PrintWriter}
import scala.reflect.SourceContext

import scala.virtualization.lms.internal.Effects
import scala.virtualization.lms.internal.GraphVizExport

trait ListToGenTransform extends MyRangeOpsExp
with GeneratorOpsExp with MyListOpsExp with IfThenElseExp{ self =>

  val gviz = new GraphVizExport {
    val IR: self.type = self
  }
  var i : Int = 1

  def transform[A: Manifest](ls: Exp[List[A]]) : Generator[A] = {

    //debugging
    //Console.println("in transform function")
    //Console.println(ls match { case Def(xs) => xs})
    //gviz.emitDepGraph(ls, "test-out/transforming-dot"+i); i+= 1

    val ls1 = ls match {
      case Def(Reflect(d, _, _)) =>
        //trick to throw away un-needed effects!! :-)
        context = context filterNot (_ == ls)
        Some(d)
      case Def(d) => Some(d)
      case _ => None
    }

    val res = ls1 map {
      case (ListNew(xs)) => fromSeq(xs)
      case (RangetoList(Def(Until(start, end)))) => range(start,end).asInstanceOf[Generator[A]]
      case (ListConcat(xs, ys)) => transform(xs) ++ transform(ys)
      case (ListMap(xs, x, b)) => b match {
        //effect free block => make changes, otherwise empty gen
        case Block(Def(a)) => transform(xs).map{y => let(x, y, a)}
      }
      case (ListFilter(xs, x, b)) => b match {
        //effect free block => make changes, otherwise empty gen
        case Block(Def(a)) => transform(xs).filter{y => let(x, y, a)}
      }

      case ListReduce(xs, x, y, Block(Def(bd)), z) => transform(xs).reduce((a,b) => let(x,a,let(y,b,bd)), z)

      //case Def(MyListFlatMap(xs, f)) =>
        //transform(xs).flatMap{x => transform(f(x))}

      case (ListFlatMap(l, x, b: Block[List[A]])) => b match {
        case Block(xs) =>
        transform(l).flatMap{ y =>
          new Generator[A]{
            def apply(f: Rep[A] => Rep[Unit]) = {
              let(x,y, transform(xs).apply(f))
            }
          }
        }
      }
   //     transform(l).flatMap{y => transform(Let(x, y, b))}

      /*case Def(Let(x, y, b: Block[List[A]])) => b match{
        case Block(Def(xs)) => new Generator[A]{
          def apply(f: Rep[A] => Rep[Unit]) = {
            val tmp = transform(xs)
            Let(x,y, reifyEffects(tmp(f)))
          }
        }
      }*/


  //    case Def(MyListMap(xs,f)) => transform(xs).map(f)
      case (IfThenElse(c, t, e)) => (t,e) match {
        case(Block(Def(tp)), Block(Def(ep))) => new Generator[A]{
          def apply(f: Rep[A] => Rep[Unit]) =
            if(c){
              val t1 = transform(tp)
              t1(f)
            }else{
              val t2 = transform(ep)
              t2(f)
            }
        }
        case _ => assert(false, "no match"); emptyGen() //error case
      }

      case (Reify(xs, _, _)) =>
        transform(xs)

      //case _ => assert(false, "no match"); emptyGen() //error case
    }

    //debugging
    //gviz.emitDepGraph(res, prefix+"after-dot")
    res.get
  }
}