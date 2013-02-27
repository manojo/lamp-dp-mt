package lms

import scala.virtualization.lms.common._
import java.io.{File, FileWriter, PrintWriter}
import scala.reflect.SourceContext

trait ListToGenTransform extends HackyRangeOpsExp
with GeneratorOpsExp with ModListOpsExp with IfThenElseExp{

  def transform[A: Manifest](ls: Exp[List[A]]) : Generator[A] = ls match {
    case Def(ListNew(xs)) => fromSeq(xs)
    case Def(RangetoList(Def(Until(start, end)))) => range(start,end).asInstanceOf[Generator[A]]
    case Def(ListConcat(xs, ys)) => transform(xs) ++ transform(ys)
    case Def(ListMap(xs, x, b)) => b match {
      //effect free block => make changes, otherwise empty gen
      case Block(Def(a)) => transform(xs).map{y => Let(x, y, b)}
    }
    case Def(ListFilter(xs, x, b)) => b match {
      //effect free block => make changes, otherwise empty gen
      case Block(Def(a)) => transform(xs).filter{y => Let(x, y, b)}
    }

    case Def(MyListFlatMap(xs, f)) =>
      transform(xs).flatMap{x => transform(f(x))}

    /*case Def(ListFlatMap(l, x, b)) => b match{
      case Block(Def(xs)) =>
        val ltrans = transform(l)
        val xstrans = transform(xs)

        ltrans.flatMap{y => xstrans.map{z => }}
    }*/

    case Def(MyListMap(xs,f)) => transform(xs).map(f)
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
      case _ => emptyGen() //error case
    }
    case _ => emptyGen()
  }
}