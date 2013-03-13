package vanilla.topdown

trait TopDownParsers{
  type Input = Array[Char]
  type Pos = Int


  abstract class Parser[T] extends (Int => Option[(T, Int)]/*Generator[(T, Pos)]*/){self =>
    def ~ [U](that: => Parser[U]) = Parser[(T,U)]{ pos =>
      self(pos) match {
        case None => None
        case Some((res, i)) => that(i).map{
          case (res2, j) => ((res,res2), j)
        }
      }
    }

    def ~> [U](that: => Parser[U]) = Parser[U]{pos =>
      self(pos).flatMap{case (res, i) => that(i)}
    }

    def <~ [U](that: => Parser[U]) = Parser[T]{pos =>
      self(pos) match {
        case None => None
        case Some((res, i)) => that(i).map{
          case (_, j) => (res, j)
        }
      }
    }

    private def map[U](f : T => U) = Parser[U]{ pos =>
      self(pos).map{case (res, i) => (f(res), i)}
    }

    def ^^[U](f : T => U) = self.map(f)
    def ^^^[U](u: U) = self.map(x => u)

    def | (that: => Parser[T]) = Parser[T]{ pos =>
      self(pos) match{
        case None => that(pos)
        case x@Some(_) => x
      }
    }


/*    def fold[U](z:U)(that :=> Parser[T], f: (U,T) => U) = self~that.map{
      case (x,y)
    }
*/
  }


  def failure = Parser{pos => None}
  def debuggable[T](p : => Parser[T]) = Parser{pos =>
    println("we be as position : " + pos)
    p(pos)
  }

  def rep[T](p: => Parser[T]): Parser[List[T]] = Parser[List[T]]{ pos =>
    p(pos) match {
      case None => Some((List(), pos))
      case Some((res, p2)) =>
        rep(p)(p2).map{case (rest, pfin) => (res::rest, pfin)}
    }
  }

  def repsep[T,U](p: => Parser[T], q: =>Parser[U]): Parser[List[T]] =
    rep(p <~  q)

  def Parser[T](f: Int => Option[(T, Int)]) = new Parser[T]{
    def apply(in: Int) = f(in)
  }
}

trait CharParsers extends TopDownParsers{
  type Elem = Char


  def letter(in:Input) = acceptIf(in, _.isLetter)
  def digit(in: Input) = acceptIf(in, _.isDigit) // ^^ { x: Char => (x - '0').toInt }
  def accept(in:Input, e: Elem) = acceptIf(in, _ == e)

  def acceptIf(in:Input, p: Elem => Boolean) = Parser{ i =>
    if(i >= in.length) None
    else if(p(in(i))) Some((in(i), i+1))
    else None
  }

  /*  def el(pos: Pos) = Parser{ in =>

    }
  */

}

trait Tokens{
  abstract class Token
  case class NumericLit(s : String) extends Token
  case class Keyword(s: String) extends Token
  case class StringLit(s: String) extends Token
  case object EOF extends Token
  case object NoToken extends Token

  def processIdent(s: String) = if(s == "true" || s == "null" || s == "false") Keyword(s) else NoToken
}

trait TokenParsers extends TopDownParsers with CharParsers with Tokens{

  def keyword(in:Input) : Parser[Token] = letter(in) ~ rep( letter(in) /*| digit(in)*/ ) ^^ { case (first, rest) => processIdent(first :: rest mkString "")}
  def numeric(in:Input) : Parser[Token] = digit(in) ~ rep(digit(in)) ^^ {case (first, rest) => NumericLit(first::rest mkString "")}
  def stringLit(in:Input) : Parser[Token] = accept(in, '\"') ~> rep( acceptIf(in, _ != '\"')) <~ accept(in, '\"') ^^ {
    xs => StringLit(xs mkString "")
  }
  def whitespaces(in: Input) : Parser[Token] = rep(accept(in, ' ') | accept(in, '\n')) ^^ {xs =>
    NoToken
  }
  /*def token: Parser[Token] =
    ( identChar ~ rep( identChar | digit ) ^^ { case first ~ rest => processIdent(first :: rest mkString "") }
    | digit ~ rep( digit ) ^^ { case first ~ rest => NumericLit(first :: rest mkString "") }
    | '\'' ~ rep( chrExcept('\'', '\n', EofCh) ) ~ '\'' ^^ { case '\'' ~ chars ~ '\'' => StringLit(chars mkString "") }
    | '\"' ~ rep( chrExcept('\"', '\n', EofCh) ) ~ '\"' ^^ { case '\"' ~ chars ~ '\"' => StringLit(chars mkString "") }
    | EofCh ^^^ EOF
    | '\'' ~> failure ^^^ NoToken
    | '\"' ~> failure ^^^ NoToken
    | delim
    | failure("illegal character")
    )
  def word : Parser[String] =
  def stringLit
  */
}

object HelloTopDown extends TokenParsers{

  val message1 = """true
                   |false""".stripMargin
  val message2 = "\"hello carol\""
  val message3 = "   true"
  val message4 = "true,true,true,"
  val message5 = "true ,    true ,   true     ,"

  def repsepkword(in: Input) = repsep(keyword(in), whitespaces(in)~>accept(in, ',')<~whitespaces(in))

  def test1 {
    println("single letter parse")
    println(letter(message1.toArray)(0))

    println("two letter parse")
    println((letter(message1.toArray) ~ letter(message1.toArray))(0))

    println("keyword letter parse")
    println(keyword(message1.toArray)(0))

    println("two words parse")
    println(twoWords(message1.toArray)(0))

    println("string literal parse")
    println(stringLit(message2.toArray)(0))

    println("repsep parse")
    println(repsep(keyword(message4.toArray), accept(message4.toArray, ','))(0))

    println("repsep spaces parse")
    println(repsepkword(message5.toArray)(0))

  }

  def whiteSpaceAndWord(in:Input) = whitespaces(in) ~> keyword(in)
  def twoWords(in:Input) = (keyword(in) <~ whitespaces(in)) ~ keyword(in)
  val aParser = keyword(message1.toArray)


  def main(args: Array[String]){

    test1
   // val r = new StringReader("hello", 0)
   //println("a wa do dem!")
   //println(aParser(0))
   //println(twoWords(message1.toArray)(0))
   //println(whitespaces(message1.toArray)(4))
   //println(whitespaces(message3.toArray)(0))
   //println(whiteSpaceAndWord(message3.toArray)(0))
  }
}