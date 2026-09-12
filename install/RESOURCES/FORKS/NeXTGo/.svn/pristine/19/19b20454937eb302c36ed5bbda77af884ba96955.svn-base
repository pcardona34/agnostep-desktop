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

/* $Id: findopen.c,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: findopen.c,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:34:56  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:01  ergo
 * added time control for moves
 *
 */

#define EMPTY 0
#define BLACKSTONE 2

extern unsigned char p[19][19], ma[19][19];
extern int MAXX, MAXY;
extern int currentStone, blackCapturedKoI, blackCapturedKoJ;  /* piece captured */
extern int whiteCapturedKoI, whiteCapturedKoJ;

int findopen(int m, int n, int i[], int j[], int color, int minlib, int *ct)
     /* find all open spaces i, j from m, n */
{
  int mik, mjk;
  
  if (currentStone == BLACKSTONE) {
    mik = blackCapturedKoI;
    mjk = blackCapturedKoJ;
  } else {
    mik = whiteCapturedKoI;
    mjk = whiteCapturedKoJ;
  }
  
  /* mark this one */
  ma[m][n] = 1;
  
  /* check North neighbor */
  if (m != 0)
    {
      if ((p[m - 1][n] == EMPTY) && (((m - 1) != mik) || (n != mjk)))
	{
	  i[*ct] = m - 1;
	  j[*ct] = n;
	  ++*ct;
	  if (*ct == minlib) return 1;
	}
      else
	if ((p[m - 1][n] == color) && !ma[m - 1][n])
	  if (findopen(m - 1, n, i, j, color, minlib, ct) && (*ct == minlib))
	    return 1;
    }
  
  /* check South neighbor */
  if (m != MAXY - 1)
    {
      if ((p[m + 1][n] == EMPTY) && (((m + 1) != mik) || (n != mjk)))
	{
	  i[*ct] = m + 1;
	  j[*ct] = n;
	  ++*ct;
	  if (*ct == minlib) return 1;
	}
      else
	if ((p[m + 1][n] == color) && !ma[m + 1][n])
	  if (findopen(m + 1, n, i, j, color, minlib, ct) && (*ct == minlib))
	    return 1;
    }
  
  /* check West neighbor */
  if (n != 0)
    {
      if ((p[m][n - 1] == EMPTY) && ((m != mik) || ((n - 1) != mjk)))
	{
	  i[*ct] = m;
	  j[*ct] = n - 1;
	  ++*ct;
	  if (*ct == minlib) return 1;
	}
      else
	if ((p[m][n - 1] == color) && !ma[m][n - 1])
	  if (findopen(m, n - 1, i, j, color, minlib, ct) && (*ct == minlib))
	    return 1;
    }
  
  /* check East neighbor */
  if (n != MAXX - 1)
    {
      if ((p[m][n + 1] == EMPTY) && ((m != mik) || ((n + 1) != mjk)))
	{
	  i[*ct] = m;
	  j[*ct] = n + 1;
	  ++*ct;
	  if (*ct == minlib) return 1;
	}
      else
	if ((p[m][n + 1] == color) && !ma[m][n + 1])
	  if (findopen(m, n + 1, i, j, color, minlib, ct) && (*ct == minlib))
	    return 1;
    }
  
  /* fail to find open space */
  return 0;
}  /* end findopen */
