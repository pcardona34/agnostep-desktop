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

/* $Id: smartgotree.c,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: smartgotree.c,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:35:11  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:15  ergo
 * added time control for moves
 *
 */

#include "smartgo.h"

/*  Define the following variable for debugging information.  */
/*  #define _DEBUG_ON_  */

#ifdef _DEBUG_ON_
#include <stdio.h>

void display_tree(node* root_node)
{
  node *tnode;

  tnode = root_node;

  while (tnode != NULL)
    {
      if (tnode->properties != NULL)
	printf(";");
      if (tnode->variants != NULL)
	{
	  printf("(");
	  display_tree(tnode->variants);
	  printf(")");
	}
      if (tnode->next == NULL)
	{
	  while (tnode->prev != NULL)
	    tnode = tnode->prev;
	  tnode = tnode->next_var;
	  if (tnode != NULL)
	    printf(")(");
	}
      else
	{
	  tnode = tnode->next;
	}
    }
}
#endif

node* forwardOneNode(node* currentNode)
{
  node *tnode;

  if (currentNode->variants != NULL)
    {
      currentNode->variants->recurse = 0;
      return currentNode->variants;
    }
  else if (currentNode->next != NULL)
    {
      currentNode->next->recurse = 0;
      return currentNode->next;
    }
  else
    {
      tnode = currentNode;
      while (tnode->prev != NULL)
	tnode = tnode->prev;
      if (tnode->next_var != NULL)
	{
	  tnode->next_var->recurse = 1;
	  return tnode->next_var;
	}
      else
	{
	  return forwardOneNode0(currentNode->parent);
	}
    }
}

node* forwardOneNode0(node* currentNode)
{
  node *tnode;

  if (currentNode->next != NULL)
    {
      currentNode->next->recurse = 1;
      return currentNode->next;
    }
  else
    {
      tnode = currentNode;
      while (tnode->prev != NULL)
	tnode = tnode->prev;
      if (tnode->next_var != NULL)
	{
	  tnode->next_var->recurse = 1;
	  return tnode->next_var;
	}
      else
	{
	  if (currentNode->parent != NULL)
	    {
	      return forwardOneNode0(currentNode->parent);
	    }
	  else
	    {
	      tnode->recurse = 1;
	      return tnode;
	    }
	}
    }
}

node* backOneNode(node* currentNode)
{
  if (currentNode->prev != NULL)
    {
      if (currentNode->prev->variants != NULL)
	{
	  return findLast(currentNode->prev->variants);
	}
      else
	{
	  currentNode->prev->recurse = 1;
	  return currentNode->prev;
	}
    }
  else
    {
      if (currentNode->prev_var != NULL)
	{
	  return findLast0(currentNode->prev_var);
	}
      else
	{
	  if (currentNode->parent != NULL)
	    {
	      currentNode->parent->recurse = 1;
	      return currentNode->parent;
	    }
	  else
	    {
	      return findLast(currentNode);
	    }
	}
    }
}

node* findLast(node* currentNode)
{
  node *tnode;

  tnode = currentNode;

  while (tnode->next_var != NULL)
    tnode = tnode->next_var;

  while (tnode->next != NULL)
    tnode = tnode->next;

  if (tnode->variants != NULL)
    {
      return findLast(tnode->variants);
    }
  else
    {
      tnode->recurse = 1;
      return tnode;
    }
}

node* findLast0(node* currentNode)
{
  node *tnode;

  tnode = currentNode;

  while (tnode->next != NULL)
    tnode = tnode->next;

  if (tnode->variants != NULL)
    {
      return findLast(tnode->variants);
    }
  else
    {
      tnode->recurse = 1;
      return tnode;
    }
}

node* forwardOneVariant(node* currentNode)
{
  node *tnode;

  tnode = currentNode;

  while (tnode->prev != NULL)
    tnode = tnode->prev;

  if (tnode->next_var != NULL)
    {
      tnode->next_var->recurse = 1;
      return tnode->next_var;
    }
  else
    {
      tnode->parent->variants->recurse = 1;
      return tnode->parent->variants;
    }
}

