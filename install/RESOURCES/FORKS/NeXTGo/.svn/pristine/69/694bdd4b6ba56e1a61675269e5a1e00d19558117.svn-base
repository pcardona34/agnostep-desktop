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

#ifndef _GODICT_PROTOS_
#define _GODICT_PROTOS_

#include "comment.header"

/* $Id: godict.h,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: godict.h,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:38:23  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:57:20  ergo
 * added time control for moves
 *
 */

/* #[info:		*/
/************************************************************************
 *									*
 *	    	   intergo --- An online Go Dictionary			*
 *									*
 *			    Jan van der Steen				*
 *		       Amsterdam, the Netherlands			*
 *									*
 *----------------------------------------------------------------------*
 * File    : godict.h 						*
 * Purpose : Define datatypes to implement a Go dictionary		*
 * Version : 1.5 						*
 * Modified: 1/14/93 23:43:08						*
 * Author  : Jan van der Steen (jansteen@cwi.nl) 			*
 ************************************************************************/
/* #]info:		*/ 
/* #[define:		*/

/*  Define the following when comiling the test program  */
#define _TEST_COMPILE_

/*
 * Default dictionary (full pathname to file)
 */
#ifndef DEFDICT
#define DEFDICT	"intergo.dct"
#endif

/*
 * Special input characters
 */
#define COMMENT '#'             /* Comment indicator */

/*
 * Dictionary codes
 */
#define	CD_MISC	0x01
#define	CD_NAME	0x02
#define	CD_CHAM	0x04
#define	CD_TECH	0x08
#define	CD_POLI	0x10
#define	CD_DIGI	0x20

/*
 * Dictionary languages
 */
#define	LANG_DG	0x0001
#define	LANG_CP	0x0002
#define	LANG_JP	0x0004
#define	LANG_CH	0x0008
#define	LANG_RK	0x0010
#define	LANG_GB	0x0020
#define	LANG_NL	0x0040
#define	LANG_GE	0x0080
#define	LANG_FR	0x0100
#define LANG_SV 0x0200

/*
 * Type messages
 */
#define MSG_MISC	"Unclassified"
#define MSG_NAME   	"Player name"
#define MSG_CHAM   	"Championship title"
#define MSG_TECH   	"Technical term"
#define MSG_POLI   	"Conversation"
#define MSG_DIGI   	"Number"

/*
 * Language specifiers (while writing)
 */
#define LB_CD		"Type:  "
#define LB_JP		"Japanese:  "
#define LB_CH		"Chinese:  "
#define LB_RK		"Korean:  "
#define LB_GB		"English:  "
#define LB_NL		"Dutch:  "
#define LB_GE		"German:  "
#define LB_FR		"French:  "
#define LB_SV		"Swedish:  "
#define LB_DG		"Diagram:  "
#define LB_CP		"Caption:  "
#define LB_EOT		"EOT"	/* end of search */

/*
 * Language specifiers (while reading)
 */
#   define RD_CD	"CD="
#   define RD_JP	"JP="
#   define RD_CH	"CH="
#   define RD_RK	"RK="
#   define RD_GB	"GB="
#   define RD_NL	"NL="
#   define RD_GE	"GE="
#   define RD_FR	"FR="
#   define RD_SV        "SV="
#   define RD_DG	"DG="
#   define RD_CP	"CP="

#define MAXDICTLINE	1024

/* #]define:		*/ 
/* #[typedef:		*/

typedef struct dict_node {
    struct dict_node *	dct_next;
    char *		dct_jp;		/* Japanese		*/
    char *		dct_gb;		/* English		*/
    char *		dct_ch;		/* Chinese		*/
    char *		dct_rk;		/* Korean		*/
    char *		dct_nl;		/* Dutch		*/
    char *		dct_ge;		/* German		*/
    char *		dct_fr;		/* French		*/
    char *              dct_sv;         /* Swedish              */
    char *		dct_dg;		/* Diagram		*/
    char *		dct_cp;		/* Caption		*/
    char *		dct_spec;	/* Only for clients	*/
    int			dct_type;	/* See defines		*/
} GODICT;

/*
 * Loading and Searching routines.
 */
extern GODICT* load_dict(char* filename);
extern void store_dict(char **f, char *s);
extern char* lstr(char *s);
extern GODICT* search_dict(GODICT* gd, char* term);

#endif

