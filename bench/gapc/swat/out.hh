
// A dynamic programming evaluator generated by GAP-C.
// 
//   GAP-C version:
//     gapc-2012.07.23
// 
//   GAP-C call:
//     gapc -t -i affine affine.gap 
// 
// 


#ifndef out_hh
#define out_hh

#include "rtlib/adp.hh"

typedef Basic_Subsequence<char, unsigned> TUSubsequence;

struct spair {
  String first;
  String second;
  bool empty_;
  spair() : empty_(false) {}

};

inline std::ostream &operator<<(std::ostream &o, const spair &tuple) {
  o << '('   << tuple.first   << ", " << tuple.second
   << ')' ;
  return o;
}

inline void empty(spair &e) {e.empty_ = true; }
inline bool is_empty(const spair &e) { return e.empty_; }
#include <rtlib/subopt.hh>

#include <rtlib/generic_opts.hh>

class out {

  public:
Basic_Sequence<char> t_0_seq;
Basic_Sequence<char> t_1_seq;
unsigned int t_0_left_most;
unsigned int t_0_right_most;
unsigned int t_1_left_most;
unsigned int t_1_right_most;

int int_zero;

class alignment_table_t {

private:

unsigned int t_0_left_most;
unsigned int t_0_right_most;
unsigned int t_1_left_most;
unsigned int t_1_right_most;
std::vector<int > array;
std::vector<bool> tabulated;
unsigned int t_0_n;
unsigned int t_1_n;
int zero;
unsigned int size()
{
  return ((1 * ((t_1_n + 1) * 1)) * ((t_0_n + 1) * 1));
}


public:

alignment_table_t()
{
  empty(zero);
}

void init(unsigned int t_0_n_, unsigned int t_1_n_, const std::string &tname)
{
t_0_n = t_0_n_;
t_1_n = t_1_n_;
t_0_left_most = 0;
t_0_right_most = t_0_n;
t_1_left_most = 0;
t_1_right_most = t_1_n;
unsigned int newsize = size();
array.resize(newsize);
tabulated.clear();
tabulated.resize(newsize);
}
bool is_tabulated(unsigned int t_0_i, unsigned int t_1_i)
{
  unsigned int t_1_j = t_1_n;
  assert( (t_1_i <= t_1_j));
  assert( (t_1_j <= t_1_n));
  if ((t_1_j < (t_1_n - 0)))
    {
      return true;
    }

  unsigned int t_1_real_j = (t_1_n - t_1_j);
  unsigned int t_0_j = t_0_n;
  assert( (t_0_i <= t_0_j));
  assert( (t_0_j <= t_0_n));
  if ((t_0_j < (t_0_n - 0)))
    {
      return true;
    }

  unsigned int t_0_real_j = (t_0_n - t_0_j);
  return tabulated[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))];
}


void clear() { tabulated.clear(); }
int &  get(unsigned int t_0_i, unsigned int t_1_i)
{
  unsigned int t_1_j = t_1_n;
  assert( (t_1_i <= t_1_j));
  assert( (t_1_j <= t_1_n));
  if ((t_1_j < (t_1_n - 0)))
    {
      return zero;
    }

  unsigned int t_1_real_j = (t_1_n - t_1_j);
  unsigned int t_0_j = t_0_n;
  assert( (t_0_i <= t_0_j));
  assert( (t_0_j <= t_0_n));
  if ((t_0_j < (t_0_n - 0)))
    {
      return zero;
    }

  unsigned int t_0_real_j = (t_0_n - t_0_j);
  assert( tabulated[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))]);
  assert( (((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1))))) < size()));
  return array[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))];
}


void set(unsigned int t_0_i, unsigned int t_1_i, int e)
{
  unsigned int t_1_j = t_1_n;
  assert( (t_1_i <= t_1_j));
  assert( (t_1_j <= t_1_n));
  if ((t_1_j < (t_1_n - 0)))
    {
      return;
    }

  unsigned int t_1_real_j = (t_1_n - t_1_j);
  unsigned int t_0_j = t_0_n;
  assert( (t_0_i <= t_0_j));
  assert( (t_0_j <= t_0_n));
  if ((t_0_j < (t_0_n - 0)))
    {
      return;
    }

  unsigned int t_0_real_j = (t_0_n - t_0_j);
  assert( !is_tabulated(t_0_i, t_1_i));
  assert( (((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1))))) < size()));
  array[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))] = e;
  tabulated[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))] = true;
}


};
alignment_table_t alignment_table;


