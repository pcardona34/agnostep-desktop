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

/* $Id: igsparse.c,v 1.1 2003/01/12 04:01:52 gcasa Exp $ */

/*
 * $Log: igsparse.c,v $
 * Revision 1.1  2003/01/12 04:01:52  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.3  1997/07/06 19:35:01  ergo
 * actual version
 *
 * Revision 1.3  1997/05/04 18:57:06  ergo
 * added time control for moves
 *
 */

#include "igs.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>

#define prompts Prompts
#include "shared.h"

extern char *getloginname();
extern char *getpassword();
int loggedon;
int repeatpass, repeatlogin;
State state_t;
int verts[3][MAX_BRD_SZ+1], num_ranks;
char *ranks[50];

#ifdef STRSTR
char *strstr();
#endif

#ifdef STRTOL
long strtol();
#endif

char *Prompts[] =
{
  "Login: ",
  "Password: ",
  "Password: ",
  "Enter Your Password Again: ",
  "Enter your e-mail address (None): ",
  "#> ",
  "#> ",
  "Enter Dead Group: ",
  "#> ",
  "#> ",
};


void initparser()
{
  loggedon = 0;
  repeatpass = 0;
  repeatlogin = 0;
}


int DoState(char *s)
{
	if (strncmp(s, Prompts[LOGON], strlen(Prompts[LOGON])) == 0)
    	return LOGON;
	if (strncmp(s, "1 1", 3) == 0)
    	return PASSWORD;
	if (strncmp(s, "1 0", 3) == 0)
    	return LOGON;
	if (strncmp(s, Prompts[PASSWORD], strlen(Prompts[PASSWORD])) == 0)
    	return PASSWORD;
	if (strncmp(s, Prompts[PASSWD_NEW], strlen(Prompts[PASSWD_NEW])) == 0)
    	return PASSWD_NEW;
	if (strncmp(s, Prompts[PASSWD_CONFIRM], strlen(Prompts[PASSWD_CONFIRM])) == 0)
    	return PASSWD_CONFIRM;
	if (strncmp(s, Prompts[WAITING], strlen(Prompts[WAITING])) == 0)
    	return WAITING;
  	return -1;
}

static long appending = 0;

char retbuf[1000];
int idle;

