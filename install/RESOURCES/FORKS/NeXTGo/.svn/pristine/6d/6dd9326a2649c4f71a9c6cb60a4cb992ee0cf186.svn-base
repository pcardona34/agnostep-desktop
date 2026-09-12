/*
                GNU GO - the game of Go (Wei-Chi)
                Version 1.1   last revised 3-1-89
           Copyright (C) Free Software Foundation, Inc.
                      written by Man L. Li
                      modified by Wayne Iba
                    documented by Bob Webber
                    NeXT version by John Neil
*/
/*
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation - version 1.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License in file COPYING for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

Please report any bug/fix, modification, suggestion to

mail address:   Man L. Li
                Dept. of Computer Science
                University of Houston
                4800 Calhoun Road
                Houston, TX 77004

e-mail address: manli@cs.uh.edu         (Internet)
                coscgbn@uhvax1.bitnet   (BITNET)
                70070,404               (CompuServe)

For the NeXT version, please report any bug/fix, modification, suggestion to

mail address:   John Neil
                Mathematics Department
                Portland State University
                PO Box 751
                Portland, OR  97207

e-mail address: neil@math.mth.pdx.edu  (Internet)
                neil@psuorvm.bitnet    (BITNET)
*/

#include "comment.header"

/* $Id: opening.c,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: opening.c,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:35:03  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:09  ergo
 * added time control for moves
 *
 */

extern int rd, MAXX, MAXY;
extern void Random(int*);

int opening(int *i, int *j, int *cnd, int type)
     /* get move for opening from game tree */
{
  struct tnode {
    int i, j, ndct, next[8];
  };
  
  static struct tnode tree[] = {
    {-1, -1, 8, { 1, 2, 3, 4, 5, 6, 7, 20}},	/* 0 */
    {2, 3, 2, { 8, 9}},
    {2, 4, 1, {10}},
    {3, 2, 2, {11, 12}},
    {3, 3, 6, {14, 15, 16, 17, 18, 19}},
    {3, 4, 1, {10}},  /* 5 */
    {4, 2, 1, {13}},
    {4, 3, 1, {13}},
    {4, 2, 0},
    {4, 3, 0},
    {3, 2, 0},  /* 10 */
    {2, 4, 0},
    {3, 4, 0},
    {2, 3, 0},
    {2, 5, 1, {10}},
    {2, 6, 1, {10}},  /* 15 */
    {3, 5, 1, {10}},
    {5, 2, 1, {13}},
    {5, 3, 1, {13}},
    {6, 2, 1, {13}},
    {2, 2, 0}  /* 20 */
  };
  int m;
  
  /* get i, j */
  if ((type == 1) || (type == 3))
    *i = (18 - tree[*cnd].i)*MAXX/19;   /* inverted */
  else
    *i = tree[*cnd].i*MAXX/19;
  if ((type == 2) || (type == 3))
    *j = (18 - tree[*cnd].j)*MAXY/19;   /* reflected */
  else
    *j = tree[*cnd].j*MAXY/19;
  if (tree[*cnd].ndct)  /* more move */
    {
      Random(&rd);
      m = rd % tree[*cnd].ndct;  /* select move */
      *cnd = tree[*cnd].next[m];	/* new	current node */
      return 1;
    }
  else
    return 0;
}  /* end opening */

