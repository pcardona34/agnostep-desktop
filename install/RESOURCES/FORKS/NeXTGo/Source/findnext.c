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

/* $Id: findnext.c,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: findnext.c,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:34:55  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:00  ergo
 * added time control for moves
 *
 */

#define EMPTY 0

extern unsigned char p[19][19], ma[19][19];
extern int currentStone, MAXX, MAXY;
extern int lib;
extern int countlib(int,int,int);

int fval(int newlib, int minlib)
     /* evaluate new move */
{
  int k, val;
  
  if (newlib <= minlib)
    val = -1;
  else
    {
      k = newlib - minlib;
      val = 40 + (k - 1) * 50 / (minlib * minlib * minlib);
    }
  return val;
}  /* end fval */


int findnextmove(int m, int n, int *i, int *j, int *val, int minlib)
     /* find new move i, j from group containing m, n */
{
  int ti, tj, tval;
  int found = 0;
  
  *i = -1;   *j = -1;	*val = -1;
  /* mark current position */
  ma[m][n] = 1;
  
  /* check North neighbor */
  if (m != 0)
    if (p[m - 1][n] == EMPTY)
      {
	ti = m - 1;
	tj = n;
	lib = 0;
	countlib(ti, tj, currentStone);
	tval = fval(lib, minlib);
	found = 1;
      }
    else
      if ((p[m - 1][n] == currentStone) && !ma[m - 1][n])
	if (findnextmove(m - 1, n, &ti, &tj, &tval, minlib))
	  found = 1;
  
  if (found)
    {
      found = 0;
      if (tval > *val)
	{
	  *val = tval;
	  *i = ti;
	  *j = tj;
	}
      if (minlib == 1) return 1;
    }
  
  /* check South neighbor */
  if (m != MAXY - 1)
    if (p[m + 1][n] == EMPTY)
      {
	ti = m + 1;
	tj = n;
	lib = 0;
	countlib(ti, tj, currentStone);
	tval = fval(lib, minlib);
	found = 1;
      }
    else
      if ((p[m + 1][n] == currentStone) && !ma[m + 1][n])
	if (findnextmove(m + 1, n, &ti, &tj, &tval, minlib))
	  found = 1;
  
  if (found)
    {
      found = 0;
      if (tval > *val)
	{
	  *val = tval;
	  *i = ti;
	  *j = tj;
	}
      if (minlib == 1) return 1;
    }
  
  /* check West neighbor */
  if (n != 0)
    if (p[m][n - 1] == EMPTY)
      {
	ti = m;
	tj = n - 1;
	lib = 0;
	countlib(ti, tj, currentStone);
	tval = fval(lib, minlib);
	found = 1;
      }
    else
      if ((p[m][n - 1] == currentStone) && !ma[m][n - 1])
	if (findnextmove(m, n - 1, &ti, &tj, &tval, minlib))
	  found = 1;
  
  if (found)
    {
      found = 0;
      if (tval > *val)
	{
	  *val = tval;
	  *i = ti;
	  *j = tj;
	}
      if (minlib == 1) return 1;
    }
  
  /* check East neighbor */
  if (n != MAXX - 1)
    if (p[m][n + 1] == EMPTY)
      {
	ti = m;
	tj = n + 1;
	lib = 0;
	countlib(ti, tj, currentStone);
	tval = fval(lib, minlib);
	found = 1;
      }
    else
      if ((p[m][n + 1] == currentStone) && !ma[m][n + 1])
	if (findnextmove(m, n + 1, &ti, &tj, &tval, minlib))
	  found = 1;
  
  if (found)
    {
      found = 0;
      if (tval > *val)
	{
	  *val = tval;
	  *i = ti;
	  *j = tj;
	}
      if (minlib == 1) return 1;
    }
  
  if (*val > 0)	/* found next move */
    return 1;
  else	/* next move failed */
    return 0;
}  /* end findnextmove */

