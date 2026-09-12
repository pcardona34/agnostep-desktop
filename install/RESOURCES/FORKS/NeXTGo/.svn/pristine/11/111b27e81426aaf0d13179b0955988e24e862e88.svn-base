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

/* $Id: exambord.c,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: exambord.c,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:34:54  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:00  ergo
 * added time control for moves
 *
 */

#define EMPTY 0
#define BLACKSTONE 2

extern unsigned char p[19][19], l[19][19];
extern int MAXX, MAXY;
extern int currentStone, opposingStone, whiteCaptured, blackCaptured;
extern int whiteCapturedKoI, whiteCapturedKoJ, blackCapturedKoI, blackCapturedKoJ;
extern void eval(int color);

void examboard(int color)
     /* examine pieces */
{
  int i, j, n;

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      if (p[i][j] > 2)
	return;
  
  /* find liberty of each piece */
  eval(color);
  
  /* initialize piece captured */
  if (color == BLACKSTONE)
    {
      blackCapturedKoI = -1;
      blackCapturedKoJ = -1;
    }
  else
    {
      whiteCapturedKoI = -1;
      whiteCapturedKoJ = -1;
    }
  n = 0; /* The number of captures this move for Ko purposes */
  
  /* remove all piece of zero liberty */
  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      if ((p[i][j] == color) && (l[i][j] == 0))
	{
	  p[i][j] = EMPTY;
	  /* record piece captured */
	  if (color == BLACKSTONE)
	    {
	      blackCapturedKoI = i;
	      blackCapturedKoJ = j;
	      ++blackCaptured;
	    }
	  else
	    {
	      whiteCapturedKoI = i;
	      whiteCapturedKoJ = j;
	      ++whiteCaptured;
	    }
	  ++n;  /* increment number of captures on this move */
	}
  /* reset to -1 if more than one stone captured since  no Ko possible */
  if ((color == BLACKSTONE) && (n > 1))
    {
      blackCapturedKoI = -1;
      blackCapturedKoJ = -1;
    }
  else if ( n > 1 )
    {
      whiteCapturedKoI = -1;
      whiteCapturedKoJ = -1;
    }
}  /* end examboard */

