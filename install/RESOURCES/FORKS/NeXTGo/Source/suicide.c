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

/* $Id: suicide.c,v 1.1 2003/01/12 04:01:53 gcasa Exp $ */

/*
 * $Log: suicide.c,v $
 * Revision 1.1  2003/01/12 04:01:53  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:35:12  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:15  ergo
 * added time control for moves
 *
 */

#define EMPTY 0
#define BLACKSTONE 2

extern unsigned char p[19][19], l[19][19];
extern int currentStone, opposingStone, MAXX, MAXY;
extern int lib;
extern int blackCapturedKoI, blackCapturedKoJ, whiteCapturedKoI, whiteCapturedKoJ;  /* piece captured */
extern void countlib(int, int, int);
extern void eval(int);

int suicide(int i, int j)
/* check for suicide move of opponent at p[i][j] */
{
 int m, n, k, uik, ujk;

/* check liberty of new move */
 lib = 0;
 countlib(i, j, currentStone);
 if (lib == 0)
/* new move is suicide then check if kill my pieces and Ko possibility */
   {
/* assume alive */
    p[i][j] = currentStone;

/* check opponent pieces */
    eval(opposingStone);
    k = 0;

    for (m = 0; m < MAXX; m++)
      for (n = 0; n < MAXY; n++)
/* count pieces that will be killed */
	if ((p[m][n] == opposingStone) && !l[m][n]) ++k;

    if (currentStone == BLACKSTONE) {
      uik = blackCapturedKoI;
      ujk = blackCapturedKoJ;
    } else {
      uik = whiteCapturedKoI;
      ujk = whiteCapturedKoJ;
    }
    if ((k == 0) || (k == 1 && ((i == uik) && (j == ujk))))
/* either no effect on my pieces or an illegal Ko take back */
      {
       p[i][j] = EMPTY;   /* restore to open */
       return 1;
      }
    else
/* good move */
      return 0;
   }
 else
/* valid move */
   return 0;
}  /* end suicide */

