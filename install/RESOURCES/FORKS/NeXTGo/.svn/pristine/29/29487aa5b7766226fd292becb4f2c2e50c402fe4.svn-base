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

/* $Id: openregn.c,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: openregn.c,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:35:04  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:09  ergo
 * added time control for moves
 *
 */

#define EMPTY 0

extern unsigned char p[19][19];

int openregion(int i1, int j1, int i2, int j2)
     /* check if region from i1, j1 to i2, j2 is open */
{
  int minx, maxx, miny, maxy, x, y;
  
  /* exchange upper and lower limits */
  
  if (i1 < i2)
    {
      miny = i1;
      maxy = i2;
    }
  else
    {
      miny = i2;
      maxy = i1;
    }
  
  if (j1 < j2)
    {
      minx = j1;
      maxx = j2;
    }
  else
    {
      minx = j2;
      maxx = j1;
    }
  
  /* check for empty region */
  for (y = miny; y <= maxy; y++)
    for (x = minx; x <= maxx; x++)
      if (p[y][x] != EMPTY) return 0;
  return 1;
}  /* end openregion */
