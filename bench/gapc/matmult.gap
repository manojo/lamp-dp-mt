type tuple = (int ops, int rows, int cols)

signature Sig(alphabet, answer) {
  answer single(int, char, int);
  answer mult(answer, char, answer);
  choice [answer] h([answer]);
}

algebra minmult implements Sig(alphabet = char, answer = tuple)
{
  tuple single(int r, char a, int c)
  {
    tuple x;
    x.ops = 0;
    x.rows = r;
    x.cols = c;
    return x;
  }
  tuple mult(tuple a, char o, tuple b)
  {
    tuple x;
    x.ops = a.ops + b.ops + a.rows*a.cols*b.cols;
    x.rows = a.rows;
    x.cols = b.cols;
    return x;
  }
  choice [tuple] h([tuple] l)
  {
    return list(minimum(l));
  }
}

algebra count auto count ;

algebra maxmult extends minmult {
  choice [tuple] h([tuple] l)
  {
    return list(maximum(l));
  }
}

// alternative: algebra works on a INT x INT alphabet:
//   -> single(CHAR)

grammar mopt uses Sig(axiom = matrix) {

  matrix = single(INT, CHAR(','), INT) |
           mult(matrix, CHAR(','), matrix)                    # h ;

}

instance minmult = mopt(minmult) ;
instance maxmult = mopt(maxmult) ;
instance count = mopt(count) ;