int getmessage(message *mess, int uninitiated)
{
	char mesg[2000];
	int ret;
	char *textpart;

	idle = 0;
  	if (!uninitiated) {
    	pollserver();
	}
  	strcpy(mesg, retbuf);

	switch (DoState(mesg)) {
		case PASSWD_NEW:
		case PASSWD_CONFIRM:
		case PASSWORD:
    		sendstr(getpassword(repeatpass++));
    		sendstr("\n");
    		break;
		case WAITING:
    		sendstr("toggle client true\n");
    		mess->id = ONSERVER;
    		loggedon = 1;
    		sendstr("chars #O.?-++\n");
    		return 1;
		case LOGON:	{
      		int needlogin;
      		needlogin = 1;
      		do {
				if (needlogin == 1) {
	  				sendstr(getloginname(repeatlogin++));
	  				sendstr("\n");
	  				needlogin = -1;
				}
				ret = pollserver();
				strcpy(mesg, retbuf);
				if (ret < 0)
	  				return ret;
					if (!strncmp(mesg, "Password:", 9) 
						|| (!strncmp(mesg, "1 1", 3)))
	  					needlogin = 0;
					else if (!strncmp(mesg, "Sorry", 5)) {
	  						puts(mesg);
	  						return 0;
						 } 
						 else if (strlen(mesg)>2 && strncmp(mesg,"Login",5))
	  							  puts(mesg);
      		} while (needlogin);
      		sendstr(getpassword(repeatpass++));
      		sendstr("\n");
      		do {
				ret = pollserver();
				strcpy(mesg, retbuf);
				if (ret < 0)
	  				return ret;
				if (!strncmp(mesg, "Enter", 5)) {
	  				sendstr(getpassword(repeatpass++));
	  				sendstr("\n");
				}
				if (!strncmp(mesg, "9 File", 6))
	  				needlogin = -1;
				if (!strncmp(mesg, "To get", 6))
	  				needlogin = 1;
				if (!strncmp(mesg, "#>", 2)) {
	  				sendstr("toggle client true\n");
	  				mess->id = ONSERVER;
	  				loggedon = 1;
	  				sendstr("chars #O.?-++\n");
	  				return 1;
				}
				if (!strncmp(mesg, "Invalid", 7)) {
	  				puts(mesg);
	  				needlogin = 1;
				}
      		} while (!needlogin);
      
      		if (needlogin > 0)
				break;
		}			/* intentional fall through occurs here */
	  	default:
			mess->id = strtol(mesg, &textpart, 10);
			textpart++;
			if (mess->id == 2 && (strstr(textpart, "Game") 
									|| strstr(textpart, "min")))
      			mess->id = TIMEREP;
			if (appending == -1) {
				if (mess->id && !strncmp(textpart, "File", 4)) {
					appending = 0;
					if (!strncmp(mess->text, "                *=============", 29))
	  					mess->id = QUITMESG;
					return 1;
      			}
      			if (strlen(mess->text))
					strcat(mess->text, "\n");
      			{
						int len;
						char *pt;
						len = strlen(mesg);
						pt = mesg;
						while (len > 0) {
	  						strncat(mess->text, pt, 79);
	  						len -= 79;
	  						pt += 79;
	  						mess->lines++;
	  						if (len > 0)
	    						strcat(mess->text, "\n");
						}			
      			}
      			return 0;
    		}
    		if (mess->id == PROMPT) {
      			if (*textpart == '5' && !loggedon)
					loggedon = 1;
      			if (appending == LOOK_M) {
					mess->id = LOOK_M;
					appending = 0;
					return 1;
     		 	}
      			if (appending && !(appending == SCORE && mess->bscore == -10000)) {
					mess->id = appending;
					appending = 0;
					return 1;
      			}
      			mess->prompttype = atoi(textpart);
    		}
    		if (!strcmp(textpart, "File" /* , 4 */ )) {
      			appending = -1;
      			strcpy(mess->text, "");
      			mess->lines = 0;
      			return 0;
    		}
    		if (mess->id == BEEP) {
      			mess->beep = (*textpart == 7);
    		}
    		if (mess->id == KIBITZ) {
      			if (parsekibitz(textpart, mess))
				return 0;
    		}
    		if (mess->id == UNDO)
      			if (ret = parseundo(textpart, &(mess->gamenum))) {
					if (ret < 0)
	  					return ret;
					return 0;
      			}
    		if (mess->id == MOVE) {
      			if (parsemove(textpart, &(mess->x), 
					&(mess->y), &(mess->movenum),
		    		&(mess->gamenum), &(mess->color), 
					&(mess->bcap), &(mess->btime),
	    			&(mess->bbyo), &(mess->wcap), 
					&(mess->wtime), &(mess->wbyo))) {
					mess->id = 0;
				}
    		}
    		if (mess->id == WHO) {
      			appending = WHO;
      			parsewho(mess, textpart);
      			return 0;
    		}		
    		if (mess->id == GAMES) {
      			appending = GAMES;
      			parsegame(mess, textpart);
      			return 0;
   	 		}
    		if (mess->id == LOOK_M) {
      			appending = LOOK_M;
      			parsescore(mess, textpart);
      			return 0;
    		}
    		if (mess->id == SCORE) {
      			appending = SCORE;
      			parsescore(mess, textpart);
      			return 0;
    		}
    		strcpy(mess->text, textpart);
    		mess->lines = 1;
    		if (mess->id == INFO)
      			if (ret = parseinfo(textpart, mess))
					return ret;
    			return 1;
	}	
	return 0;
}

#ifdef STRTOL
long strtol(char *text, char **new, int dum) {
	long retu;
	retu = atol(text);
	for (*new = text; *new && **new <= '9' && **new >= '0'; (*new)++);
	return retu;
}
#endif



#ifdef STRSTR
char *strstr(char *s1, char *s2)
{
  register char *temp;
  int len;
  
  temp = s1;
  len = strlen(s2);
  while (temp = strchr(temp, *s2)) {
    if (!strncmp(temp, s2, len))
      return temp;
    else
      temp++;
  }
  return NULL;
}
#endif


