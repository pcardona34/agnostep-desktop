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

/* $Id: fioe.c,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: fioe.c,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:34:59  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:04  ergo
 * added time control for moves
 *
 */

extern unsigned char p[19][19];
extern int MAXX, MAXY;
extern int currentStone;

int fioe(int i, int j)
{
  /* check top edge */
  if (i == 0)
    {
      if ((j == 0) && ((p[1][0] == currentStone) && (p[0][1] == currentStone))) return 1;
      if ((j == MAXY - 1) && ((p[1][MAXY - 1] == currentStone) && (p[0][MAXY - 2] == currentStone))) return 1;
      if ((p[1][j] == currentStone) &&
	  ((p[0][j - 1] == currentStone) && (p[0][j + 1] == currentStone))) return 1;
      else
	return 0;
    }
  /* check bottom edge */
  if (i == MAXX - 1)
    {
      if ((j == 0) && ((p[MAXX - 2][0] == currentStone) && (p[MAXX - 1][1] == currentStone))) return 1;
      if ((j == MAXY - 1) && ((p[MAXX - 2][MAXY - 1] == currentStone) && (p[MAXX - 1][MAXY - 2] == currentStone))) return 1;
      if ((p[MAXX - 2][j] == currentStone) &&
	  ((p[MAXX - 1][j - 1] == currentStone) && (p[MAXX - 1][j + 1] == currentStone)))
	return 1;
      else
	return 0;
    }
  /* check left edge */
  if (j == 0)
    if ((p[i][1] == currentStone) &&
	((p[i - 1] [0] == currentStone) && (p[i + 1][0] == currentStone)))
      return 1;
    else
      return 0;
  /* check right edge */
  if (j == MAXY - 1)
    if ((p[i][MAXY - 2] == currentStone) &&
	((p[i - 1][MAXY - 1] == currentStone) && (p[i + 1][MAXY - 1] == currentStone)))
      return 1;
    else
      return 0;
  /* check center pieces */
  if (((p[i][j - 1] == currentStone) && (p[i][j + 1] == currentStone)) &&
      ((p[i - 1][j] == currentStone) && (p[i + 1][j] == currentStone)))
    return 1;
  else
    return 0;
}  /* fioe */
