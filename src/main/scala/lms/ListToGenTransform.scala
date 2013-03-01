package lms

import scala.virtualization.lms.common._
import java.io.{File, FileWriter, PrintWriter}
import scala.reflect.SourceContext

trait ListToGenTransform extends HackyRangeOpsExp
with GeneratorOpsExp with MyListOpsExp with IfThenElseExp{

  def transform[A: Manifest](ls: Exp[List[A]]) : Generator[A] = ls match {
    case Def(ListNew(xs)) => fromSeq(xs)
    case Def(RangetoList(Def(Until(start, end)))) => range(start,end).asInstanceOf[Generator[A]]
    case Def(ListConcat(xs, ys)) => transform(xs) ++ transform(ys)
    case Def(ListMap(xs, x, b)) => b match {
      //effect free block => make changes, otherwise empty gen
      case Block(Def(a)) => transform(xs).map{y => let(x, y, a)}
    }
    case Def(ListFilter(xs, x, b)) => b match {
      //effect free block => make changes, otherwise empty gen
      case Block(Def(a)) => transform(xs).filter{y => let(x, y, a)}
    }

    //case Def(MyListFlatMap(xs, f)) =>
      //transform(xs).flatMap{x => transform(f(x))}

    //TODO: fix, not working yet ...
    case Def(ListFlatMap(l, x, b: Block[List[A]])) => b match {
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
    case Def(IfThenElse(c, t, e)) => (t,e) match {
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
    case _ => assert(false, "no match"); emptyGen() //error case
  }
}