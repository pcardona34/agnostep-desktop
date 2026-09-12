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
 
/* $Id: igsglue.m,v 1.2 2005/04/06 00:32:58 gcasa Exp $ */

/*
 * $Log: igsglue.m,v $
 * Revision 1.2  2005/04/06 00:32:58  gcasa
 * Cleaned up the code.
 *
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.4  1997/11/04 16:52:58  ergo
 * ported to OpenStep
 *
 * Revision 1.3  1997/07/06 19:37:59  ergo
 * actual version
 *
 * Revision 1.3  1997/05/04 18:56:56  ergo
 * added time control for moves
 *
 */

#include "igs.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "shared.h"

#import <AppKit/AppKit.h>
#import "GoApp.h"
#import "Board.h"

typedef piece boardtype[19][19];

message mesg;

char prefix[20];
int boardon = 0;
int boardmode = 0;
int beepcount = 1;

int ingame = -1;
extern int MAXX, MAXY;

char local[1000], *loc;

int observing = 0;

void showboard(boardtype b) {
	extern unsigned char p[19][19];
	int i, j;

	for (i = 0; i < 19; i++)
		for (j = 0; j < 19; j++)
			p[i][j] = b[i][j];

	[[(GoApp *)NSApp getGoView] refreshIO];
}

void igsbeep(void) {
    NSBeep();
}

int startgame(int n) {
	char str[100];
	int ret;
  
	sprintf(str, "games %d\n", n);
	sendstr(str);
	do {
		do {
      		ret = getmessage(&mesg, 0);
      		if (ret < 0)
				exit(1);
    	} while (!ret);
    	if (mesg.id == MOVE)
      	[(GoApp *)NSApp SetIGSStatus:"%Premature move.  Restart game.\n"];
  	} while (mesg.id != GAMES);
	if (mesg.gamecount != 1)
    	return -1;
  	if (mesg.gamelist[0].bsize > 19) {
    	[(GoApp *)NSApp SetIGSStatus:"%Boardsize too large\n"];
    	return -1;
  	}
  	if (observing) {
    	[(GoApp *)NSApp SetIGSStatus:"Removing observe\n"];
    	sprintf(str, "unobserve\n");
    	sendstr(str);
    	do {
      		do {
				ret = getmessage(&mesg, 0);
				if (ret < 0)
	  				exit(1);
      		} while (!ret);
    	} while (mesg.id != PROMPT);
    	observing = 0;
  	}
  	ingame = n;
  	MAXX = MAXY = mesg.gamelist[0].bsize;
  	[[(GoApp *)NSApp getGoView] startNewGame];
  	[[(GoApp *)NSApp getGoView] refreshIO];
  	[[(GoApp *)NSApp getGoView] display];
  	[[(GoApp *)NSApp getGoView] setGameNumber:ingame];
  	sprintf(str, "%s (%s)", mesg.gamelist[0].white, mesg.gamelist[0].wrank);
  	[[(GoApp *)NSApp getGoView] setWhiteName:str];
  	sprintf(str, "%s (%s)", mesg.gamelist[0].black, mesg.gamelist[0].brank);
  	[[(GoApp *)NSApp getGoView] setBlackName:str];
  	[[(GoApp *)NSApp getGoView] setIGSHandicap:mesg.gamelist[0].hcap];
  	sprintf(str, "%3.1f", mesg.gamelist[0].komi);
  	[[(GoApp *)NSApp getGoView] setIGSKomi:str];
	[[(GoApp *)NSApp getGoView] setByoTime:mesg.byo];
  	boardon = 1;
  	return 0;
}

void makemove(int x, int y, int movenum, int color, int btime, int bbyo,
	      int wtime, int wbyo) {
    extern void sethand(int);
	
    if ((x < MAXX) && (y < MAXY)) {
        [[(GoApp *)NSApp getGoView] makeMove: color: x: y];
        [[(GoApp *)NSApp getGoView] setTimeAndByo: btime: bbyo: wtime: wbyo];
        [[(GoApp *)NSApp getGoView] dispTime];
    }
    else if (x > 100) {
        sethand(x-100);
        [[(GoApp *)NSApp getGoView] setIGSHandicap:x-100];
        [[(GoApp *)NSApp getGoView] display];
    }
}

void makemovesilent(int x, int y, int movenum, int color, int btime, int bbyo,
	      int wtime, int wbyo) {
    extern void sethand(int);

    if ((x < MAXX) && (y < MAXY)) {
        [[(GoApp *)NSApp getGoView] makeMoveSilent: color: x: y];
    }
    else if (x > 100) {
      sethand(x-100);
    }
}

