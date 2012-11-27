import scala.language.implicitConversions
object Foo extends App {
  val cyclic=false

  case class Parser(x:Int)

  class ParserADP(p: Parser) {
    def ~~+(that:Parser) = p.x+that.x
  }
  implicit def parserADP(p:Parser) = new ParserADP(p)

  class ParserTT(p: Parser) {
    def ~~(that:Parser) = p.x+that.x
  }
  implicit def parserTT(p:Parser) = new ParserTT(p)

  println( new Parser(3) ~~ new Parser(5) )

}
