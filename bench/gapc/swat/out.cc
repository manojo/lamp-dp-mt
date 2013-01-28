
// A dynamic programming evaluator generated by GAP-C.
// 
//   GAP-C version:
//     gapc-2012.07.23
// 
//   GAP-C call:
//     gapc -t -i affine affine.gap 
// 
// 


#define GAPC_MOD_TRANSLATION_UNIT
#include "out.hh"

#include <rtlib/subopt.hh>

#include <rtlib/generic_opts.hh>

int &  out::nt_alignment(unsigned int t_0_i, unsigned int t_1_i)
{
  if (alignment_table.is_tabulated(t_0_i, t_1_i))
    {
      return alignment_table.get(t_0_i, t_1_i);
    }

  int answers;
  empty(answers);
  empty( answers);
  int ret_0;
  if ((((t_0_right_most - t_0_i) >= 0) && ((t_1_right_most - t_1_i) >= 0)))
  {
    int ret_2 = SEQ(t_0_seq, t_0_i, t_0_right_most);
    int ret_1_0 = ret_2;
    int ret_3 = SEQ(t_1_seq, t_1_i, t_1_right_most);
    int ret_1_1 = ret_3;
    int a_0_0 = ret_1_0;
    int a_0_1 = ret_1_1;
    if ((is_not_empty(a_0_0) && is_not_empty(a_0_1)))
      {
        ret_0 = nil(a_0_0, a_0_1);
      }

    else
      {
        empty( ret_0);
      }

    erase( a_0_0);
    erase( a_0_1);
  }

  else
    {
      empty( ret_0);
    }

  if (is_not_empty(ret_0))
    {
      push_back_max( answers, ret_0);
    }

  int ret_4;
  if ((((t_0_right_most - t_0_i) >= 1) && ((t_1_right_most - t_1_i) >= 0)))
  {
    int ret_8 = nt_xDel((t_0_i + 1), t_1_i);
    int a_2 = ret_8;
    if (is_not_empty(a_2))
    {
      char ret_6 = CHAR(t_0_seq, t_0_i, (t_0_i + 1));
      char ret_5_0 = ret_6;
      bool ret_7 = EMPTY(t_1_seq, t_1_i, t_1_i);
      bool ret_5_1 = ret_7;
      char a_1_0 = ret_5_0;
      bool a_1_1 = ret_5_1;
      if ((is_not_empty(a_1_0) && is_not_empty(a_1_1)))
        {
          ret_4 = del(a_1_0, a_1_1, a_2);
        }

      else
        {
          empty( ret_4);
        }

      erase( a_1_0);
      erase( a_1_1);
    }

    else
      {
        empty( ret_4);
      }

    erase( a_2);
  }

  else
    {
      empty( ret_4);
    }

  if (is_not_empty(ret_4))
    {
      push_back_max( answers, ret_4);
    }

  int ret_9;
  if ((((t_0_right_most - t_0_i) >= 0) && ((t_1_right_most - t_1_i) >= 1)))
  {
    int ret_13 = nt_xIns(t_0_i, (t_1_i + 1));
    int a_4 = ret_13;
    if (is_not_empty(a_4))
    {
      bool ret_11 = EMPTY(t_0_seq, t_0_i, t_0_i);
      bool ret_10_0 = ret_11;
      char ret_12 = CHAR(t_1_seq, t_1_i, (t_1_i + 1));
      char ret_10_1 = ret_12;
      bool a_3_0 = ret_10_0;
      char a_3_1 = ret_10_1;
      if ((is_not_empty(a_3_0) && is_not_empty(a_3_1)))
        {
          ret_9 = ins(a_3_0, a_3_1, a_4);
        }

      else
        {
          empty( ret_9);
        }

      erase( a_3_0);
      erase( a_3_1);
    }

    else
      {
        empty( ret_9);
      }

    erase( a_4);
  }

  else
    {
      empty( ret_9);
    }

  if (is_not_empty(ret_9))
    {
      push_back_max( answers, ret_9);
    }

  int ret_14;
  if ((((t_0_right_most - t_0_i) >= 1) && ((t_1_right_most - t_1_i) >= 1)))
  {
    int ret_18 = nt_alignment((t_0_i + 1), (t_1_i + 1));
    int a_6 = ret_18;
    if (is_not_empty(a_6))
    {
      char ret_16 = CHAR(t_0_seq, t_0_i, (t_0_i + 1));
      char ret_15_0 = ret_16;
      char ret_17 = CHAR(t_1_seq, t_1_i, (t_1_i + 1));
      char ret_15_1 = ret_17;
      char a_5_0 = ret_15_0;
      char a_5_1 = ret_15_1;
      if ((is_not_empty(a_5_0) && is_not_empty(a_5_1)))
        {
          ret_14 = match(a_5_0, a_5_1, a_6);
        }

      else
        {
          empty( ret_14);
        }

      erase( a_5_0);
      erase( a_5_1);
    }

    else
      {
        empty( ret_14);
      }

    erase( a_6);
  }

  else
    {
      empty( ret_14);
    }

  if (is_not_empty(ret_14))
    {
      push_back_max( answers, ret_14);
    }

  int eval = h(answers);
  erase( answers);
  alignment_table.set( t_0_i, t_1_i, eval);
  return alignment_table.get(t_0_i, t_1_i);
}

