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

/* $Id: smartgo.h,v 1.2 2005/11/05 20:28:08 gcasa Exp $ */

/*
 * $Log: smartgo.h,v $
 * Revision 1.2  2005/11/05 20:28:08  gcasa
 * Updated declarations.
 *
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:38:27  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:23  ergo
 * added time control for moves
 *
 */

#ifndef _SMART_GO_DEFINITIONS_
#define _SMART_GO_DEFINITIONS_

#include <stdio.h>

#define MAX_LETTERS 12
#define MAXCOMMENT 4097
#define MAXCOMMENTLINES 300
#define MAXCOMMENTWIDTH 50

typedef enum {
  t_White,
  t_Black,
  t_Open,
  t_Close,
  t_NewNode,
  t_Comment,
  t_AddWhite,
  t_AddBlack,
  t_Letter,
  t_Mark,
  t_AddEmpty,
  t_Name,
  t_Pass,
  t_Player,
  t_Size,
  t_Handicap,
  t_PlayerBlack,
  t_BlackRank,
  t_PlayerWhite,
  t_WhiteRank,
  t_GameName,
  t_Event,
  t_Round,
  t_Date,
  t_Place,
  t_TimeLimit,
  t_Result,
  t_GameComment,
  t_Source,
  t_User,
  t_Komi,

  t_WS,
  t_EOF
  } Token;


typedef struct _node {
  int nodenum, flag, recurse;
  struct _node *parent, *variants, *next_var, *prev_var, *next, *prev;
  char *properties;
} node;


/*   Routines from smartgoparse.c needed by other routines.  */
extern node* parse_tree(char* inputBuffer);

/*   Routines from smartgoeval.c needed by other routines.   */
extern void evaluateNode(char *c, unsigned char b[19][19]);


/*   Routines from smartgotree.c needed by other routines.  */
extern node* forwardOneNode(node* currentNode);
extern node* forwardOneNode0(node* currentNode);
extern node* backOneNode(node* currentNode);
extern node* findLast(node* currentNode);
extern node* findLast0(node* currentNode);
extern node* forwardOneVariant(node* currentNode);
extern node* backOneVariant(node* currentNode);
extern void clearNodeFlags(node* currentNode);
extern int evaluateSteps(node* currentNode, node* targetNode, unsigned char b[19][19]);
extern void buildToNode(node* targetNode);
extern node* stepForward(node* currentNode);
extern node* stepBackward(node* currentNode);
extern node* jumpForward(node* currentNode);
extern node* jumpBackward(node* currentNode);


#endif

