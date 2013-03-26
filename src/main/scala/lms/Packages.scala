package lms
import scala.virtualization.lms.common._
import scala.reflect.RefinedManifest

trait Package extends ScalaOpsPkg with MyRangeOps with MyListOps /*with LiftScala*/ {

}

trait PackageExp extends ScalaOpsPkgExp with MyRangeOpsExp with MyListOpsExp {

}

trait ScalaGenPackage extends ScalaCodeGenPkg with ScalaGenMyRangeOps with ScalaGenMyListOps {
  val IR: ScalaOpsPkgExp with MyRangeOpsExp with MyListOpsExp
}

trait CGenPackage extends CCodeGenPkg with CGenTupleOps with MyCGenArrayOps{
  val IR: PackageExp
  import IR._

  override def remap[A](m: Manifest[A]) : String = {
    m.toString match {
      case "Char" => "char"
      case _ => super.remap(m)
    }
  }

  override def emitNode(sym: Sym[Any], rhs: Def[Any]) = {
    rhs match {
      case BooleanAnd(lhs,rhs) => emitValDef(sym, quote(lhs) + " && " + quote(rhs))
      case BooleanOr(lhs,rhs) => emitValDef(sym, quote(lhs) + " || " + quote(rhs))
      case _ => super.emitNode(sym,rhs)
    }
  }
}
