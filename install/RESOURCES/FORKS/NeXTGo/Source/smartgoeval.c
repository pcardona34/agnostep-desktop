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

/* $Id: smartgoeval.c,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: smartgoeval.c,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:35:08  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:13  ergo
 * added time control for moves
 *
 */

/*  Define the following if you want to debug the move list features.  */
/*  #define _DEBUG_MOVE_LISTS_  */

#include <string.h>
#include "smartgo.h"
#include "smgcom.h"

#define EMPTY 0
#define WHITE 1
#define BLACK 2
#define MARK 3
#define LETTER 6

#ifdef _DEBUG_MOVE_LISTS_
#include <stdio.h>

void display_current_board(unsigned char b[19][19])
{
  int i, j;
  extern int MAXX, MAXY;

  printf("  ");
  for (i = 0; i < MAXX; i++)
    printf("%c ", i+'a');
  printf("\n");
  for (i = 0; i < MAXX; i++)
    {
      printf("%c ", i+'a');
      for (j = 0; j < MAXY; j++)
	switch (b[j][i]) {
	case 0:
	  printf(". ");
	  break;
	case 1:
	  printf("O ");
	  break;
	case 2:
	  printf("X ");
	  break;
	case 3:
	  printf("M ");
	  break;
	case 4:
	  printf("w ");
	  break;
	case 5:
	  printf("b ");
	  break;
	case 6:
	  printf("S ");
	  break;
	default:
	  break;
	}
      printf("\n");
    }
  printf("\n");
}
#endif

char* parseSGMove(char *c0, int *x, int *y)
{
  if (*c0 == '[')
    c0++;

  *x = *c0 - 'a';
  c0++;
  *y = *c0 - 'a';
  c0++;

  if (*c0 == ']')
    c0++;

  return c0;
}

char* parseRegularMove(Token t, char* c0, unsigned char b[19][19])
{
  int i, j;
  unsigned char temp[19][19];
  extern int MAXX, MAXY, currentStone, opposingStone, lastMove, hist[19][19];
  extern int boardChanged;
  extern unsigned char p[19][19];
  extern void examboard(int);

  c0 = parseSGMove(c0, &i, &j);

  if ((i >= 0) && (i < MAXX) && (j >= 0) && (j < MAXY))
    {
      switch (t)
	{
	case t_White:
	  b[i][j] = WHITE;
	  currentStone = WHITE;
	  opposingStone = BLACK;
	  break;
	case t_Black:
	  b[i][j] = BLACK;
	  currentStone = BLACK;
	  opposingStone = WHITE;
	  break;
	default:
	  break;
	}
      lastMove++;
      hist[i][j] = lastMove;
      for (i = 0; i < MAXX; i++)
	for (j = 0; j < MAXY; j++)
	  temp[i][j] = p[i][j];
      for (i = 0; i < MAXX; i++)
	for (j = 0; j < MAXY; j++)
	  p[i][j] = b[i][j];
      examboard(opposingStone);
      for (i = 0; i < MAXX; i++)
	for (j = 0; j < MAXY; j++)
	  b[i][j] = p[i][j];
      for (i = 0; i < MAXX; i++)
	for (j = 0; j < MAXY; j++)
	  p[i][j] = temp[i][j];
    }
  boardChanged = 1;

  return c0;
}

char* parseComment(char* c0)
{
  int i;
  extern char sgComment[2000];

  if (*c0 == '[')
    c0++;

  i = 0;
  while (*c0 != ']')
    {
      if (*c0 == '\\')
	c0++;
      sgComment[i] = *c0;

      i++;
      c0++;
    }
  sgComment[i] = 0;
  return c0;
}

char* parseMoveList(Token t, char* c0, unsigned char b[19][19])
{
  int x, y;
  extern int MAXX, MAXY, boardChanged;

  while (*c0 == '[')
    {
      c0 = parseSGMove(c0, &x, &y);

      if ((x >= 0) && (x < MAXX) && (y >= 0) && (y < MAXY))
	switch (t)
	  {
	  case t_AddWhite:
	    b[x][y] = WHITE;
	    break;
	  case t_AddBlack:
	    b[x][y] = BLACK;
	    break;
	  case t_Letter:
	    b[x][y] = LETTER;
	    break;
	  case t_Mark:
	    b[x][y] = MARK;
	    break;
	  case t_AddEmpty:
	    b[x][y] = EMPTY;
	    break;
	  default:
	    break;
	  }
      if (*c0 == '\n')
	c0++;
    }
  boardChanged = 1;

#ifdef _DEBUG_MOVE_LISTS_
  display_current_board(b);
#endif
  return c0;
}