class xDel_table_t {

private:

unsigned int t_0_left_most;
unsigned int t_0_right_most;
unsigned int t_1_left_most;
unsigned int t_1_right_most;
std::vector<int > array;
std::vector<bool> tabulated;
unsigned int t_0_n;
unsigned int t_1_n;
int zero;
unsigned int size()
{
  return ((1 * ((t_1_n + 1) * 1)) * ((t_0_n + 1) * 1));
}


public:

xDel_table_t()
{
  empty(zero);
}

void init(unsigned int t_0_n_, unsigned int t_1_n_, const std::string &tname)
{
t_0_n = t_0_n_;
t_1_n = t_1_n_;
t_0_left_most = 0;
t_0_right_most = t_0_n;
t_1_left_most = 0;
t_1_right_most = t_1_n;
unsigned int newsize = size();
array.resize(newsize);
tabulated.clear();
tabulated.resize(newsize);
}
bool is_tabulated(unsigned int t_0_i, unsigned int t_1_i)
{
  unsigned int t_1_j = t_1_n;
  assert( (t_1_i <= t_1_j));
  assert( (t_1_j <= t_1_n));
  if ((t_1_j < (t_1_n - 0)))
    {
      return true;
    }

  unsigned int t_1_real_j = (t_1_n - t_1_j);
  unsigned int t_0_j = t_0_n;
  assert( (t_0_i <= t_0_j));
  assert( (t_0_j <= t_0_n));
  if ((t_0_j < (t_0_n - 0)))
    {
      return true;
    }

  unsigned int t_0_real_j = (t_0_n - t_0_j);
  return tabulated[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))];
}


void clear() { tabulated.clear(); }
int &  get(unsigned int t_0_i, unsigned int t_1_i)
{
  unsigned int t_1_j = t_1_n;
  assert( (t_1_i <= t_1_j));
  assert( (t_1_j <= t_1_n));
  if ((t_1_j < (t_1_n - 0)))
    {
      return zero;
    }

  unsigned int t_1_real_j = (t_1_n - t_1_j);
  unsigned int t_0_j = t_0_n;
  assert( (t_0_i <= t_0_j));
  assert( (t_0_j <= t_0_n));
  if ((t_0_j < (t_0_n - 0)))
    {
      return zero;
    }

  unsigned int t_0_real_j = (t_0_n - t_0_j);
  assert( tabulated[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))]);
  assert( (((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1))))) < size()));
  return array[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))];
}


void set(unsigned int t_0_i, unsigned int t_1_i, int e)
{
  unsigned int t_1_j = t_1_n;
  assert( (t_1_i <= t_1_j));
  assert( (t_1_j <= t_1_n));
  if ((t_1_j < (t_1_n - 0)))
    {
      return;
    }

  unsigned int t_1_real_j = (t_1_n - t_1_j);
  unsigned int t_0_j = t_0_n;
  assert( (t_0_i <= t_0_j));
  assert( (t_0_j <= t_0_n));
  if ((t_0_j < (t_0_n - 0)))
    {
      return;
    }

  unsigned int t_0_real_j = (t_0_n - t_0_j);
  assert( !is_tabulated(t_0_i, t_1_i));
  assert( (((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1))))) < size()));
  array[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))] = e;
  tabulated[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))] = true;
}


};
xDel_table_t xDel_table;


class xIns_table_t {

private:

unsigned int t_0_left_most;
unsigned int t_0_right_most;
unsigned int t_1_left_most;
unsigned int t_1_right_most;
std::vector<int > array;
std::vector<bool> tabulated;
unsigned int t_0_n;
unsigned int t_1_n;
int zero;
unsigned int size()
{
  return ((1 * ((t_1_n + 1) * 1)) * ((t_0_n + 1) * 1));
}


public:

xIns_table_t()
{
  empty(zero);
}

void init(unsigned int t_0_n_, unsigned int t_1_n_, const std::string &tname)
{
t_0_n = t_0_n_;
t_1_n = t_1_n_;
t_0_left_most = 0;
t_0_right_most = t_0_n;
t_1_left_most = 0;
t_1_right_most = t_1_n;
unsigned int newsize = size();
array.resize(newsize);
tabulated.clear();
tabulated.resize(newsize);
}
bool is_tabulated(unsigned int t_0_i, unsigned int t_1_i)
{
  unsigned int t_1_j = t_1_n;
  assert( (t_1_i <= t_1_j));
  assert( (t_1_j <= t_1_n));
  if ((t_1_j < (t_1_n - 0)))
    {
      return true;
    }

  unsigned int t_1_real_j = (t_1_n - t_1_j);
  unsigned int t_0_j = t_0_n;
  assert( (t_0_i <= t_0_j));
  assert( (t_0_j <= t_0_n));
  if ((t_0_j < (t_0_n - 0)))
    {
      return true;
    }

  unsigned int t_0_real_j = (t_0_n - t_0_j);
  return tabulated[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))];
}


