package lms.topdown

import lms._
import scala.virtualization.lms.common._
import scala.virtualization.lms.internal.Effects

trait TopDownParsers extends Package with GeneratorOps with LiftVariables{
  type Input = Array[Char]
  type Pos = Int


  abstract class Parser[T:Manifest] extends (Rep[Int] => Generator[(T, Int)]){self =>
    def ~ [U:Manifest](that: Parser[U]) = Parser[(T,U)]{ pos =>
      self(pos).flatMap{ x:Rep[(T,Int)] =>
        that(x._2).map{ y:Rep[(U,Int)] =>
          (make_tuple2(x._1, y._1), y._2)
        }
      }
    }

    def ~> [U:Manifest](that: => Parser[U]) = Parser[U]{pos =>
      self(pos).flatMap{x: Rep[(T,Int)] => that(x._2)}
    }

    def <~ [U:Manifest](that: => Parser[U]) = Parser[T]{pos =>
      self(pos).flatMap{ x:Rep[(T,Int)] =>
        that(x._2).map{ y:Rep[(U,Int)] =>
          make_tuple2(x._1, y._2)
        }
      }
    }

    private def map[U:Manifest](f : Rep[T] => Rep[U]) = Parser[U]{ pos =>
      self(pos).map{x:Rep[(T,Int)] => (f(x._1), x._2)}
    }

    def ^^[U:Manifest](f : Rep[T] => Rep[U]) = self.map(f)
    def ^^^[U:Manifest](u: Rep[U]) = self.map(x => u)

    def | (that: Parser[T]) = Parser[T]{ pos =>
      self(pos) ++ that(pos)
    }
  }


  /*def failure = Parser{pos => None}
  def debuggable[T](p : => Parser[T]) = Parser{pos =>
    println("we be as position : " + pos)
    p(pos)
  }*/

  def rep[T:Manifest](p : Parser[T]): Parser[List[T]] = Parser[List[T]]{ pos =>
    var s = List[T]().asInstanceOf[Rep[List[T]]]
    var old = unit(-1)
    var cur = pos

    while(old != cur){
      old = cur
      p(cur).apply{ x: Rep[(T, Int)] =>
        s = s ++ List(x._1)
        cur = x._2
      }
    }

    elGen(make_tuple2(readVar(s), cur))
  }

  def repsep[T:Manifest,U:Manifest](p: => Parser[T], q: =>Parser[U]): Parser[List[T]] =
    rep(p <~  q)

  def Parser[T:Manifest](f: Rep[Int] => Generator[(T, Int)]) = new Parser[T]{
    def apply(i: Rep[Int]) = f(i)
  }
}

trait CharParsers extends TopDownParsers{
  type Elem = Char

  def isLetter(c: Rep[Char]) : Rep[Boolean] =
    c >= unit('a') && c <= unit('z')

  def isDigit(c: Rep[Char]) : Rep[Boolean] =
    c >= unit('0') && c <= unit('9')

  def letter(in:Rep[Input]): Parser[Char] = acceptIf(in, (c: Rep[Char]) => isLetter(c))
  def digit(in: Rep[Input]): Parser[Char] = acceptIf(in, (c: Rep[Char]) => isDigit(c)) // ^^ { x: Char => (x - '0').toInt }
  def accept(in:Rep[Input], e: Rep[Elem]): Parser[Char] = acceptIf(in, (c: Rep[Char]) => c == e)

  def acceptIf(in:Rep[Input], p: Rep[Elem] => Rep[Boolean]) = Parser[Char]{ i =>
    cond(i >= in.length,
      emptyGen[(Char,Int)](),
      cond(p(in(i)),
        elGen((in(i), i+unit(1))),
        emptyGen[(Char,Int)]()
      )
    )
  }
}

/*trait Tokens{
  abstract class Token
  case class NumericLit(s : String) extends Token
  case class Keyword(s: String) extends Token
  case class StringLit(s: String) extends Token
  case object EOF extends Token
  case object NoToken extends Token


}*/

trait TokenParsers extends TopDownParsers with CharParsers{

  def processIdent(s: Rep[String]) = if(s == "true" || s == "null" || s == "false") unit("Keyword") + s else unit("NoToken")

  def keyword(in:Rep[Input]) : Parser[String] = letter(in) ~ rep( letter(in) /*| digit(in)*/ ) ^^ {
    x : Rep[(Char, List[Char])] => processIdent((x._1 :: x._2).mkString)
  }

  def numeric(in:Rep[Input]) : Parser[String] = digit(in) ~ rep(digit(in)) ^^ {
    x : Rep[(Char, List[Char])] => unit("NumericLit(") + (x._1::x._2).mkString + unit(")")
  }

  def stringLit(in:Rep[Input]) : Parser[String] =
    accept(in, unit('\"')) ~> rep( acceptIf(in, (x:Rep[Char]) => x != unit('\"'))) <~ accept(in, unit('\"')) ^^ {
      xs: Rep[List[Char]] => unit("StringLit(") + xs.mkString + unit(")")
    }

  def whitespaces(in: Rep[Input]) : Parser[String] =
    (rep(accept(in, unit(' ')) | accept(in, unit('\n')))) ^^^ {unit("")}
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