int out::nt_skipL(unsigned int t_0_i, unsigned int t_1_i)
{
  int answers;
  empty(answers);
  empty( answers);
  int ret_0;
  if ((((t_0_right_most - t_0_i) >= 1) && ((t_1_right_most - t_1_i) >= 0)))
  {
    int ret_4 = nt_skipL((t_0_i + 1), t_1_i);
    int a_1 = ret_4;
    if (is_not_empty(a_1))
    {
      char ret_2 = CHAR(t_0_seq, t_0_i, (t_0_i + 1));
      char ret_1_0 = ret_2;
      bool ret_3 = EMPTY(t_1_seq, t_1_i, t_1_i);
      bool ret_1_1 = ret_3;
      char a_0_0 = ret_1_0;
      bool a_0_1 = ret_1_1;
      if ((is_not_empty(a_0_0) && is_not_empty(a_0_1)))
        {
          ret_0 = sl(a_0_0, a_0_1, a_1);
        }

      else
        {
          empty( ret_0);
        }

      erase( a_0_0);
      erase( a_0_1);
    }

    else
      {
        empty( ret_0);
      }

    erase( a_1);
  }

  else
    {
      empty( ret_0);
    }

  if (is_not_empty(ret_0))
    {
      push_back_max( answers, ret_0);
    }

  int ret_5 = nt_alignment(t_0_i, t_1_i);
  if (is_not_empty(ret_5))
    {
      push_back_max( answers, ret_5);
    }

  int eval = h(answers);
  erase( answers);
  return eval;
}

int out::nt_skipR(unsigned int t_1_i)
{
  int answers;
  empty(answers);
  empty( answers);
  int ret_0;
  if ((((t_0_right_most - t_0_left_most) >= 0) && ((t_1_right_most - t_1_i) >= 1)))
  {
    int ret_4 = nt_skipR((t_1_i + 1));
    int a_1 = ret_4;
    if (is_not_empty(a_1))
    {
      bool ret_2 = EMPTY(t_0_seq, t_0_left_most, t_0_left_most);
      bool ret_1_0 = ret_2;
      char ret_3 = CHAR(t_1_seq, t_1_i, (t_1_i + 1));
      char ret_1_1 = ret_3;
      bool a_0_0 = ret_1_0;
      char a_0_1 = ret_1_1;
      if ((is_not_empty(a_0_0) && is_not_empty(a_0_1)))
        {
          ret_0 = sr(a_0_0, a_0_1, a_1);
        }

      else
        {
          empty( ret_0);
        }

      erase( a_0_0);
      erase( a_0_1);
    }

    else
      {
        empty( ret_0);
      }

    erase( a_1);
  }

  else
    {
      empty( ret_0);
    }

  if (is_not_empty(ret_0))
    {
      push_back_max( answers, ret_0);
    }

  int ret_5 = nt_skipL(t_0_left_most, t_1_i);
  if (is_not_empty(ret_5))
    {
      push_back_max( answers, ret_5);
    }

  int eval = h(answers);
  erase( answers);
  return eval;
}

