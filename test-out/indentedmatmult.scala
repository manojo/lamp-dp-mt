/*****************************************
  Emitting Generated Code
*******************************************/
class test-matmult2 extends ((Array[scala.Tuple2[Int, Int]])=>(scala.Tuple3[Int, Int, Int])) {
def apply(x0:Array[scala.Tuple2[Int, Int]]): scala.Tuple3[Int, Int, Int] = {
val x1 = x0.length
val x2 = x1 + 1
val x3 = new Array[Array[scala.Tuple3[Int, Int, Int]]](x2)
var x5 : Int = 0
val x9 = while (x5 < x2) {
val x6 = new Array[scala.Tuple3[Int, Int, Int]](x2)
val x7 = x3(0) = x6
x7
x5 = x5 + 1
}
val x10 = 0 <= x1
val x80 = if (x10) {
val x11 = x3(0)
val x23 = 0 < x1
val x12 = 0 + 1
val x65 = if (x23) {
val x24 = 0 == 0
val x27 = if (x24) {
x12
} else {
val x25 = x1 - 0
val x26 = java.lang.Math.max(x12, x25)
x26
}
val x31 = if (x24) {
val x28 = x1 - 1
x28
} else {
val x28 = x1 - 1
val x29 = 0 + 0
val x30 = java.lang.Math.min(x28, x29)
x30
}
val x32 = x31 + 1
val x33 = x27 until x32
val x34 = x33.toList
val x16 = List()
val x63 = x34.map{
x35 =>
val x36 = 0 <= x35
val x41 = if (x36) {
val x37 = x3(0)
val x38 = x37(x35)
val x39 = List(x38)
x39
} else {
x16
}
val x43 = x35 <= x1
val x48 = if (x43) {
val x44 = x3(x35)
val x45 = x44(x1)
val x46 = List(x45)
x46
} else {
x16
}
val x42 = x41.head
val x51 = x42._1
val x49 = x48.head
val x56 = x49._3
val x52 = x42._2
val x55 = x49._2
val x57 = x52 + x55
val x53 = x42._3
val x58 = x51 * x53
val x59 = x58 * x56
val x60 = x57 + x59
val x61 = (x51,x60,x56)
x61
}
x63
} else {
val x16 = List()
x16
}
val x13 = x12 == x1
val x17 = if (x13) {
val x14 = x0(0)
val x15 = List(x14)
x15
} else {
val x16 = List()
x16
}
val x22 = x17.map{
x18 =>
val x19 = x18._1
val x20 = x18._2
val x21 = (x19,0,x20)
x21
}
val x66 = x22 ::: x65
val x67 = x66.isEmpty
val x74 = if (x67) {
x66
} else {
val x72 = x66.minBy{
x68 =>
val x70 = x68._2
x70
}
val x73 = List(x72)
x73
}
val x75 = x74.head
val x76 = x11(x1) = x75
val x77 = x11(x1)
val x78 = List(x77)
x78
} else {
val x16 = List()
x16
}
val x81 = x80.head
x81
}
}
/*****************************************
  End of Generated Code
*******************************************/
