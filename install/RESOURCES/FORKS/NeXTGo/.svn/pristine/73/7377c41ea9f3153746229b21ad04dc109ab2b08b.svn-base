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

/* $Id: findpatn.c,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: findpatn.c,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:34:57  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:02  ergo
 * added time control for moves
 *
 */

#define EMPTY 0

extern unsigned char p[19][19];
extern int opn[9];
extern int MAXX, MAXY, currentStone;
extern int opening(int*,int*,int*,int);
extern int openregion(int,int,int,int);
extern int matchpat(int,int,int*,int*,int*);

int findpatn(int *i, int *j, int *val)
     /* find pattern to match for next move */
{
  int m, n;
  int ti, tj, tval;
  static int cnd, mtype;  /* game tree node number, move type */
  /* mtype = 0, basic; 1, inverted; 2, reflected; 3, inverted & reflected */
  
  /* open game then occupy corners */
  if (opn[4])   /* continue last move */
    {
      opn[4] = 0;  /* clear flag */
      if (opening(i, j, &cnd, mtype)) opn[4] = 1; /* more move then reset flag */
      if (p[*i][*j] == EMPTY)  /* valid move */
	{
	  *val = 80;
	  return 1;
	}
      else
	opn[4] = 0;
    }
  
  if (opn[0])   /* Northwest corner */
    {
      opn[0] = 0;  /* clear flag */
      if (openregion(0, 0, 5, 5))
	{
	  cnd = 0;
	  mtype = 0;
	  opening(i, j, &cnd, mtype);  /* get new node for next move */
	  if (opening(i, j, &cnd, mtype)) opn[4] = 1;
	  *val = 80;
	  return 1;
	}
    }
  
  if (opn[1])   /* Southwest corner */
    {
      opn[1] = 0;
      if (openregion(MAXX - 6, 0, MAXX - 1, 5))
	{
	  cnd = 0;
	  mtype = 1;
	  opening(i, j, &cnd, mtype);  /* get new node for next move */
	  if (opening(i, j, &cnd, mtype)) opn[4] = 1;
	  *val = 80;
	  return 1;
	}
    }
  
  if (opn[2])   /* Northeast corner */
    {
      opn[2] = 0;
      if (openregion(0, MAXY - 6, 5, MAXY - 1))
	{
	  cnd = 0;
	  mtype = 2;
	  opening(i, j, &cnd, mtype);  /* get new node for next move */
	  if (opening(i, j, &cnd, mtype)) opn[4] = 1;
	  *val = 80;
	  return 1;
	}
    }
  
  if (opn[3])   /* Northeast corner */
    {
      opn[3] = 0;
      if (openregion(MAXX - 6, MAXY - 6, MAXX - 1, MAXY - 1))
	{
	  cnd = 0;
	  mtype = 3;
	  opening(i, j, &cnd, mtype);  /* get new node for next move */
	  if (opening(i, j, &cnd, mtype)) opn[4] = 1;
	  *val = 80;
	  return 1;
	}
    }
  
  /* occupy edges */
  if (opn[5])   /* North edge */
    {
      opn[5] = 0;
      if (openregion(0, (MAXY/2) - 3, 4, (MAXY/2) + 2))
	{
	  *i = 3;
	  *j = MAXY/2;
	  *val = 80;
	  return 1;
	}
    }
  
  if (opn[6])   /* South edge */
    {
      opn[6] = 0;
      if (openregion(MAXX - 1, (MAXY/2) - 3, MAXX - 5, (MAXY/2) + 2))
	{
	  *i = MAXX - 4;
	  *j = MAXY/2;
	  *val = 80;
	  return 1;
	}
    }
  
  if (opn[7])   /* West edge */
    {
      opn[7] = 0;
      if (openregion((MAXX/2) - 3, 0, (MAXX/2) + 2, 4))
	{
	  *i = MAXX/2;
	  *j = 3;
	  *val = 80;
	  return 1;
	}
    }
  
  if (opn[8])   /* East edge */
    {
      opn[8] = 0;
      if (openregion((MAXX/2) - 3, MAXY - 1, (MAXX/2) + 2, MAXY - 5))
	{
	  *i = MAXX/2;
	  *j = MAXY - 4;
	  *val = 80;
	  return 1;
	}
    }
  
  *i = -1;
  *j = -1;
  *val = -1;
  
  /* find local pattern */
  for (m = 0; m < MAXX; m++)
    for (n = 0; n < MAXY; n++)
      if ((p[m][n] == currentStone) &&
	  (matchpat(m, n, &ti, &tj, &tval) && (tval > *val)))
	{
	  *val = tval;
	  *i = ti;
	  *j = tj;
	}
  if (*val > 0)  /* pattern found */
    return 1;
  else  /* no match found */
    return 0;
}  /* end findpatn */

