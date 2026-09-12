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

#ifndef SHARED_H
#define SHARED_H

/* $Id: shared.h,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: shared.h,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:38:26  ergo
 * actual version
 *
 * Revision 1.3  1997/05/04 18:57:23  ergo
 * added time control for moves
 *
 */

#ifndef BIT
#define BIT(n) (1L << (n))
#endif /* BIT */
#define MAX_BRD_SZ 25

typedef enum {
	UNKNOWN	=  0,
	BEEP	=  2, 	/* \7 telnet 		*/
	BOARD	=  3,	/* Board being drawn 	*/
	DOWN	=  4,	/* The server is going down */
	ERROR	=  5,	/* An error reported	*/
    FIL		=  6,	/* File being sent	*/
	GAMES	=  7,	/* Games listing	*/
    HELP	=  8,	/* Help file		*/
	INFO	=  9,	/* Generic info		*/
	LAST	= 10,	/* Last command		*/
   	KIBITZ	= 11,	/* Kibitz strings	*/
	LOAD	= 12,	/* Loading a game	*/
	LOOK_M	= 13,	/* Look 		*/
    MESSAGE	= 14,	/* Message lising	*/
    MOVE	= 15,	/* Move #:(B) A1	*/
	OBSERVE	= 16,	/* Observe report	*/
    PROMPT	=  1,	/* A Prompt (never)	*/
    PROVERB	= 31,	/* Go Proverb 		<=== last value */
	REFRESH	= 17,	/* Refresh of a board	*/
    SAVED	= 18,	/* Stored command	*/
    SAY		= 19,	/* Say string		*/
    SCORE	= 20,	/* Score report		*/
    SHOUT	= 21,	/* Shout string		*/
    SHOW 	= 29,	/* Shout string		*/
    STATUS	= 22,	/* Current Game status	*/
	STORED	= 23,	/* Stored games		*/
    TELL	= 24,	/* Tell string		*/
	THIST	= 25,	/* Thist report		*/
	TIM		= 26,	/* times command	*/
	TRANS	= 30,	/* Translation info	*/
	WHO		= 27,	/* who command		*/
	UNDO	= 28,	/* Undo report		*/
} MessageType;

#define LOGGEDON WAITING
typedef enum {
	LOGON		= 0,
	PASSWORD	= 1,
	PASSWD_NEW	= 2,
	PASSWD_CONFIRM	= 3, 
	REGISTER	= 4, 
	WAITING		= 5,
	PLAYING		= 6,
	SCORING		= 7,
	OBSERVING	= 8,
	TEACHING	= 9
} State;

typedef enum {
	Unkn_t = 0,
	Game_t,
	Help_t,
	Hand_t,
	Addr_t,
	Char_t,
	Decr_t,
	Defs_t,
	Incr_t,
	Best_t,
	Bloc_t,
	DOT_t,
	AcRe_t,
	Adjo_t,
	Addt_t,
	All_t,
	AMai_t,
	Bug_t,
	Comm_t,
	Conn_t,
	Cron_t,
	Decl_t,
	Dele_t,
	Done_t,
	DpyR_t,
	Dump_t,
	Exit_t,
	FdIs_t,
	Full_t,
	Info_t,
	Kibi_t,
	Kill_t,
	Komi_t,
	Last_t,
	Load_t,
	Lock_t,
	Look_t,
	Mail_t,
	Matc_t,
	Mess_t,
	Move_t,
	Obse_t,
	Pass_t,
	Play_t,
	Prov_t,
	PlMv_t,
	PSMa_t,
	Quit_t,
	Rank_t,
	Rati_t,
	Rnks_t,
	Refr_t,
	Reha_t,
	Remo_t,
	Rese_t,
	Resi_t,
	Save_t,
	Say_t,
	Sgf_t,
	Shou_t,
	Show_t,
	Shut_t,
	Spy_t,
	Stus_t,
	Stat_t,
	Stor_t,
	Supe_t,
	Teac_t,
	Tell_t,
	This_t,
	TIC_t,
	Time_t,
	Togg_t,
	Tran_t,
	Undo_t,
	UnOb_t,
	Upti_t,
	Viol_t,
	Watc_t,
	Shel_t,
	Who_t,
	Xsho_t,
	GmRe_t,
	AskM_t,
	InBy_t,
	CnSn_t,
	Ambi_t,
	NAgr_t
} CommandToken;

typedef struct {
	char 			*str;
	CommandToken 	tok;
	char 			NeedArg;
	char 			SuperCommand;
	unsigned char 	amb;
	char 			*enabled;
} SearchComm;

#define NUM_RANKS num_ranks
#define NUM_SPECIAL 2

/*
 * verticies
 */
#define TOP 0
#define MID 1
#define BOT 2


extern int verts[3][MAX_BRD_SZ+1];
extern int num_ranks;
extern char *ranks[], *comranks[];
extern char *prompts[];

#endif /* SHARED_H */

