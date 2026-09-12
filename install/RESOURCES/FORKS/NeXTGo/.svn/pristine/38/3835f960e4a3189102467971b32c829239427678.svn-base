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

/* $Id: score.c,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: score.c,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:35:06  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:11  ergo
 * added time control for moves
 *
 */

/*  Define the following to debug the scoring routine.  */
/*  #define _DEBUG_SCORING_  */

#define EMPTY        0
#define WHITESTONE   1
#define BLACKSTONE   2
#define NEUTRAL_TERR 3
#define WHITE_TERR   4
#define BLACK_TERR   5

extern unsigned char p[19][19];
extern int MAXX, MAXY;
extern int blackCaptured, whiteCaptured, blackTerritory, whiteTerritory;
unsigned char mark[19][19], ownermat[19][19], scoringmat[19][19];
unsigned char newpatternmat[19][19], tempmat[19][19], patternmat[19][19];

#ifdef _DEBUG_SCORING_
#include <stdio.h>

void display_board(void)
{
  int i, j;

  printf("\n\n");
  for (i = 0; i < MAXX; i++)
    {
      for (j = 0; j < MAXY; j++)
	switch (p[i][j])
	  {
	  case 0: 
	    printf("+");
	    break;
	  case 1:
	    printf("O");
	    break;
	  case 2:
	    printf("X");
	  }
      printf("\n");
    }
}
#endif

void set_temp_to_patternmat(void)
{
  int i, j;

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      newpatternmat[i][j] = patternmat[i][j];
}

void set_patternmat_to_temp(void)
{
  int i, j;

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      patternmat[i][j] = newpatternmat[i][j];
}

void set_p_to_temp(void)
/*  Copy the board to a temporary array.  */
{
  int i, j;

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      p[i][j] = tempmat[i][j];
}

void set_temp_to_p(void)
/*  Copy the temporary array to the board.  */
{
  int i, j;

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      tempmat[i][j] = p[i][j];
}

void find_pattern_in_board(int x, int y)
/*  Find a pattern of stones or blank spots in the board.  */
{
  int i, j, changes = 1, minx, maxx, miny, maxy;

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      patternmat[i][j] = EMPTY;

  patternmat[x][y] = 1;
  minx = (x>0)?x-1:0;
  maxx = (x<MAXX-1)?x+1:MAXX-1;
  miny = (y>0)?y-1:0;
  maxy = (y<MAXY-1)?y+1:MAXY-1;

  while (changes)
    {
      changes = 0;
      set_temp_to_patternmat();
      for (i = minx; i <= maxx; i++)
	for (j = miny; j <= maxy; j++)
	  if (patternmat[i][j] == EMPTY)
	  {
	    /*  Check northern neighbor.  */
	    if (i > 0)
	      {
		if ((patternmat[i-1][j]) && (p[i][j] == p[i-1][j]))
		  {
		    changes++;
		    if (i + 1 > maxx)
		      maxx = (i+1<MAXX-1)?i+1:MAXX-1;
		    newpatternmat[i][j] = 1;
		  }
	      }

	    /*  Check eastern neighbor.  */
	    if (j < MAXY - 1)
	      {
		if ((patternmat[i][j+1]) && (p[i][j] == p[i][j+1]))
		  {
		    changes++;
		    if (j - 1 < miny)
		      miny = (j-1>0)?j-1:0;
		    newpatternmat[i][j] = 1;
		  }
	      }

	    /*  Check southern neighbor.  */
	    if (i < MAXX - 1)
	      {
		if ((patternmat[i+1][j]) && (p[i][j] == p[i+1][j]))
		  {
		    changes++;
		    if (i - 1 < minx)
		      minx = (i-1>0)?i-1:0;
		    newpatternmat[i][j] = 1;
		  }
	      }

	    /*  Check western neighbor.  */
	    if (j > 0)
	      {
		if ((patternmat[i][j-1]) && (p[i][j] == p[i][j-1]))
		  {
		    changes++;
		    if (j + 1 > maxy)
		      maxy = (j+1<MAXY-1)?j+1:MAXY-1;
		    newpatternmat[i][j] = 1;
		  }
	      }
	  }
      set_patternmat_to_temp();
    }
}