node* backOneVariant(node* currentNode)
{
  node *tnode;

  tnode = currentNode;

  while (tnode->prev != NULL)
    tnode = tnode->prev;

  if (tnode->prev_var != NULL)
    {
      tnode->prev_var->recurse = 1;
      return tnode->prev_var;
    }
  else
    {
      while (tnode->next_var != NULL)
	tnode = tnode->next_var;

      tnode->recurse = 1;
      return tnode;
    }
}

void clearNodeFlags(node* currentNode)
{
  node *r, *v;

  r = currentNode;
  while (r != NULL)
    {
      r->flag = 0;
      r->recurse = 0;
      v = r->variants;
      while (v != NULL)
	{
	  clearNodeFlags(v);
	  v = v->next_var;
	}
      r = r->next;
    }
}

int foundNode;

int evaluateSteps(node* currentNode, node* targetNode, unsigned char b[19][19])
{
  node *tnode, *vnodes;
  int i, j;
  extern int MAXX, MAXY;
  unsigned char b0[19][19];

  for (i = 0; i < 19; i++)
    for (j = 0; j < 19; j++)
      b0[i][j] = b[i][j];

  tnode = currentNode;
  while (tnode != targetNode)
    {
      if (tnode->properties != NULL)
	{
	  evaluateNode(tnode->properties, b0);
	  tnode->flag = 1;
	}

      vnodes = tnode->variants;
      while (vnodes != NULL)
	{
	  evaluateSteps(vnodes, targetNode, b0);
	  if (foundNode)
	    {
	      for (i = 0; i < MAXX; i++)
		for (j = 0; j < MAXY; j++)
		  b[i][j] = b0[i][j];

	      return 0;
	    }
	  vnodes = vnodes->next_var;
	}

      if (tnode->next == NULL)
	return 0;

      tnode = tnode->next;
    }

  if (tnode == targetNode)
    {
      foundNode = 1;
    }

  if ((tnode == targetNode) && (!tnode->flag) && (tnode->properties != NULL))
    {
      evaluateNode(tnode->properties, b0);
      tnode->flag = 1;

      for (i = 0; i < MAXX; i++)
	for (j = 0; j < MAXY; j++)
	  b[i][j] = b0[i][j];
    }

  return 0;
}

void buildToNode(node* targetNode)
{
  int i, j;
  extern int blackCaptured, whiteCaptured, lastMove, hist[19][19];
  extern unsigned char p[19][19];
  extern node *rootNode;

  for (i = 0; i < 19; i++)
    for (j = 0; j < 19; j++)
      p[i][j] = hist[i][j] = 0;
  blackCaptured = whiteCaptured = lastMove = 0;
  clearNodeFlags(rootNode);

  foundNode = 0;

  evaluateSteps(rootNode, targetNode, p);
}

node* stepForward(node* currentNode)
{
  node *tnode;
  extern node *rootNode;

  tnode = currentNode;
  do
    {
      tnode = forwardOneNode(tnode);
    }
  while ((tnode->properties == NULL) && (tnode != currentNode));

  if (tnode == currentNode)
    {
      tnode = rootNode;

      do
	{
	  tnode = forwardOneNode(tnode);
	}
      while (tnode->properties == NULL);
    }

  buildToNode(tnode);

  return tnode;
}

node* stepBackward(node* currentNode)
{
  node *tnode;
  extern node *rootNode;

  tnode = currentNode;
  do
    {
      tnode = backOneNode(tnode);
    }
  while ((tnode->properties == NULL) && (tnode != currentNode));

  if (tnode == currentNode)
    {
      tnode = rootNode;

      tnode = findLast(tnode);
    }

  buildToNode(tnode);

  return tnode;
}

node* jumpForward(node* currentNode)
{
  node *tnode;

  tnode = currentNode;

  tnode = forwardOneVariant(tnode);

  while (tnode->properties == NULL)
    {
      tnode = forwardOneNode(tnode);
    }

  buildToNode(tnode);

  return tnode;
}

node* jumpBackward(node* currentNode)
{
  node *tnode;

  tnode = currentNode;
  tnode = backOneVariant(tnode);

  while (tnode->properties == NULL)
    {
      tnode = forwardOneNode(tnode);
    }

  buildToNode(tnode);

  return tnode;
}

