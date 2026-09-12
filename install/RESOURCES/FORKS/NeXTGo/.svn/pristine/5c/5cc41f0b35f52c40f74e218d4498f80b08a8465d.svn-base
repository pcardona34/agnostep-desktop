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

/* $Id: Board.h,v 1.1 2003/01/12 04:01:50 gcasa Exp $ */

/*
 * $Log: Board.h,v $
 * Revision 1.1  2003/01/12 04:01:50  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.4  1997/11/04 16:49:19  ergo
 * ported to OpenStep
 *
 * Revision 1.3  1997/07/06 19:38:19  ergo
 * actual version
 *
 * Revision 1.3  1997/05/04 18:57:16  ergo
 * added time control for moves
 *
 */

#import <AppKit/NSView.h>
#ifndef GNUSTEP
#import <SoundKit/Sound.h>
#import <AppKit/dpsOpenStep.h>
#import <AppKit/NSDPSContext.h>
#else
#import <AppKit/NSGraphicsContext.h>
#import <AppKit/PSOperators.h>
#import <Foundation/NSTimer.h>
#endif
#include "history.h"

// Maximum number of tiles in the playing area...
  
#define WHITESTONE	1     
#define BLACKSTONE	2
  
extern unsigned char p[19][19];
extern unsigned char patternmat[19][19], scoringmat[19][19], ownermat[19][19];
extern unsigned char tempmat[19][19], newpatternmat[19][19], mark[19][19];
extern char special_characters[19][19];
extern int hist[19][19], currentMoveNumber;
extern int rd, bothSides, neitherSide, MAXX, MAXY;
extern int opn[9], blackCaptured, whiteCaptured, handicap;
extern int currentStone, opposingStone, blackPassed, whitePassed;
extern int blackTerritory, whiteTerritory, manScoreTemp, SmartGoGameFlag;
extern BOOL AGAScoring, manualScoring, typeOfScoring, gameType;
extern float black_Score, white_Score;
extern gameHistory gameMoves[500];
extern int lastMove;
extern BOOL finished, blackSide, whiteSide;
extern BOOL scoringGame, resultsDisplayed;
typedef struct {
	id timeToHandle;	// display of black or white time
	int time;
	int byo;
	} TimeStruct;  
	


@interface GoView:NSView 
{
  
  BOOL gameRunning, gameScored;
    NSImage 	*backGround; 

	id 	blackStone, 
  		whiteStone, 
		grayStone, 
		gameMessage, 
		blacksPrisoners, 
		whitesPrisoners, 
		gameMessage2, 
		startButton, 
		stopButton, 
		passButton, 
		mainMenu, 
		upperLeft, 
		upperRight, 
		lowerLeft, 
		lowerRight, 
		midLeft, 
		midRight, 
		midTop, 
		midBottom, 
		innerSquare, 
		innerHandicap;
	id 	BlackTerrValue, 
		BlackTerrString, 
		BlackPrisonValue, 
		BlackPrisonString, 
		BlackTotalValue, 
		WhiteTerrValue, 
		WhiteTerrString, 
		WhitePrisonValue, 
		WhitePrisonString, 
		WhiteTotalValue, 
		GameResult, 
		KomiValue, 
		TypeOfScoring, 
		ScoringWindow;
	id	showHistFlag, 
		historyFont, 
		blackTerrFont, 
		whiteTerrFont, 
		stoneClick, 
		showCoords, 
		playSounds, 
		blackTime, 
		whiteTime, 
		IGSGameNumber, 
		IGSBlackPlayer, 
		IGSWhitePlayer, 
		IGShandicap, 
		IGSkomi;
	id	ControlPanel;
		
	int bTime, bByo, wTime, wByo;
	long startZeit;
	TimeStruct	ts;
	int ByoTime;		/* time in byo-yomi in minutes 	*/
	long time;			/* time we received a move */
	NSTimer *te;
  
}

/* The following methods can be called by Interface Builder objects &
   during creation/destruction of instances of BreakView.  */
  
- initWithFrame:(NSRect)frm;
- (void)dealloc;

- resetButtons;
- startNewGame;
- go:sender;
- (void)stop:(id)sender;
- passMove;
- showLastMove:sender;
- undo;
- undoLastMove:sender;
- toggleShowHistFlag:sender;
- toggleSound:sender;
- doClick;
- toggleCoords:sender;

- changeBackground:sender;
- revertBackground:sender;

- setMess1:(char *)s;
- setMess2:(char *)s;

/* The following methods are internal and probably should not be called
   by others.  */
  
- setBackgroundFile:(const char *)fileName andRemember:(BOOL)remember;
- (void)drawRect:(NSRect)rects;
- drawBackground:(NSRect *)rect;
- showBlackStone;
- showWhiteStone;
- showGrayStone;
- showBackgroundPiece: (int)x: (int)y;
- eraseStone;
- addMoveToGameMoves: (int)color: (int)x: (int)y;
- makeMove: (int)color: (int)x: (int)y;
- makeMoveSilent: (int)color: (int)x: (int)y;
- setGameNumber: (int)n;
- setTimeAndByo: (int)btime: (int)bbyo: (int)wtime: (int)wbyo;
- dispTime;
- setWhiteName: (char *)wname;
- setBlackName: (char *)bname;
- setIGSHandicap: (int)h;
- setIGSKomi: (char *)k;
- setByoTime: (int)aByoTime;
- (int)ByoTime;
- updateInfo;
- refreshIO;
- displayScoringInfo;
- scoreGame;
- step;
- selectMove;
- selectMoveEnd;
- flashStone: (int)x :(int)y;
- setblacksPrisoners:(int)bp;
- setwhitesPrisoners:(int)wp;
- (long)startZeit;
- setStartZeit:(long)aTime;
- (int)bByo;
- (TimeStruct*)ts;
- gameCompleted;
- removeTE;

- (void) TEHandler:(NSTimer *)aTimer;
@end
