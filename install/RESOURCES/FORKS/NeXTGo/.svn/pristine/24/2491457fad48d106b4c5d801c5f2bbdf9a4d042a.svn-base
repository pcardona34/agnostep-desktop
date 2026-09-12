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

/* $Id: godict.c,v 1.2 2005/04/06 00:32:58 gcasa Exp $ */

/*
 * $Log: godict.c,v $
 * Revision 1.2  2005/04/06 00:32:58  gcasa
 * Cleaned up the code.
 *
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.4  1997/11/04 16:52:59  ergo
 * ported to OpenStep
 *
 * Revision 1.3  1997/07/06 19:35:01  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:05  ergo
 * added time control for moves
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "godict.h"

#define LANGENTRY(line,label)    (!strncmp(line,label,strlen(label)))
/*
#ifndef _TEST_COMPILE_
extern int NSRunAlertPanel(const char *title, const char *msg, const char *defaultButton, const char *alternateButton, const char *otherButton, ...);
#endif
*/
#ifdef _DEBUG_DICT_
FILE *dump;
#endif

GODICT* load_dict(char* filename)
{
  FILE *godictfile;
  GODICT *d, *dp, *d_old;
  char line[MAXDICTLINE];
  int linenr = 0;

  dp = NULL;
  d = NULL;

#ifdef _DEBUG_DICT_
  dump = fopen("debug.dict","w");
#endif

  if ((godictfile = fopen(filename,"r")) == NULL)
    {
      return NULL;
    }

  while (fgets(line, MAXDICTLINE, godictfile) != NULL)
    {
      char *newline;

      linenr++;
      if ((newline = strchr(line, '\n')) != (char *)0) *newline = 0;
      if ((newline = strchr(line, '\r')) != (char *)0) *newline = 0;

      if ((*line == 0) || (*line == COMMENT)) continue;

      if (strlen(line) < strlen(RD_CD))
	{
	  char s[80];

	  sprintf(s, "There is a bad entry on line %d.", linenr);
#ifndef _TEST_COMPILE_
	  NSRunAlertPanel(@"NeXTGo Dictionary", [NSString stringWithCString:s], @"OK", nil, nil);
#endif
	}
      else if (strncmp(line, RD_CD, strlen(RD_CD)) == 0)
	{
	  d_old = d;
	  d = (GODICT *) malloc(sizeof(GODICT));
	  d->dct_jp = NULL;
	  d->dct_ch = NULL;
	  d->dct_rk = NULL;
	  d->dct_gb = NULL;
	  d->dct_nl = NULL;
	  d->dct_ge = NULL;
	  d->dct_fr = NULL;
	  d->dct_sv = NULL;
	  d->dct_dg = NULL;
	  d->dct_cp = NULL;

	  if (dp == NULL)
	    {
	      dp = d;
	    }
	  else
	    {
	      d_old->dct_next = d;
	    }

	  switch (*(line+strlen(RD_CD)))
	    {
	    case 'n':  d->dct_type = CD_NAME;
	      break;
	    case 'c':  d->dct_type = CD_CHAM;
	      break;
	    case 't':  d->dct_type = CD_TECH;
	      break;
	    case 'p':  d->dct_type = CD_POLI;
	      break;
	    case 'd':  d->dct_type = CD_DIGI;
	      break;
	    default:  d->dct_type = CD_MISC;
	      break;
	    }
	}
      else if LANGENTRY(line,RD_JP)
	{
	  store_dict(&(d->dct_jp), line+strlen(RD_JP));
	}
      else if LANGENTRY(line,RD_CH)
	{
	  store_dict(&(d->dct_ch), line+strlen(RD_CH));
	}
      else if LANGENTRY(line,RD_RK)
	{
	  store_dict(&(d->dct_rk), line+strlen(RD_RK));
	}
      else if LANGENTRY(line,RD_GB)
	{
	  store_dict(&(d->dct_gb), line+strlen(RD_GB));
	}
      else if LANGENTRY(line,RD_NL)
	{
	  store_dict(&(d->dct_nl), line+strlen(RD_NL));
	}
      else if LANGENTRY(line,RD_GE)
	{
	  store_dict(&(d->dct_ge), line+strlen(RD_GE));
	}
      else if LANGENTRY(line,RD_FR)
	{
	  store_dict(&(d->dct_fr), line+strlen(RD_FR));
	}
      else if LANGENTRY(line,RD_SV)
	{
	  store_dict(&(d->dct_sv), line+strlen(RD_SV));
	}
      else if LANGENTRY(line,RD_DG)
	{
	  store_dict(&(d->dct_dg), line+strlen(RD_DG));
	}
      else if LANGENTRY(line,RD_CP)
	{
	  store_dict(&(d->dct_cp), line+strlen(RD_CP));
	}

    }

  fclose(godictfile);
  return dp;
}

void store_dict(char **f, char *s)
{
  int more = (*f != NULL);
  long needed = strlen(s) + 1;

  if (!*s) return;

  if (more)
    {
      needed += strlen(*f) + 1;
      *f = (char *) realloc(*f, needed);
    }
  else
    {
      *f = (char *) malloc(needed);
    }

  if (more)
    {
      strcat(*f, "\n");
      strcat(*f, lstr(s));
    }
  else
    {
      strcpy(*f, lstr(s));
    }
#ifdef _DEBUG_DICT_
  fprintf(dump,"Added:  %s",s);
#endif
}

char* lstr(char *s)
{
  char *t;

  for (t = s; *t; t++)
    if (isupper(*t))
      *t = tolower(*t);

  return s;
}

int substr(char s[], char sub_s[])
{
  int i, j, k;

  if (s == NULL || sub_s == NULL)
    return 0;

  if (strlen(s) < strlen(sub_s))
    return 0;

  for (i = 0; i < strlen(s) - strlen(sub_s); i++)
    {
      k = 1;
      for (j = 0; (j < strlen(sub_s)) && k; j++)
	{
	  if (sub_s[j] != s[i+j]) k = 0;
	}
      if (k)
	{
	  return 1;
	}
    }

  return 0;
}

int termtypes, languages;

GODICT* search_dict(GODICT* gd, char* term)
{
  GODICT *d;
  char s[80];

  d = gd;
  term = lstr(term);
  sprintf(s,"Starting search for %s.",term);
  while (d != NULL)
    {
      if (d->dct_type & termtypes)
	{
	  if ((languages & (LANG_JP)) && d->dct_jp && strstr(d->dct_jp,term))
	    return d;
	  if ((languages & (LANG_CH)) && d->dct_ch && strstr(d->dct_ch,term))
	    return d;
	  if ((languages & (LANG_RK)) && d->dct_rk && strstr(d->dct_rk,term))
	    return d;
	  if ((languages & (LANG_GB)) && d->dct_gb && strstr(d->dct_gb,term))
	    return d;
	  if ((languages & (LANG_NL)) && d->dct_nl && strstr(d->dct_nl,term))
	    return d;
	  if ((languages & (LANG_GE)) && d->dct_ge && strstr(d->dct_ge,term))
	    return d;
	  if ((languages & (LANG_FR)) && d->dct_fr && strstr(d->dct_fr,term))
	    return d;
	  if ((languages & (LANG_SV)) && d->dct_sv && strstr(d->dct_sv,term))
	    return d;
	  if ((languages & (LANG_DG)) && d->dct_dg && strstr(d->dct_dg,term))
	    return d;
	  if ((languages & (LANG_CP)) && d->dct_cp && strstr(d->dct_cp,term))
	    return d;
	}
      d = d->dct_next;
    }

  return NULL;
}