void removeGroup(int x, int y)	{
    extern unsigned char p[19][19], patternmat[19][19];
    extern int blackCaptured, whiteCaptured, currentStone;
    extern void find_pattern_in_board(int,int);
    int i, j;

    currentStone = p[x][y];

    find_pattern_in_board(x,y);
    for (i = 0; i < MAXX; i++)
        for (j = 0; j < MAXY; j++)
            if (patternmat[i][j]) {
                p[i][j] = EMPTY;
                if (currentStone==BLACK)
                    blackCaptured++;
                else
                    whiteCaptured++;
                }
    [[(GoApp *)NSApp getGoView] setblacksPrisoners:blackCaptured];
    [[(GoApp *)NSApp getGoView] setwhitesPrisoners:whiteCaptured];

    [[(GoApp *)NSApp getGoView] refreshIO];
}

void getmoves(int n) {
    int ret;
    char str[100];

    sprintf(str, "moves %d\n", n);
    sendstr(str);
    do {
        do {
            ret = getmessage(&mesg, 0);
            if (ret < 0)
                exit(1);
        } while (!ret);
        if (mesg.id == MOVE)
            makemovesilent(mesg.x, mesg.y, mesg.movenum, mesg.color, mesg.btime,
                           mesg.bbyo, mesg.wtime, mesg.wbyo);
        else if (mesg.id && mesg.id != PROMPT)
            [(GoApp *)NSApp SetIGSStatus:mesg.text];
    } while (mesg.id != PROMPT);	/* MOVE || mesg.id == 0); */
    lastMove--;
    makemove(mesg.x, mesg.y, mesg.movenum, mesg.color, mesg.btime,
	   mesg.bbyo, mesg.wtime, mesg.wbyo);
    [[(GoApp *)NSApp getGoView] refreshIO];
    [[(GoApp *)NSApp getGoView] display];
}

void getgames(message *mess) {
    int ret;

    sendstr("games\n");
    do {
        do {
            ret = getmessage(mess, 0);
            if (ret < 0)
                exit(1);
        } while (!ret);
        if (mess->id == MOVE)
            [(GoApp *)NSApp SetIGSStatus:"%Premature move.  Restart game.\n"];
    } while (mess->id != GAMES);
}

void unobserve(void) {
	char str[100];
	sprintf(str, "unobserve %d\n", ingame);
	sendstr(str);
	observing=0; ingame= -1; setgame(-1); 
}

int observegame(int n) {
	int ret;
	char str[20];
  
	if (!observing && ingame != -1) {
    	[(GoApp *)NSApp SetIGSStatus:"Can't observe while playing.\n"];
    	return 1;
  	}
  	if (startgame(n))
    	return 1;
  	getmoves(n);
  	sprintf(str, "observe %d\n", n);
  	sendstr(str);
  	observing = 1;
  	do {
    	do {
      		ret = getmessage(&mesg, 0);
      		if (ret < 0)
				exit(1);
    	} while (!ret);
    	if ((mesg.id == INFO) && !strncmp(mesg.text, "Removing", 8))
      		[(GoApp *)NSApp SetIGSStatus:"%fatal sync error.  Restart igs.\n"];
	} while (mesg.id != MOVE && mesg.id != UNDO);
  	return 0;
}

/* commented out because currently not used
 *
 * int peekgame(int n)
 * {
 * if (!observing && ingame != -1) {
 *   [NXApp SetIGSStatus:"Can't peek while playing.\n"];
 *   return 1;
 * }
 * if (startgame(n))
 *   return 1;
 * getmoves(n);
 * setgame(-1);
 * return 0;
 * }
 */
 
void setgame(int newgame) {
	if (newgame != ingame) {
		ingame = newgame;
	/*	[[NXApp getGoView] setGameNumber:ingame];	*/ 
	}
}

void loadgame(char *name) {
    char str[100];
    int ret;
    sprintf(str, "load %s\n", name);
    sendstr(str);
    do {
        ret = getmessage(&mesg, 0);
        if (ret < 0)
            exit(1);
        sprintf(str, "&&%d&&\n", mesg.id);
        [(GoApp *)NSApp SetIGSStatus:str];
    } while (mesg.id != MOVE && mesg.id != ERROR);
    if (mesg.id == ERROR)
        [(GoApp *)NSApp SetIGSStatus:mesg.text];
    else {
        if (!startgame(mesg.gamenum))
            getmoves(mesg.gamenum);
    }
}