void clear() { tabulated.clear(); }
int &  get(unsigned int t_0_i, unsigned int t_1_i)
{
  unsigned int t_1_j = t_1_n;
  assert( (t_1_i <= t_1_j));
  assert( (t_1_j <= t_1_n));
  if ((t_1_j < (t_1_n - 0)))
    {
      return zero;
    }

  unsigned int t_1_real_j = (t_1_n - t_1_j);
  unsigned int t_0_j = t_0_n;
  assert( (t_0_i <= t_0_j));
  assert( (t_0_j <= t_0_n));
  if ((t_0_j < (t_0_n - 0)))
    {
      return zero;
    }

  unsigned int t_0_real_j = (t_0_n - t_0_j);
  assert( tabulated[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))]);
  assert( (((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1))))) < size()));
  return array[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))];
}


void set(unsigned int t_0_i, unsigned int t_1_i, int e)
{
  unsigned int t_1_j = t_1_n;
  assert( (t_1_i <= t_1_j));
  assert( (t_1_j <= t_1_n));
  if ((t_1_j < (t_1_n - 0)))
    {
      return;
    }

  unsigned int t_1_real_j = (t_1_n - t_1_j);
  unsigned int t_0_j = t_0_n;
  assert( (t_0_i <= t_0_j));
  assert( (t_0_j <= t_0_n));
  if ((t_0_j < (t_0_n - 0)))
    {
      return;
    }

  unsigned int t_0_real_j = (t_0_n - t_0_j);
  assert( !is_tabulated(t_0_i, t_1_i));
  assert( (((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1))))) < size()));
  array[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))] = e;
  tabulated[((0 + (1 * (t_1_i + (t_1_real_j * (t_1_n + 1))))) + ((1 * ((t_1_n + 1) * 1)) * (t_0_i + (t_0_real_j * (t_0_n + 1)))))] = true;
}


};
xIns_table_t xIns_table;



void init(const gapc::Opts &opts)
{
const std::vector<std::pair<const char *, unsigned> > &inp = opts.inputs;
if(inp.size() != 2)
  throw gapc::OptException("Number of input sequences does not match.");

  t_0_seq.copy(inp[0].first, inp[0].second);
  t_1_seq.copy(inp[1].first, inp[1].second);
  alignment_table.init( t_0_seq.size(), t_1_seq.size(), "alignment_table");
  xDel_table.init( t_0_seq.size(), t_1_seq.size(), "xDel_table");
  xIns_table.init( t_0_seq.size(), t_1_seq.size(), "xIns_table");
empty(int_zero);

t_0_left_most = 0;
t_0_right_most = t_0_seq.size();
t_1_left_most = 0;
t_1_right_most = t_1_seq.size();
}

  private:
    int &  nt_alignment(unsigned int t_0_i, unsigned int t_1_i);
    int nt_skipL(unsigned int t_0_i, unsigned int t_1_i);
    int nt_skipR(unsigned int t_1_i);
    int &  nt_xDel(unsigned int t_0_i, unsigned int t_1_i);
    int &  nt_xIns(unsigned int t_0_i, unsigned int t_1_i);

    int del(char a, bool VOID_INTERNAL6, int m);
    int delx(char a, bool VOID_INTERNAL8, int m);
    int h(int l);
    int ins(bool VOID_INTERNAL7, char b, int m);
    int insx(bool VOID_INTERNAL9, char b, int m);
    int match(char a, char b, int m);
    int nil(int l, int m);
    int sl(char a, bool VOID_INTERNAL10, int m);
    int sr(bool VOID_INTERNAL11, char b, int m);


 public:
   void cyk();

 public:
   int run()
{
  return nt_skipR(t_1_left_most);
}
void print_stats(std::ostream &o)
{
#ifdef STATS
      o << "\n\nN = " << seq.size() << '\n';
      alignment_table.print_stats(o, "alignment_table");
      xDel_table.print_stats(o, "xDel_table");
      xIns_table.print_stats(o, "xIns_table");
#endif
}

template <typename Value>   void  print_result(std::ostream &out, Value& res)

{
if (is_empty(res))
  out << "[]\n";
else
  out << res << '\n';

}
template <typename Value>   void  print_backtrack(std::ostream &out, Value& value)

{
}
   void  print_subopt(std::ostream &out, int  delta = 0) {}

};

#ifndef NO_GAPC_TYPEDEFS
namespace gapc {
  typedef out class_name;
  typedef int return_type;
}
#endif

#endif

