error: illegal sharing of mutable objects Sym(7)
at Sym(84)=Reflect(Assign(Variable(Sym(79)),Sym(82)),Summary(false,false,false,false,false,List(Sym(79), Sym(7)),List(Sym(79), Sym(7)),List(Sym(79)),List(Sym(79))),List(Sym(7), Sym(78), Sym(79)))
/*****************************************
  Emitting Generated Code
*******************************************/
class testParse extends ((Array[scala.Tuple2[Int, Int]])=>(scala.Tuple3[Int, Int, Int])) {
def apply(x2:Array[scala.Tuple2[Int, Int]]): scala.Tuple3[Int, Int, Int] = {
val x4 = x2.length
val x5 = x4 + 1
val x6 = x5 * x5
val x7 = new Array[scala.Tuple3[Int, Int, Int]](x6)
val x3 = (0,10000,0)
var x9 : Int = 0
val x78 = while (x9 < x5) {
val x10 = x5 - x9
var x12 : Int = 0
val x76 = while (x12 < x10) {
var x14: scala.Tuple3[Int, Int, Int] = x3
val x13 = x9 + x12
val x15 = x12 + 1
val x16 = x15 == x13
val x32 = if (x16) {
val x24 = x14
val x26 = x24._2
val x28 = x26 < 0
val x29 = if (x28) {
x24
} else {
val x17 = x2(x12)
val x21 = x17._1
val x22 = x17._2
val x23 = (x21,0,x22)
x23
}
x14 = x29
()
} else {
()
}
val x18 = x13 - 1
val x19 = x18 + 1
val x20 = x15 < x19
val x35 = x5 * x12
val x71 = if (x20) {
var x34 : Int = x15
val x69 = while (x34 < x19) {
val x36 = x35 + x34
val x37 = x7(x36)
val x38 = x37 != null
val x67 = if (x38) {
val x39 = x5 * x34
val x40 = x39 + x13
val x41 = x7(x40)
val x42 = x41 != null
val x65 = if (x42) {
val x43 = (x37,x41)
val x44 = x43._1
val x45 = x43._2
val x46 = x44._1
val x47 = x44._2
val x48 = x44._3
val x49 = x45._1
val x50 = x45._2
val x51 = x45._3
val x57 = x14
val x52 = x47 + x50
val x53 = x46 * x48
val x54 = x53 * x51
val x55 = x52 + x54
val x59 = x57._2
val x61 = x59 < x55
val x62 = if (x61) {
x57
} else {
val x56 = (x46,x55,x51)
x56
}
x14 = x62
()
} else {
()
}
x65
} else {
()
}
x67
x34 = x34 + 1
}
x69
} else {
()
}
val x73 = x14
val x72 = x35 + x13
val x74 = x7(x72) = x73
()
x12 = x12 + 1
}
x76
x9 = x9 + 1
}
var x79: scala.Tuple3[Int, Int, Int] = x3
val x80 = x5 * 0
val x81 = x80 + x4
val x82 = x7(x81)
val x83 = x82 != null
val x86 = if (x83) {
x79 = x82
()
} else {
()
}
val x87 = x79
x87
}
}
/*****************************************
  End of Generated Code
*******************************************/
error: illegal sharing of mutable objects Sym(93)
at Sym(170)=Reflect(Assign(Variable(Sym(165)),Sym(168)),Summary(false,false,false,false,false,List(Sym(165), Sym(93)),List(Sym(165), Sym(93)),List(Sym(165)),List(Sym(165))),List(Sym(93), Sym(164), Sym(165)))
compilation: ok
(1,122,3)