void doserver(void) {
  	int ret;
//  	NSEvent  *get_ev;
  
  	loc = local;
  	idle = 0;
  	ret = getmessage(&mesg, 1);
  	if (ret < 0 && ret != KEY) {
    	[(GoApp *)NSApp SetIGSStatus:"Connection closed\n"];
  	}
  	if (ret > 0)
    	switch (mesg.id) {
    		case QUITMESG:
      			[(GoApp *)NSApp SetIGSStatus:mesg.text];
      			break;
    		case ONSERVER:
      			[(GoApp *)NSApp SetIGSStatus:"Connection established\n"];
      			break;
    		case BEEP:
    	  		break;
    		case MOVE:
      			if (!boardon)
				[(GoApp *)NSApp SetIGSStatus:"%Error: isolated move received\n"];
      			else {
				makemove(mesg.x, mesg.y, mesg.movenum, mesg.color, 
					 mesg.btime,
					 mesg.bbyo, mesg.wtime, mesg.wbyo);
				setgame(mesg.gamenum);
      			}
      			break;
    		case UNDO:
      			if (!boardon)
				[(GoApp *)NSApp SetIGSStatus:"%Error: isolated undo received"];
      			else {
				setgame(mesg.gamenum);
				[(GoView *)[(GoApp *)NSApp getGoView] undo];
				[(GoView *)[(GoApp *)NSApp getGoView] display];
      			}
      			break;
    		case SCOREUNDO:
      			/*	endgame();  */
      			[(GoApp *)NSApp SetIGSStatus:"Scoring undone."];
      			break;
    		case LOAD:
      			if (!startgame(mesg.gamenum))
					getmoves(mesg.gamenum);
      			break;
    		case MATCH:
      			startgame(mesg.gamenum);
      			break;
    		case REMOVE:
      			removeGroup(mesg.x, mesg.y);
      			break;
    		case SCORE:
      			{
                            char str[50];
                            showboard(mesg.board);
                            sprintf(str, "Black: %g\nWhite: %g\n", mesg.bscore,
                                    mesg.wscore);
                            [(GoApp *)NSApp SetIGSStatus:str];
      			}
      			break;
    		case LOOK_M: {
      			int pris[2];
      			if (mesg.boardsize > 19)
					[(GoApp *)NSApp SetIGSStatus:"%Boardsize of saved game too big.\n"];
      			else {
					MAXX = MAXY = mesg.boardsize;
					[[(GoApp *)NSApp getGoView] startNewGame];
					[[(GoApp *)NSApp getGoView] display];
					boardon = 1;
					pris[0] = mesg.bcap;
					pris[1] = mesg.wcap;
					[[(GoApp *)NSApp getGoView] setblacksPrisoners:pris[0]];
					[[(GoApp *)NSApp getGoView] setwhitesPrisoners:pris[1]];
					[[(GoApp *)NSApp getGoView] refreshIO];
					showboard(mesg.board);
      			}
    			}
      			break;
                case KIBITZ:{
                        char s[300];
      			sprintf(s, "%s: %s\n", mesg.kibitzer, mesg.kibitz);
      			[(GoApp *)NSApp SetIGSStatus:s];
                        }
      			break;
    		case STORED:
      			if (!strlen(mesg.text))
					[(GoApp *)NSApp SetIGSStatus:"No stored games\n"];
      			else
					[(GoApp *)NSApp SetIGSStatus:mesg.text];
      			break;
    		case INFO:
      			if (strstr(mesg.text, "Removing")) {
					observing = 0;
					setgame(-1);
				}
      			if (strstr(mesg.text, "game completed")) {
					[(GoApp *)NSApp gameCompleted];
				}
				[(GoApp *)NSApp SetIGSStatus:mesg.text];
      			break;
    		case PROMPT:
      			if (ingame != -1 && mesg.prompttype == 5) {
					setgame(-1);
					observing = 0;
					[(GoApp *)NSApp gameCompleted];
      			}
			case 0:
      			break;
    		default:
      			[(GoApp *)NSApp SetIGSStatus:mesg.text];
      			break;
   		}
  	idle = 1;
/*
        if( [(GoApp *)NSApp nextEventMatchingMask:NSLeftMouseDownMask untilDate:[NSDate distantFuture]inMode:NSEventTrackingRunLoopMode dequeue:NO] ) {
            get_ev = [(GoApp *)NSApp nextEventMatchingMask:NSLeftMouseDownMask untilDate:[NSDate distantFuture]inMode:NSEventTrackingRunLoopMode dequeue:YES];
            [(GoApp *)NSApp sendEvent:get_ev];
        }
*/
}


