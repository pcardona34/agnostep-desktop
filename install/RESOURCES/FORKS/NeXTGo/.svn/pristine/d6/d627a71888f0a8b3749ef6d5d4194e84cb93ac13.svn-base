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

/* $Id: patterns.h,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: patterns.h,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:38:26  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:22  ergo
 * added time control for moves
 *
 */

#define EMPTY 0
#define PATNO 24

/* pattern x, y coor and attribute */
/* for each pattern coordinate 0,0 must have my piece */
/* att = 0 - empty, 1 - your piece, 2 - my piece, 3 - my next move */
/* 4 - empty on edge, 5 - your piece on edge, 6 - my piece on edge */
/*
  struct patval {int x, y, att;};
  */

/* patn - patern */
/* patlen - no. of pieces in pattern */
/* trfno - no. of transformation to match pattern */
/*	   8 for normal pattern, 4 for symmetrical pattern */
/* patwt - pattern value */
/*
  struct pattern {
  struct patval patn[MAXPC];
  int patlen, trfno, patwt;
  };
  */
static struct pattern pat[PATNO] = {
  /*
    pattern 0: 232   connect if invaded
    010
    */
  {{{0, 0, 2},
      {0, 1, EMPTY},
      {1, 0, 3},
      {1, 1, 1},
      {2, 0, 2},
      {2, 1, EMPTY}}, 6, 4, 82},
  /*
    pattern 1: 230   connect if invaded
    012
    */
  {{{0, 0, 2},
      {0, 1, EMPTY},
      {1, 0, 3},
      {1, 1, 1},
      {2, 0, EMPTY},
      {2, 1, 2}}, 6, 8, 82},
  /*
    pattern 2: 212   try to attack
    030
    */
  {{{0, 0, 2},
      {0, 1, EMPTY},
      {1, 0, 1},
      {1, 1, 3},
      {2, 0, 2},
      {2, 1, EMPTY}}, 6, 4, 82},
  /*
    pattern 3: 2302   connect if invaded
    0100
    */
  {{{0, 0, 2},
      {0, 1, EMPTY},
      {1, 0, 3},
      {1, 1, 1},
      {2, 0, EMPTY},
      {2, 1, EMPTY},
      {3, 0, 2},
      {3, 1, EMPTY}},8, 8, 83},
  /*
    pattern 4: 20302   connect if invaded
    00100
    */
  {{{0, 0, 2},
      {0, 1, EMPTY},
      {1, 0, EMPTY},
      {1, 1, EMPTY},
      {2, 0, 3},
      {2, 1, 1},
      {3, 0, EMPTY},
      {3, 1, EMPTY},
      {4, 0, 2},
      {4, 1, EMPTY}}, 10, 4, 84},
  /*
    pattern 5: 203   form eye to protect
    021
    */
  {{{0, 0, 2},
      {0, 1, EMPTY},
      {1, 0, EMPTY},
      {1, 1, 2},
      {2, 0, 3},
      {2, 1, 1}}, 6, 8, 82},
  /*
    pattern 6: 202    form eye to protect
    031
    */
  {{{0, 0, 2},
      {0, 1, EMPTY},
      {1, 0, EMPTY},
      {1, 1, 3},
      {2, 0, 2},
      {2, 1, 1}}, 6, 8, 82},
  /*
    pattern 7: 230   connect if invaded
    102
    */
  {{{0, 0, 2},
      {0, 1, 1},
      {1, 0, 3},
      {1, 1, EMPTY},
      {2, 0, EMPTY},
      {2, 1, 2}}, 6, 8, 82},
  /*
    pattern 8: 200000
    00030  extend
    00000
    */
  {{{0, 0, 2},
      {1, 0, EMPTY},
      {2, 0, EMPTY},
      {3, 0, EMPTY},
      {4, 0, EMPTY},
      {5, 0, EMPTY},
      {1, 1, EMPTY},
      {2, 1, EMPTY},
      {3, 1, EMPTY},
      {4, 1, 3},
      {5, 1, EMPTY},
      {1, 2, EMPTY},
      {2, 2, EMPTY},
      {3, 2, EMPTY},
      {4, 2, EMPTY},
      {5, 2, EMPTY}}, 16, 8, 80},
  /*
    pattern 9:  2
    000
    000  extend
    000
    030
    000
    */
  {{{ 0, 0, 2},
      {-1, 1, EMPTY},
      { 0, 1, EMPTY},
      { 1, 1, EMPTY},
      {-1, 2, EMPTY},
      { 0, 2, EMPTY},
      { 1, 2, EMPTY},
      {-1, 3, EMPTY},
      { 0, 3, EMPTY},
      { 1, 3, EMPTY},
      {-1, 4, EMPTY},
      { 0, 4, 3},
      { 1, 4, EMPTY},
      {-1, 5, EMPTY},
      { 0, 5, EMPTY},
      { 1, 5, EMPTY}}, 16, 4, 80},
  /*
    pattern 10: 20000
    0030  extend
    0000
    */
  {{{0, 0, 2},
      {1, 0, EMPTY},
      {2, 0, EMPTY},
      {3, 0, EMPTY},
      {4, 0, EMPTY},
      {1, 1, EMPTY},
      {2, 1, EMPTY},
      {3, 1, 3},
      {4, 1, EMPTY},
      {1, 2, EMPTY},
      {2, 2, EMPTY},
      {3, 2, EMPTY},
      {4, 2, EMPTY}}, 13, 8, 79},
  /*
    pattern 11:	2
    000
    000  extend
    030
    000
    */
  {{{ 0, 0, 2},
      {-1, 1, EMPTY},
      { 0, 1, EMPTY},
      { 1, 1, EMPTY},
      {-1, 2, EMPTY},
      { 0, 2, EMPTY},
      { 1, 2, EMPTY},
      {-1, 3, EMPTY},
      { 0, 3, 3},
      { 1, 3, EMPTY},
      {-1, 4, EMPTY},
      { 0, 4, EMPTY},
      { 1, 4, EMPTY}}, 13, 4, 79},
  /*
    pattern 12: 2000
    030  extend
    000
    */
  {{{0, 0, 2},
      {1, 0, EMPTY},
      {2, 0, EMPTY},
      {3, 0, EMPTY},
      {1, 1, EMPTY},
      {2, 1, 3},
      {3, 1, EMPTY},
      {1, 2, EMPTY},
      {2, 2, EMPTY},
      {3, 2, EMPTY}}, 10, 8, 76},
  /*
    pattern 13:	2
    000  extend
    030
    000
    */
  {{{ 0, 0, 2},
      {-1, 1, EMPTY},
      { 0, 1, EMPTY},
      { 1, 1, EMPTY},
      {-1, 2, EMPTY},
      { 0, 2, 3},
      { 1, 2, EMPTY},
      {-1, 3, EMPTY},
      { 0, 3, EMPTY},
      { 1, 3, EMPTY}}, 10, 4, 76},
  /*
    pattern 14: 643   form eye on the edge
    20
    */
  {{{0, 0, 6},
      {1, 0, 4},
      {1, 1, 2},
      {2, 0, 3},
      {2, 1, EMPTY}}, 5, 8, 80},
  /*
    pattern 15: 646    solidify eye on the edge
    231
    */
  {{{0, 0, 6},
      {1, 0, 4},
      {1, 1, 2},
      {2, 0, 6},
      {2, 1, 3},
      {3, 1, 1}}, 6, 8, 75},
  /*
    pattern 16: 646    solidify eye on the edge
    230
    1
    */
  {{{0, 0, 6},
      {1, 0, 4},
      {1, 1, 2},
      {2, 0, 6},
      {2, 1, 3},
      {2, 2, 1},
      {3, 1, EMPTY}}, 7, 8, 75},
  /*
    pattern 17: 646    solidify eye on the edge
    230
    0
    */
  {{{0, 0, 6},
      {1, 0, 4},
      {1, 1, 2},
      {2, 0, 6},
      {2, 1, 3},
      {2, 2, EMPTY},
      {3, 1, EMPTY}}, 7, 8, 75},
  /*
    pattern 18:	2	   form eye on center
    202
    3
    */
  {{{0, 0, 2},
      {-1, 1, 2},
      {0, 1, EMPTY},
      {1, 1, 2},
      {0, 2, 3}}, 5, 4, 80},
  /*
    pattern 19:	2	   solidify eye on center
    202
    231
    */
  {{{0, 0, 2},
      {-1, 1, 2},
      {0, 1, EMPTY},
      {1, 1, 2},
      {0, 2, 2},
      {1, 2, 3},
      {2, 2, 1}}, 7, 8, 75},
  /*
    pattern 20:	2	   solidify eye on center
    202
    230
    0
    */
  {{{0, 0, 2},
      {-1, 1, 2},
      {0, 1, EMPTY},
      {1, 1, 2},
      {0, 2, 2},
      {1, 2, 3},
      {2, 2, EMPTY},
      {1, 3, EMPTY}}, 8, 8, 75},
  /*
    pattern 21:	2	  solidify eye on center
    202
    230
    1
    */
  {{{0, 0, 2},
      {-1, 1, 2},
      {0, 1, EMPTY},
      {1, 1, 2},
      {0, 2, 2},
      {1, 2, 3},
      {2, 2, EMPTY},
      {1, 3, 1}}, 8, 8, 75},
  /*
    pattern 23: 20100	 connect if invaded
    00302
    */
  {{{0, 0, 2},
      {0, 1, EMPTY},
      {1, 0, EMPTY},
      {1, 1, EMPTY},
      {2, 0, 1},
      {2, 1, 3},
      {3, 0, EMPTY},
      {3, 1, EMPTY},
      {4, 0, EMPTY},
      {4, 1, 2}}, 10, 8, 84},
  /*
    pattern 24: 2100	connect if invaded
    0302
    */
  {{{0, 0, 2},
      {0, 1, EMPTY},
      {1, 0, 1},
      {1, 1, 3},
      {2, 0, EMPTY},
      {2, 1, EMPTY},
      {3, 0, EMPTY},
      {3, 1, 2}}, 10, 8, 83}
};
/* end patterns */
