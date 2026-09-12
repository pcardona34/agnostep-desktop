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

/* $Id: matchpat.c,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: matchpat.c,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:35:03  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:08  ergo
 * added time control for moves
 *
 */

#define EMPTY 0
#define MAXPC 16
#define abs(x) ((x) < 0 ? -(x) : (x))
#define line(x) (abs(x - 9))

extern unsigned char p[19][19];
extern int currentStone, opposingStone, MAXX, MAXY;
extern int lib;
extern void countlib(int,int,int);

int matchpat(int m, int n, int *i, int *j, int *val)
     /* match pattern and get next move */
{
  struct patval {int x, y, att;}; /* pattern x, y coor and attribute */
  /* att = 0 - empty, 1 - your piece, 2 - my piece, 3 - my next move */
  /* 4 - empty on edge, 5 - your piece on edge, 6 - my piece on edge */
  struct pattern {
    struct patval patn[MAXPC];   /* pattern */
    /* number of pieces in pattern, no. of transformation, pattern value */
    int patlen, trfno, patwt;
  };
  
#include "patterns.h"
  
  /* transformation matrice */
  static int trf [8][2][2] = {
    {{1, 0}, {0, 1}}, /* linear transfomation matrix */
    {{1, 0}, {0, -1}},  /* invert */
    {{0, 1}, {-1, 0}},  /* rotate 90 */
    {{0, -1}, {-1, 0}},	/* rotate 90 and invert */
    {{-1, 0}, {0, 1}},  /* flip left */
    {{-1, 0}, {0, -1}},	/* flip left and invert */
    {{0, 1}, {1, 0}},  /* rotate 90 and flip left */
    {{0, -1}, {1, 0}}  /* rotate 90, flip left and invert */
  };
  int k, my, nx, l, r, cont;
  int ti, tj, tval;
  
  *i = -1;   *j = -1;   *val = -1;
  ti = tj = 0;
  for (r = 0; r < PATNO; r++)
    /* try each pattern */
    for (l = 0; l < pat[r].trfno; l++)
      /* try each orientation transformation */
      {
	k = 0;  cont = 1;
	while ((k != pat[r].patlen) && cont)
	  /* match each point */
	  {
	    /* transform pattern real coordinate */
	    nx = n + trf[l][0][0] * pat[r].patn[k].x
	      + trf[l][0][1] * pat[r].patn[k].y;
	    my = m + trf[l][1][0] * pat[r].patn[k].x
	      + trf[l][1][1] * pat[r].patn[k].y;
	    
	    /* outside the board */
	    if ((my < 0) || ( my > MAXY - 1) || (nx < 0) || (nx > MAXX - 1))
	      {
		cont = 0;
		break;
	      }
	    switch (pat[r].patn[k].att) {
	    case 0 : if (p[my][nx] == EMPTY)	/* open */
	      break;
	    else
	      {
		cont = 0;
		break;
	      }
	    case 1 : if (p[my][nx] == opposingStone)  /* your piece */
	      break;
	    else
	      {
		cont = 0;
		break;
	      }
	    case 2 : if (p[my][nx] == currentStone)  /* my piece */
	      break;
	    else
	      {
		cont = 0;
		break;
	      }
	    case 3 : if (p[my][nx] == EMPTY)	/* open for new move */
	      {
		lib = 0;
		countlib(my, nx, currentStone);	/* check liberty */
		if (lib > 1)  /* move o.k. */
		  {
		    ti = my;
		    tj = nx;
		    break;
		  }
		else
		  {
		    cont = 0;
		    break;
		  }
	      }
	    else
	      {
		cont = 0;
		break;
	      }
	    case 4 : if ((p[my][nx] == EMPTY)  /* open on edge */
			 && ((my == 0) || (my == MAXY - 1) || (nx == 0) || (nx == MAXX - 1)))
	      break;
	    else
	      {
		cont = 0;
		break;
	      }
	    case 5 : if ((p[my][nx] == opposingStone)  /* your piece on edge */
			 && ((my == 0) || (my == MAXY - 1) || (nx == 0) || (nx == MAXX - 1)))
	      break;
	    else
	      {
		cont = 0;
		break;
	      }
	    case 6 : if ((p[my][nx] == currentStone)  /* my piece on edge */
			 && ((my == 0) || (my == MAXY - 1) || (nx == 0) || (nx == MAXX - 1)))
	      break;
	    else
	      {
		cont = 0;
		break;
	      }
	    }
	    ++k;
	  }
	if (cont)   /* match pattern */
	  {
	    tval = pat[r].patwt;
	    if ((r >= 8) && (r <= 13))	/* patterns for expand region */
	      {
		if (line(ti) > 7)  /* penalty on line 1, 2 */
		  tval--;
		else
		  if ((line(ti) == 6) || (line(ti) == 7))
		    tval++;	/* reward on line 3, 4 */
		
		if (line(tj) > 7)  /* penalty on line 1, 2 */
		  tval--;
		else
		  if ((line(tj) == 6) || (line(tj) == 7))
		    tval++;	/* reward on line 3, 4 */
	      }
	    if (tval > *val)
	      {
		*val = tval;
		*i = ti;
		*j = tj;
	      }
	  }
      }
  if (*val > 0)	/* pattern matched */
    return 1;
  else  /* match failed */
    return 0;
}  /* end matchpat */
