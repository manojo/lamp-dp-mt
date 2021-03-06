/*
 *   This file was automatically generated by version 1.7 of cextract.
 *   Manual editing not recommended.
 *
 *   Created: Fri Jul 16 14:15:44 1999
 */
#ifndef _node2item_
#define _node2item_
#if __STDC__

extern item *convert_affine ( node *Z, node *X, int n, int C );
extern item *convert_mat ( node *Z, node *X, int n, int m );
extern item *convert_param_assign ( node *Z, node *X, int n, int use_flag );
extern item *convert_pol2 ( node *Z, node *X, int n );
extern item *convert_zpol ( node *Z, item *M, node *X );
extern node *get_dom ( node *in, node *alpha );
extern item *id_list ( node *in );
extern item *id_list2 ( node *in, int n );
extern void print_name ( node *n );
extern item *spec_mat ( node *Z, node *X, int n );
extern int sprint_name ( char *txt, node *n );

#else /* __STDC__ */

extern item *convert_affine (/* node *Z, node *X, int n, int C */);
extern item *convert_mat (/* node *Z, node *X, int n, int m */);
extern item *convert_param_assign (/* node *Z, node *X, int n, int
                                    use_flag */);
extern item *convert_pol2 (/* node *Z, node *X, int n */);
extern item *convert_zpol (/* node *Z, item *M, node *X */);
extern node *get_dom (/* node *in, node *alpha */);
extern item *id_list (/* node *in */);
extern item *id_list2 (/* node *in, int n */);
extern void print_name (/* node *n */);
extern item *spec_mat (/* node *Z, node *X, int n */);
extern int sprint_name (/* char *txt, node *n */);

#endif /* __STDC__ */
#endif /* _node2item_ */
