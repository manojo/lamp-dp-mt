package lms
import scala.virtualization.lms.common._

trait Package extends ScalaOpsPkg with MyRangeOps with MyListOps /*with LiftScala*/ {

}

trait PackageExp extends ScalaOpsPkgExp with MyRangeOpsExp with MyListOpsExp {

}

trait ScalaGenPackage extends ScalaCodeGenPkg with ScalaGenMyRangeOps with ScalaGenMyListOps {
  val IR: ScalaOpsPkgExp with MyRangeOpsExp with MyListOpsExp
}

trait CGenPackage extends CCodeGenPkg with CGenTupleOps with MyCGenArrayOps{
  val IR: PackageExp
}