char* parseNodeName(char* c0)
{
  int i;
  extern char sgNodeName[200];

  if (*c0 == '[')
    c0++;

  i = 0;
  while (*c0 != ']')
    {
      if (*c0 == '\\')
	c0++;
      sgNodeName[i] = *c0;

      i++;
      c0++;
    }
  sgNodeName[i] = 0;
  return c0;
}

char* parseSize(char* c0)
{
  int i, j;
  char sizeStr[10];
  extern int MAXX, MAXY;

  if (*c0 == '[')
    c0++;

  i = 0;
  while (*c0 != ']')
    {
      sizeStr[i] = *c0;
      i++;
      c0++;
    }

  sscanf(sizeStr, "%d", &j);
  if ((j > 0) && (j <= 19))
    MAXX = MAXY = j;
  return c0;
}

char* parseHandicap(char* c0)
{
  int i, j;
  char handStr[10];
  extern int handicap;

  if (*c0 == '[')
    c0++;

  i = 0;
  while (*c0 != ']')
    {
      handStr[i] = *c0;
      i++;
      c0++;
    }

  sscanf(handStr, "%d", &j);
  if ((j > 0) && (j <= 9))
    handicap = j;
  return c0;
}

char* parseInfo(Token t, char* c0)
{
  int i;
  char sgInfo[2000];

  if (*c0 == '[')
    c0++;

  i = 0;
  while (*c0 != ']')
    {
      if (*c0 == '\\')
	c0++;
      sgInfo[i] = *c0;

      i++;
      c0++;
    }
  sgInfo[i] = 0;
  return c0;
}

char* parseKomi(char* c0)
{
  int i;
  char komiStr[10];
  float komiValue;

  if (*c0 == '[')
    c0++;

  i = 0;
  while (*c0 != ']')
    {
      komiStr[i] = *c0;
      i++;
      c0++;
    }

  sscanf(komiStr, "%f", &komiValue);
  return c0;
}

void evaluateNode(char* c, unsigned char b[19][19])
{
  int i, j, k;
  extern int MAXX, MAXY;
  char *c0, command[3];
  Token t;
  extern char sgComment[2000], sgNodeName[200];
  extern int boardChanged;

  boardChanged = 0;

  strcpy(sgComment, "");
  strcpy(sgNodeName, "");

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      if (b[i][j] > 2)
	b[i][j] = 0;

  c0 = c;
  if (*c0 == ';' || *c0 == '(' || *c0 == ')')
    c0++;

  command[0] = command[1] = command[2] = 0;
  i = 0;
  j = 1;

  do
    {
      if ((*c0 == ';') || (*c0 == '(') || (*c0 == ')'))
	{
	  j = 0;
	}
      else if ((*c0 >= 'A') && (*c0 <= 'Z'))
	{
	  command[i] = *c0;
	  c0++;
	  i++;
	}
      else if (*c0 == '[')
	{
	  command[i] = 0;
	  i = 0;
	  t = t_WS;
	  for (k = 0; k < 27; k++)
	    if (strcmp(command, commands[k].str) == 0)
	      t = commands[k].val;

	  switch (t)
	    {
	    case t_White:
	    case t_Black:
	      c0 = parseRegularMove(t, c0, b);
	      break;
	    case t_Comment:
	      c0 = parseComment(c0);
	      break;
	    case t_AddWhite:
	    case t_AddBlack:
	    case t_Letter:
	    case t_Mark:
	    case t_AddEmpty:
	      c0 = parseMoveList(t, c0, b);
	      break;
	    case t_Name:
	      c0 = parseNodeName(c0);
	      break;
	    case t_Size:
	      c0 = parseSize(c0);
	      break;
	    case t_Handicap:
	      c0 = parseHandicap(c0);
	      break;
	    case t_PlayerBlack:
	    case t_PlayerWhite:
	    case t_WhiteRank:
	    case t_BlackRank:
	    case t_GameName:
	    case t_Event:
	    case t_Round:
	    case t_Date:
	    case t_Place:
	    case t_TimeLimit:
	    case t_Result:
	    case t_GameComment:
	    case t_Source:
	    case t_User:
	      c0 = parseInfo(t, c0);
	      break;
	    case t_Komi:
	      c0 = parseKomi(c0);
	      break;
	    default:
	      c0++;
	      break;
	    }
	}
      else c0++;
    } while (j);
}
