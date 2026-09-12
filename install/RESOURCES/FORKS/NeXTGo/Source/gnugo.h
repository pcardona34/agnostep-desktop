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

/* $Id: gnugo.h,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: gnugo.h,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:38:22  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:19  ergo
 * added time control for moves
 *
 */

extern void sethand(int i);        // set up the handicap stones.
extern void examboard(int color);  // remove dead stones.
extern void eval(int color);       // evaluate the liberties of the stones.
extern void countlib(int m, int n, int color);
                                   // count the liberties of the color at m,n.
extern void count(int i, int j, int color);
                                   // count the liberties of the stone at i,j.
extern int suicide(int i, int j);  // determine if legally placed stone.
extern void genmove(int *i, int *j);
                                   // generate computer move.
extern int findwinner(int *i, int *j, int *val);
                                   // find opponent piece to capture or attack.
extern int findopen(int m, int n, int i[], int j[], int color, int minlib, int *ct);
                                   // find all open spaces i, j from m, n.
extern int findsaver(int *i, int *j, int *val);
                                   // find move if any pieces are threatened.
extern void initmark();            // initialize all markings with zero.
extern int findnextmove(int m, int n, int *i, int *j, int *val, int minlib);
                                   // find new move i,j from group containing m,n.
extern int fval(int newlib, int minlib);
                                   // evaluate new move.
extern int findpatn(int *i, int *j, int *val);
                                   // find pattern to match for next move.
extern int opening(int *i, int *j, int *cnd, int type);
                                   // get move for opening from game tree.
extern int openregion(int i1, int j1, int i2, int j2);
                                   // check if region from i1,j1  to i2,j2 is open.
extern int matchpat(int m, int n, int *i, int *j, int *val);
                                   // match pattern and get next move.
extern int fioe(int i, int j);     // check edges.
extern void Random(int *i);        // return a random integer.
extern void seed(int *i);          // seed a random number generator.
extern void score_game(void);      // remove dead stones and score the game.
extern void find_owner(void);
extern int surrounds_territory(int x, int y);
extern void find_pattern_in_board(int x, int y);
extern void set_temp_to_p(void);
extern void set_p_to_temp(void);