void parsescore(message *mesg, char *s) {
	char *bd;
	int i;
  
	bd = strstr(s, ">>");
	if (bd)
		*(bd + 1) = '|';
  	bd = strstr(s, "<<");
  	if (bd)
    	*bd = '|';
  	if (strstr(s, "H-cap")) {
    	mesg->boardline = 0;
    	mesg->bscore = -10000;
  	} 
	else 
		if (bd = strchr(s, '|')) {
    		for (bd++, i = 0; *(bd - 1) != '|' || i == 0; bd += 2, i++) {
      			if (i >= mesg->boardsize)
					mesg->boardsize = i + 1;
      			if (i < 19 && mesg->boardline < 19)
					switch (*bd) {
						case '.':
	  						mesg->board[i][mesg->boardline] = EMPTY;
	  						break;
						case '#':
	  						mesg->board[i][mesg->boardline] = BLACK;
	  						break;
						case 'O':
	  						mesg->board[i][mesg->boardline] = WHITE;
	  						break;
						case '-':
	  						mesg->board[i][mesg->boardline] = WTERR;
	  						break;
						case '+':
	  						mesg->board[i][mesg->boardline] = BTERR;
	  						break;
						case '?':
	  						mesg->board[i][mesg->boardline] = DAME;
	  						break;
					}
    		}
    		mesg->boardline++;
  		} 
		else
    		sscanf(s, "%*[^ ] (W:O): %f to %*[^ ] (B:#): %f",
	   			&(mesg->wscore), &(mesg->bscore));
  		if (bd = strstr(s, "Captured by #"))
    		mesg->wcap = atoi(bd + strlen("Captured by #: "));
  		if (bd = strstr(s, "Captured by O"))
    		mesg->bcap = atoi(bd + strlen("Captured by O: "));
}


void parsewho(message *mesg, char *str) {
	if (!strncmp(str, "Info", 4)) {
    	strcpy(mesg->text, str);
    	mesg->lines = 1;
  	}
	else {
    	strcat(mesg->text, "\n");
    	strcat(mesg->text, str);
    	mesg->lines++;
  	}
}


void parsegame(message *mesg, char *str) {
	int fieldcount;
	char *br, *wr, blackrank[10], whiterank[10];
	int obcount;
  
	if (str[1] == '#') {
    	mesg->gamecount = 0;
    	strcpy(mesg->text, str);
    	mesg->lines = 1;
  	} else {
    	strcat(mesg->text, "\n");
    	strcat(mesg->text, str);
    	mesg->lines++;

    	/* hacked for systems that don't like %[^]] */
    	for (br = str; *br; br++)
      		if (*br == ']')
				*br = '!';
    	fieldcount = sscanf(str, "[%3d!%12s [%[^!]! vs.%12s [%[^!]! (%3d %d %d %f %d%*c%*c%*c) ( %d)\n",
			&(mesg->gamelist[mesg->gamecount].gnum),
			mesg->gamelist[mesg->gamecount].white,
			whiterank,
			mesg->gamelist[mesg->gamecount].black,
			blackrank,
			&(mesg->gamelist[mesg->gamecount].mnum),
			&(mesg->gamelist[mesg->gamecount].bsize),
			&(mesg->gamelist[mesg->gamecount].hcap),
			&(mesg->gamelist[mesg->gamecount].komi),
			&(mesg->byo),
			&obcount);
    
    	br = blackrank;
    	wr = whiterank;
    	br[5] = br[5] = 0;
    	while (*br == ' ')
      		br++;
    	while (*wr == ' ')
      		wr++;
    	while (br[strlen(br)-1] == ' ')
      		br[strlen(br)-1] = 0;
    	while (wr[strlen(wr)-1] == ' ')
      		wr[strlen(wr)-1] = 0;
    	strcpy(mesg->gamelist[mesg->gamecount].wrank, wr);
    	strcpy(mesg->gamelist[mesg->gamecount].brank, br);
    	if (fieldcount == 11)
      		(mesg->gamecount)++;
  	}	
}


