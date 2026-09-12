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
  
/* $Id: genmove.c,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: genmove.c,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:35:00  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:05  ergo
 * added time control for moves
 *
 */

#define EMPTY 0
#define MAXTRY 400
#define BLACKSTONE 2

extern unsigned char p[19][19];
extern int currentStone, opposingStone, MAXX, MAXY;
extern int rd, lib, blackPassed, whitePassed;
extern void eval(int);
extern int findwinner(int*,int*,int*);
extern int findsaver(int*,int*,int*);
extern int findpatn(int*,int*,int*);
extern void countlib(int,int,int);
extern int fioe(int,int);
extern void Random(int*);

void genmove(int *i, int *j)
     /* generate computer move */
{
  int ti, tj, tval;
  int val;
  int try = 0;   /* number of try */
  
  /* initialize move and value */
  *i = -1;  *j = -1;  val = -1;
  
  /* re-evaluate liberty of opponent pieces */
  eval(opposingStone);
  
  /* find opponent piece to capture or attack */
  if (findwinner(&ti, &tj, &tval))
    if (tval > val)
      {
	val = tval;
	*i = ti;
	*j = tj;
      }
  
  /* save any piece if threaten */
  if (findsaver(&ti, &tj, &tval))
    if (tval > val)
      {
	val = tval;
	*i = ti;
	*j = tj;
      }
  
  /* try match local play pattern for new move */
  if (findpatn(&ti, &tj, &tval))
    if (tval > val)
      {
	val = tval;
	*i = ti;
	*j = tj;
      }
  
  /* no urgent move then do random move */
  if (val < 0)
    do {
      Random(&rd);
      *i = rd % MAXX;
      /* avoid low line  and center region */
      if ((*i < 2) || (*i > MAXX - 3) || ((*i > (MAXX/2) - 2) && (*i < (MAXX/2) + 2)))
	{
	  Random(&rd);
	  *i = rd % MAXX;
	  if ((*i < 2) || (*i > MAXX - 3))
	    {
	      Random(&rd);
	      *i = rd % MAXX;
	    }
	}
      Random(&rd);
      *j = rd % MAXY;
      /* avoid low line and center region */
      if ((*j < 2) || (*j > MAXY - 3) || ((*j > (MAXX/2) - 2) && (*j < (MAXY/2) + 2)))
	{
	  Random(&rd);
	  *j = rd % MAXY;
	  if ((*j < 2) || (*j > MAXY - 3))
	    {
	      Random(&rd);
	      *j = rd % MAXY;
	    }
	}
      lib = 0;
      countlib(*i, *j, currentStone);
    }
  /* avoid illegal move, liberty one or suicide, fill in own eye */
  while ((++try < MAXTRY)
	 && ((p[*i][*j] != EMPTY) || (lib < 3) || fioe(*i, *j)));
  
  if (try >= MAXTRY)  /* computer pass */
    {
      if (currentStone == BLACKSTONE)
	blackPassed = 1;
      else
	whitePassed = 1;
      *i = *j = -1;
    }
  else   /* find valid move */
    {
      if (currentStone == BLACKSTONE)
	blackPassed = 0;
      else
	whitePassed = 0;
    }
}  /* end genmove */
