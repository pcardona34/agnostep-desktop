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

#ifndef _IGS_INFORMATION_
#define _IGS_INFORMATION_
#include "comment.header"

/* $Id: igs.h,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: igs.h,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:38:25  ergo
 * actual version
 *
 * Revision 1.3  1997/05/04 18:57:21  ergo
 * added time control for moves
 *
 */

/*  Uncomment the following to create a dump file used for debugging the
    socket communications.  */
/* #define DEBUG  */

#define MAXGAMES 100
#define piece unsigned char

extern int sock;

typedef struct {
   int id;

   int prompttype;		/* if return is prompt */

   int x, y, gamenum;		/* if return is play */
   int movenum;
   int color;
   int bcap, btime, bbyo;
   int wcap, wtime, wbyo;
   int byo;					/* time in byo-yomi in minutes */

   char text[10000];		/* text of message */
   int lines;			/* number of lines in text */

   int gamecount;		/* for data from the games command */
   struct {
      int gnum;
      char white[21], wrank[10], black[21], brank[10];
      int mnum, bsize, hcap;
      float komi;
   }  gamelist[MAXGAMES];

   int boardline;
   int boardsize;
   float wscore, bscore;
   piece board[19][19];

   int beep;

   char kibitzer[40];
   char kibitz[300];


}  message;



#define LOCAL 0
#define IGSGAME 1

#define ONSERVER -1
#define MATCH -2
#define QUITMESG -3
#define REMOVE -4
#define SCOREUNDO -5
#define TIMEREP -6

#define BLACK 2
#define WHITE 1
#define EMPTY 0
#define DAME 3
#define BTERR 5
#define WTERR 4

#define KEY -33

/*  Routines needed from GoApp.m  */

/*  Routines needed from Board.m  */
extern void displaygamenumber(int gamenum);

/*  Routines from igssocket.m  */
extern char servename[80];
extern int serveport;
extern void sethost(char *s);
extern void setport(int s);
extern int open_connection();
extern void sendstr(char *buf);
extern int eatchar;
extern int handlechar(char in);
extern void incomingserver();
extern int pollserver();

/*  Routines from igsparse.c  */
extern char *getloginname();
extern char *getpassword();
extern char retbuf[1000];
extern int idle;
extern int loggedon;
extern int repeatpass, repeatlogin;
extern char *Prompts[];
extern void initparser();
extern int DoState(char *s);
extern int getmessage(message *mess, int uninitiated);
extern void parsescore(message *mesg, char *s);
extern void parsewho(message *mesg, char *str);
extern void parsegame(message *mesg, char *str);
extern int parseinfo(char *s, message *mess);
extern int parseundo(char *s, int *gamenum);
extern int parsekibitz(char *s, message *mess);
extern int parsemove(char *s, int *x, int *y, int *mv, int *gm, int *color,
		     int *bcap, int *btime, int *bbyo, int *wcap, int *wtime,
		     int *wbyo);
extern int doneline(char *inbuf, int inptr);

/*  Routines from igsglue.m  */
extern int startgame(int n);
extern void getmoves(int n);
extern void getgames(message *mess);
extern void unobserve(void);
extern int observegame(int n);
/* extern int peekgame(int n); */
extern void setgame(int newgame);
extern void loadgame(char *name);
extern void doserver(void);

#endif