void find_owner0(int x, int y)
/*  Routine to the find the owner of the blank spot at x, y.  */
{
  int i, j, changes = 1, owner = 0, minx, maxx, miny, maxy;

/*  clear_mat(patternmat);  */
  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      patternmat[i][j] = EMPTY;

  patternmat[x][y] = mark[x][y] = 1;
  minx = (x>0)?x-1:0;
  maxx = (x<MAXX-1)?x+1:MAXX-1;
  miny = (y>0)?y-1:0;
  maxy = (y<MAXY-1)?y+1:MAXY-1;

  while (changes)
    {
      changes = 0;
      set_temp_to_patternmat();
      for (i = minx; i <= maxx; i++)
	for (j = miny; j <= maxy; j++)
	  if (patternmat[i][j] == EMPTY)
	  {
	    /*  Check northern neighbor.  */
	    if (i > 0)
	      {
		if (patternmat[i-1][j])
		  {
		    if (p[i][j] == EMPTY)
		      {
			changes++;
			if (i + 1 > maxx)
			  maxx = (i+1<MAXX-1)?i+1:MAXX-1;
			newpatternmat[i][j] = mark[i][j] = 1;
		      }
		    else
		      {
			if (owner == 0)
			  owner = p[i][j];
			else if (owner != p[i][j])
			  owner = NEUTRAL_TERR;
		      }
		  }
	      }

	    /*  Check eastern neighbor.  */
	    if (j < MAXY - 1)
	      {
		if (patternmat[i][j+1])
		  {
		    if (p[i][j] == 0)
		      {
			changes++;
			if (j - 1 < miny)
			  miny = (j-1>0)?j-1:0;
			newpatternmat[i][j] = mark[i][j] = 1;
		      }
		    else
		      {
			if (owner == 0)
			  owner = p[i][j];
			else if (owner != p[i][j])
			  owner = NEUTRAL_TERR;
		      }
		  }
	      }

	    /*  Check southern neighbor.  */
	    if (i < MAXX - 1)
	      {
		if (patternmat[i+1][j])
		  {
		    if (p[i][j] == 0)
		      {
			changes++;
			if (i - 1 < minx)
			  minx = (i-1>0)?i-1:0;
			newpatternmat[i][j] = mark[i][j] = 1;
		      }
		    else
		      {
			if (owner == 0)
			  owner = p[i][j];
			else if (owner != p[i][j])
			  owner = NEUTRAL_TERR;
		      }
		  }
	      }

	    /*  Check western neighbor.  */
	    if (j > 0)
	      {
		if (patternmat[i][j-1])
		  {
		    if (p[i][j] == 0)
		      {
			changes++;
			if (j + 1 > maxy)
			  maxy = (j+1<MAXY-1)?j+1:MAXY-1;
			newpatternmat[i][j] = mark[i][j] = 1;
		      }
		    else
		      {
			if (owner == 0)
			  owner = p[i][j];
			else if (owner != p[i][j])
			  owner = NEUTRAL_TERR;
		      }
		  }
	      }
	  }
      set_patternmat_to_temp();
    }

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXX; j++)
      if (patternmat[i][j])
	ownermat[i][j] = owner;
}

void find_owner(void)
/*  Determine ownership of all empty points.  */
{
  int i, j;

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      {
	mark[i][j] = EMPTY;
	ownermat[i][j] = EMPTY;
      }

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      if ((p[i][j] == EMPTY) && (mark[i][j] == EMPTY))
	find_owner0(i, j);
}