int &  out::nt_xDel(unsigned int t_0_i, unsigned int t_1_i)
{
  if (xDel_table.is_tabulated(t_0_i, t_1_i))
    {
      return xDel_table.get(t_0_i, t_1_i);
    }

  int answers;
  empty(answers);
  empty( answers);
  int ret_0 = nt_alignment(t_0_i, t_1_i);
  if (is_not_empty(ret_0))
    {
      push_back_max( answers, ret_0);
    }

  int ret_1;
  if ((((t_0_right_most - t_0_i) >= 1) && ((t_1_right_most - t_1_i) >= 0)))
  {
    int ret_5 = nt_xDel((t_0_i + 1), t_1_i);
    int a_1 = ret_5;
    if (is_not_empty(a_1))
    {
      char ret_3 = CHAR(t_0_seq, t_0_i, (t_0_i + 1));
      char ret_2_0 = ret_3;
      bool ret_4 = EMPTY(t_1_seq, t_1_i, t_1_i);
      bool ret_2_1 = ret_4;
      char a_0_0 = ret_2_0;
      bool a_0_1 = ret_2_1;
      if ((is_not_empty(a_0_0) && is_not_empty(a_0_1)))
        {
          ret_1 = delx(a_0_0, a_0_1, a_1);
        }

      else
        {
          empty( ret_1);
        }

      erase( a_0_0);
      erase( a_0_1);
    }

    else
      {
        empty( ret_1);
      }

    erase( a_1);
  }

  else
    {
      empty( ret_1);
    }

  if (is_not_empty(ret_1))
    {
      push_back_max( answers, ret_1);
    }

  int eval = h(answers);
  erase( answers);
  xDel_table.set( t_0_i, t_1_i, eval);
  return xDel_table.get(t_0_i, t_1_i);
}

int &  out::nt_xIns(unsigned int t_0_i, unsigned int t_1_i)
{
  if (xIns_table.is_tabulated(t_0_i, t_1_i))
    {
      return xIns_table.get(t_0_i, t_1_i);
    }

  int answers;
  empty(answers);
  empty( answers);
  int ret_0 = nt_alignment(t_0_i, t_1_i);
  if (is_not_empty(ret_0))
    {
      push_back_max( answers, ret_0);
    }

  int ret_1;
  if ((((t_0_right_most - t_0_i) >= 0) && ((t_1_right_most - t_1_i) >= 1)))
  {
    int ret_5 = nt_xIns(t_0_i, (t_1_i + 1));
    int a_1 = ret_5;
    if (is_not_empty(a_1))
    {
      bool ret_3 = EMPTY(t_0_seq, t_0_i, t_0_i);
      bool ret_2_0 = ret_3;
      char ret_4 = CHAR(t_1_seq, t_1_i, (t_1_i + 1));
      char ret_2_1 = ret_4;
      bool a_0_0 = ret_2_0;
      char a_0_1 = ret_2_1;
      if ((is_not_empty(a_0_0) && is_not_empty(a_0_1)))
        {
          ret_1 = insx(a_0_0, a_0_1, a_1);
        }

      else
        {
          empty( ret_1);
        }

      erase( a_0_0);
      erase( a_0_1);
    }

    else
      {
        empty( ret_1);
      }

    erase( a_1);
  }

  else
    {
      empty( ret_1);
    }

  if (is_not_empty(ret_1))
    {
      push_back_max( answers, ret_1);
    }

  int eval = h(answers);
  erase( answers);
  xIns_table.set( t_0_i, t_1_i, eval);
  return xIns_table.get(t_0_i, t_1_i);
}


int out::del(char a, bool VOID_INTERNAL6, int m)
{
#line 106 "affine.gap"
  return ((m - 15) - 1);
#line 466 "out.cc"
}

int out::delx(char a, bool VOID_INTERNAL8, int m)
{
#line 116 "affine.gap"
  return (m - 1);
#line 473 "out.cc"
}

int out::h(int l)
{
  return l;
  return maximum(l);
}

int out::ins(bool VOID_INTERNAL7, char b, int m)
{
#line 111 "affine.gap"
  return ((m - 15) - 1);
#line 486 "out.cc"
}

int out::insx(bool VOID_INTERNAL9, char b, int m)
{
#line 121 "affine.gap"
  return (m - 1);
#line 493 "out.cc"
}

int out::match(char a, char b, int m)
{
#line 98 "affine.gap"
  if ((a == b))
    {
      return (m + 4);
    }

  else
    {
      return (m - 3);
    }

#line 509 "out.cc"
}

int out::nil(int l, int m)
{
#line 127 "affine.gap"
  return 0;
#line 516 "out.cc"
}

int out::sl(char a, bool VOID_INTERNAL10, int m)
{
#line 132 "affine.gap"
  return m;
#line 523 "out.cc"
}

int out::sr(bool VOID_INTERNAL11, char b, int m)
{
#line 137 "affine.gap"
  return m;
#line 530 "out.cc"
}


    void out::cyk()
{

}



#ident "$Id: Compiled with gapc gapc-2012.07.23 $"

