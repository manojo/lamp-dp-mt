package lms2

import scala.virtualization.lms.common._
object MatrixMult2 extends App with Signature with ADPParsers {
  type Alphabet = (Int,Int) // matrix as (rows, columns)
  type Answer = (Int,Int,Int) // rows, cost, columns

  val mAlph = manifest[Alphabet]
  val mAns  = manifest[Answer]

  def single(i: Rep[Alphabet]) = (i._1, unit(0), i._2)
  def mult(l:Rep[Answer], r:Rep[Answer]) = (l._1, l._2 + r._2 + l._1 * l._3 * r._3, r._3)
  def h(a:Rep[Answer],b:Rep[Answer]) = if (a._2 < b._2) a else b

  val axiom:Tabulate = tabulate("M",(
    el ^^ single
  | (axiom ~ axiom) ^^ { x:Rep[(Answer,Answer)] => mult(x._1,x._2) }
  ) aggregate h,true)

  val input = unit(Array((1,2),(2,20),(20,2),(2,4),(4,2),(2,1),(1,7),(7,3))) // -> 1x3 matrix, 122 multiplications
  val (score,bt) = backtrack(input).head
  println("Score     : "+score)
  println("Backtrack : "+bt)
  println("Reapply   : "+build(input,bt))
}
