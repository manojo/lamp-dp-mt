/*
 *   This file was automatically generated by version 1.7 of cextract.
 *   Manual editing not recommended.
 *
 *   Created: Mon Jul 12 10:43:22 1999
 */
#ifndef _nodeprocs_
#define _nodeprocs_
#if __STDC__

extern node *add_to_list ( node *n, node *e );
extern void free_node ( node *n );
extern node *new_id ( char *s );
extern node *new_list ( node *e );
extern node *new_node ( nodetype t );
extern void remove_from_list ( node *n, node *e );

#else /* __STDC__ */

extern node *add_to_list (/* node *n, node *e */);
extern void free_node (/* node *n */);
extern node *new_id (/* char *s */);
extern node *new_list (/* node *e */);
extern node *new_node (/* nodetype t */);
extern void remove_from_list (/* node *n, node *e */);

#endif /* __STDC__ */
#endif /* _nodeprocs_ */