int parseinfo(char *s, message *mess) {
	int ret, row;
	extern int MAXY;
	extern void igsbeep();
	char col;
	char text[100];

	if ((2 == sscanf(s, "Match[%dx%d]", &ret, &ret)) ||
		(2 == sscanf(s, "Match [%dx%d]", &ret, &ret))) {
		igsbeep();
		return 0;
	}
	if (1 == sscanf(s, "Match [%d]", &(mess->gamenum))) {
		mess->id = MATCH;
		return 0;
	}
	if (1 == sscanf(s, "Creating match [%d]", &(mess->gamenum))) {
		mess->id = MATCH;
		return 0;
	}
	if (2 == sscanf(s, "Removing @ %c%d", &col, &row)) {
    	if (col > 'I')
      		col--;
		mess->x = col - 'A';
    	mess->y = MAXY - row;
    	mess->id = REMOVE;
    	return 0;
  	}
  	if (!strncmp(s, "Board is restored", 17)) {
    	mess->id = SCOREUNDO;
    	return 0;
	}
  	if (strstr(s, "has restored your old game.")) {
    	mess->id = LOAD;
    	ret = pollserver();
    	strcpy(text, retbuf);
    	if (ret < 0)
      		return ret;
    	ret = pollserver();
    	strcpy(text, retbuf);
    	if (ret < 0)
      		return ret;
    	ret = sscanf(text, "%*d Game %d: %*[^(](%d %d %d) vs %*[^(](%d %d %d)",
		 	&(mess->gamenum), &(mess->bcap), &(mess->btime),
		 	&(mess->bbyo), &(mess->wcap), &(mess->wtime), &(mess->wbyo)
		 	);
    	ret = pollserver();
    	strcpy(text, retbuf);
    	if (ret < 0)
      		return ret;
    	return 0;
  	}
  	return 0;
}


static int gamenumber = -1;

/* Undo in game 0: zzz vs anthony:  D11 */
/* Game 0: testa (0 0 0) vs testb (0 0 0) with move line afterwords */

int parseundo(char *s, int *gamenum)
{
	char mes[2000];
	int count;
	int bogus2, ret;
	char bogus1;
	
	count = sscanf(s, "%*[^ ] undid the last move (%c%d).", &bogus1, &bogus2);
	if (count == 2) {
		ret = pollserver();
    	strcpy(mes, retbuf);
    	if (ret < 0)
      		return ret;
    	ret = pollserver();
    	strcpy(mes, retbuf);
    	if (ret < 0)
      		return ret;
    
    	sscanf(mes, "%*d Game %d", gamenum);
    	ret = pollserver();
    	strcpy(mes, retbuf);
    	if (ret < 0)
      		return ret;
    	return 0;
  	}
	count = sscanf(s, "Undo in game %d", gamenum);
	if (count != 1)
		return 1;			/* extra line */
	return 0;
}


/* new format:  ## game gamenum: plr (cap time byo) vs plr (cap time byo) */

int parsekibitz(char *s, message *mess) {
	if (1 == sscanf(s, "Kibitz %[^:]", mess->kibitzer))
		return 1;
	while (*s == ' ')
		s++;
	strcpy(mess->kibitz, s);
	return 0;
}


int parsemove(char *s, int *x, int *y, int *mv, int *gm, int *color, int *bcap,
	      int *btime, int *bbyo, int *wcap, int *wtime, int *wbyo)
{
	int mc;
	char c, col;
	extern int MAXY, handicap;
  
	mc = sscanf(s, "%3d(%c): %c%d", mv, &c, &col, y);
	if (mc == 3) {
		if (3 == sscanf(s, "%3d(%c): Handicap %d", mv, &c, &mc)) {
			handicap = mc;
			*x = *y = mc + 100;
			*gm = gamenumber;
			*color = c == 'W' ? WHITE : BLACK;
			(*mv)++;
			return 0;
		}
    	if (2 == sscanf(s, "%3d(%c): Pass", mv, &c)) {
			*x = *y = -1;
      		*gm = gamenumber;
      		*color = c == 'W' ? WHITE : BLACK;
      		(*mv)++;
      		return 0;
		}
	}
	if (mc != 4) {
		sscanf(s, "Game %d %*c: %*[^(](%d %d %d) vs %*[^(](%d %d %d)",
				&gamenumber, wcap, wtime, wbyo, bcap, btime, bbyo);
		return 1;
	}
	if (col > 'I')
    	col--;
	*x = col - 'A';
	*y = MAXY - *y;
	*color = c == 'W' ? WHITE : BLACK;
	*gm = gamenumber;
	(*mv)++;
	return 0;
}


int doneline(char *inbuf, int inptr) {
	return !loggedon &&
    	(inptr > 0 && inbuf[inptr - 1] == ' ') &&
      	((inptr > 1 && inbuf[inptr - 2] == ':') ||
       	(inptr > 2 && inbuf[inptr - 2] == '>' && inbuf[inptr - 3] == '#'));
}