int surrounds_territory(int x, int y)
/*  Determine if the stones at x, y surround any territory.  */
{
  int i, j, currentcolor = p[x][y], changes = 1, minx, maxx, miny, maxy;

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      patternmat[i][j] = EMPTY;

  patternmat[x][y] = 1;
  minx = (x>0)?x-1:0;
  maxx = (x<MAXX-1)?x+1:MAXX-1;
  miny = (y>0)?y-1:0;
  maxy = (y<MAXY-1)?y+1:MAXY-1;

  while (changes)
    {
      changes = 0;
      set_temp_to_patternmat();
      for (i = 0; i < MAXX; i++)
	for (j = 0; j < MAXY; j++)
	  if (patternmat[i][j] == 0)
	  {
	    /*  Check northern neighbor.  */
	    if (i > 0)
	      {
		if (patternmat[i-1][j])
		  {
		    if (p[i][j] == 0)
		      {
			if (ownermat[i][j] == currentcolor)
			  return 1;
		      }
		    else
		      {
			if (p[i][j] == currentcolor)
			  {
			    changes++;
			    if (i + 1 > maxx)
			      maxx = (i+1<MAXX-1)?i+1:MAXX-1;
			    newpatternmat[i][j] = 1;
			  }
		      }
		  }
	      }

	    /*  Check eastern neighbor.  */
	    if (j < MAXY - 1)
	      {
		if (patternmat[i][j+1])
		  {
		    if (p[i][j] == 0)
		      {
			if (ownermat[i][j] == currentcolor)
			  return 1;
		      }
		    else
		      {
			if (p[i][j] == currentcolor)
			  {
			    changes++;
			    if (j - 1 < miny)
			      miny = (j-1>0)?j-1:0;
			    newpatternmat[i][j] = 1;
			  }
		      }
		  }
	      }

	    /*  Check southern neighbor.  */
	    if (i < MAXX - 1)
	      {
		if (patternmat[i+1][j])
		  {
		    if (p[i][j] == 0)
		      {
			if (ownermat[i][j] == currentcolor)
			  return 1;
		      }
		    else
		      {
			if (p[i][j] == currentcolor)
			  {
			    changes++;
			    if (i - 1 < minx)
			      minx = (i-1>0)?i-1:0;
			    newpatternmat[i][j] = 1;
			  }
		      }
		  }
	      }

	    /*  Check western neighbor.  */
	    if (j > 0)
	      {
		if (patternmat[i][j-1])
		  {
		    if (p[i][j] == 0)
		      {
			if (ownermat[i][j] == currentcolor)
			  return 1;
		      }
		    else
		      {
			if (p[i][j] == currentcolor)
			  {
			    changes++;
			    if (j + 1 > maxy)
			      maxy = (j+1<MAXY-1)?j+1:MAXY-1;
			    newpatternmat[i][j] = 1;
			  }
		      }
		  }
	      }
	  }
      set_patternmat_to_temp();
    }

  return 0;
}

void score_game(void)
/*  Score the game and remove dead stones.  */
{
  int i, j, k, l, changes = 1, num_in_pattern;

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      scoringmat[i][j] = EMPTY;

  while (changes)
    {
      changes = 0;
      find_owner();

      for (i = 0; i < MAXX; i++)
	for (j = 0; j < MAXY; j++)
	  if ((p[i][j] != EMPTY) && (scoringmat[i][j] == EMPTY))
	    {
	      if (surrounds_territory(i, j))
		{
		  find_pattern_in_board(i, j);

		  for (k = 0; k < MAXX; k++)
		    for (l = 0; l < MAXY; l++)
		      if (patternmat[k][l])
			scoringmat[k][l] = p[k][l];
		}
	      else
		{
		  find_pattern_in_board(i, j);
		  set_temp_to_p();
		  num_in_pattern = 0;

		  for (k = 0; k < MAXX; k++)
		    for (l = 0; l < MAXY; l++)
		      if (patternmat[k][l])
			{
			  p[k][l] = EMPTY;
			  num_in_pattern++;
			}

		  find_owner();

		  if ((ownermat[i][j] != NEUTRAL_TERR) &&
		      (ownermat[i][j] != tempmat[i][j]))
		    {
		      if (tempmat[i][j] == BLACKSTONE)
			blackCaptured += num_in_pattern;
		      else
			whiteCaptured += num_in_pattern;
		      changes++;
		    }
		  else
		    {
		      set_p_to_temp();
		      find_owner();
		    }
		}
	    }
    }

  blackTerritory = 0;
  whiteTerritory = 0;

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      {
	if (ownermat[i][j] == BLACKSTONE)
	  blackTerritory++;
	if (ownermat[i][j] == WHITESTONE)
	  whiteTerritory++;
      }
}
