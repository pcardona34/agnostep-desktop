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

/* $Id: sethand.c,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: sethand.c,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:35:08  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:12  ergo
 * added time control for moves
 *
 */

#define BLACKSTONE 2

extern unsigned char p[19][19];
extern int MAXX, MAXY;

void sethand(int i)
     /* set up handicap pieces */
{
  int half, q;
  
  half = (MAXX + 1)/2 - 1;
  if (MAXX < 13)
    q = 2;
  else
    q = 3;
  
  if (i > 0)
    {
      p[q][MAXY - q - 1] = BLACKSTONE;
      if (i > 1)
	{
	  p[MAXX - q - 1][q] = BLACKSTONE;
	  if (i > 2)
	    {
	      p[q][q] = BLACKSTONE;
	      if (i > 3)
		{
		  p[MAXX - q - 1][MAXY - q - 1] = BLACKSTONE;
		  if (i == 5)
		    p[half][half] = BLACKSTONE;
		  else
		    if (i > 5)
		      {
			p[q][half] = BLACKSTONE;
			p[MAXX - q - 1][half] = BLACKSTONE;
			if (i == 7)
			  p[half][half] = BLACKSTONE;
			else
			  if (i > 7)
			    {
			      p[half][MAXY - q - 1] = BLACKSTONE;
			      p[half][q] = BLACKSTONE;
			      if (i > 8)
				p[half][half] = BLACKSTONE;
			      if (i > 9)
				{p[q - 1][q - 1] = BLACKSTONE;
				 if (i > 10)
				   {p[MAXX - q][MAXY - q] = BLACKSTONE;
				    if (i > 11)
				      {p[q - 1][MAXY - q] = BLACKSTONE;
				       if (i > 12)
					 {p[MAXX - q][q - 1] = BLACKSTONE;
					  if (i > 13)
					    {p[(q + half)/2][(q + half)/2] = BLACKSTONE;
					     if (i > 14)
					       {p[(MAXX - q + half)/2][(MAXY - q + half)/2] = BLACKSTONE;
						if (i > 15)
						  {p[(q + half)/2][(MAXY - q + half)/2] = BLACKSTONE;
						   if (i > 16)
						     p[(MAXX - q + half)/2][(q + half)/2] = BLACKSTONE;
						 }
					      }
					   }
					}
				     }
				  }
			       }
			    }
		      }
		}
	    }
	}
    }
}  /* end sethand */
