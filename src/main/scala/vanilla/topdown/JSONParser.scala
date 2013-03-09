package vanilla.topdown

object JSON extends TokenParsers{

  abstract class JSONTree

  case object StrLit extends JSONTree
  case object NumLit extends JSONTree
  case object Kword extends JSONTree

  case class Value(t: JSONTree) extends JSONTree
  case class Obj(ts: List[JSONTree]) extends JSONTree
  case class Arr(ts: List[JSONTree]) extends JSONTree
  case class Member(s: JSONTree, v: JSONTree) extends JSONTree

  def value(in: Input): Parser[JSONTree] =
    (obj(in) | arr(in) | stringLit(in) ^^^ StrLit
    | numeric(in) ^^^ NumLit | keyword(in) ^^^ Kword) //"null" | "true" | "false"

  def obj(in: Input) : Parser[JSONTree] = (
    ((accept(in, '{') <~ whitespaces(in))
      ~> repsep(member(in), whitespaces(in) ~> accept(in, ',') <~ whitespaces(in))
      <~ accept(in, '}')) ^^ {case xs => Obj(xs)}
  )

  def arr(in: Input) : Parser[JSONTree] = (
    ((accept(in, '[') <~ whitespaces(in))
    ~> repsep(value(in), whitespaces(in) ~> accept(in, ',') <~ whitespaces(in))
    <~ accept(in, ']')) ^^ {case xs => Arr(xs)}
  )

  def member(in: Input) : Parser[JSONTree] = (
    ((stringLit(in) ^^^ StrLit)
    <~ (whitespaces(in) ~> accept(in,':') <~ whitespaces(in)))
    ~ value(in) ^^ {case (x,y) => Member(x,y)}
  )

    val addressbook=
"""{
  "address book": {
    "name": "John Smith",
    "address": {
      "street": "10 Market Street",
      "city" : "San Francisco, CA",
      "zip" : 94111,
    },
    "phone numbers": [
      "408 338-4238",
      "408 111-6892",
    ],
  },
}
""".stripMargin


  def test {

    //NOTE: the repsep combinator has not been implemented correctly,
    //for now we need a trailing comma
    val messages = List(
      ("just a keyword", "true"),
      ("just a literal", "\"passing glance\""),
      ("just a number", "1234"),
      ("a simple array", "[ true, ]"),
      ("more elements in an array", "[ true, false, 12345, \"something more\" , ]"),
      ("a simple object", "{\"name\" : \"bond james bond\", }"),
      ("more elements in an object",
          "{\"name\" : \"bond james bond\", \"age\": 21, \"occupation\" : null, }"),
      ("addressbook", addressbook)

    )

    messages.foreach{case (desc, p) =>
      println(desc)
      println(value(p.toArray)(0))
    }
  }

  def main(args: Array[String]) {
    test
  }
}