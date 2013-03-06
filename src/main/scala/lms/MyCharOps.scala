package lms

import java.io.PrintWriter

import scala.virtualization.lms.common._
import scala.virtualization.lms.util.OverloadHack
import scala.virtualization.lms.internal.{GenericNestedCodegen, GenerationFailedException}
import scala.reflect.SourceContext

trait MyCharOps extends Variables with OverloadHack {
  def char_toInt(c: Rep[Char])(implicit pos: SourceContext): Rep[Int]
  def infix_toInt(c: Rep[Char])(implicit pos: SourceContext) = char_toInt(c)
}

trait MyCharOpsExp extends MyCharOps with VariablesExp{

  case class CharToInt(c: Exp[Char]) extends Def[Int]

  def char_toInt(c: Rep[Char])(implicit pos: SourceContext) =
    CharToInt(c)
}

trait ScalaGenMyCharOps extends ScalaGenBase{
  val IR: MyCharOpsExp
  import IR._

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = rhs match {
    case CharToInt(c) =>  emitValDef(sym, "%s.toInt".format(quote(c)))
    case _ => super.emitNode(sym, rhs)
  }
}