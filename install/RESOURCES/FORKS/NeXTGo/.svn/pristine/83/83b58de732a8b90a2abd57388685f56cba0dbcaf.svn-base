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
 
/* $Id: Board.m,v 1.5 2008/11/21 06:15:51 gcasa Exp $ */

/*
 * $Log: Board.m,v $
 * Revision 1.5  2008/11/21 06:15:51  gcasa
 * removed definition of PSWait
 *
 * Revision 1.4  2005/04/06 00:32:58  gcasa
 * Cleaned up the code.
 *
 * Revision 1.3  2005/04/03 19:07:17  gcasa
 * removing debugging.
 *
 * Revision 1.2  2004/02/22 16:02:13  gcasa
 * A lot of improvements to the GAP project
 *
 * Revision 1.1  2003/01/12 04:01:51  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.4  1997/11/04 16:49:20  ergo
 * ported to OpenStep
 *
 * Revision 1.3  1997/07/06 19:37:55  ergo
 * actual version
 *
 * Revision 1.5  1997/06/03 23:01:55  ergo
 * *** empty log message ***
 *
 * Revision 1.4  1997/05/30 18:44:13  ergo
 * Added an Inspector
 *
 * Revision 1.3  1997/05/04 18:56:50  ergo
 * added time control for moves
 *
 */

#import "Board.h"
#import "gnugo.h"
#include "igs.h"

#import <math.h>
#import <sys/time.h>
#ifndef GNUSTEP
#import <libc.h>
#import <AppKit/psopsOpenStep.h>	// PSxxx functions
#import <SoundKit/Sound.h>
#else
#import <AppKit/PSOperators.h>
#import <AppKit/AppKit.h>
#endif

#define EMPTY		0
#define WHITESTONE	1
#define BLACKSTONE	2
#define NEUTRAL_TERR	3
#define WHITE_TERR	4
#define BLACK_TERR	5
#define SPECIAL_CHAR    6
#define KOMI            5.5

// Do this define so to avoid about 15 later on ;)
#ifdef GNUSTEP
#define NSDPSContext NSGraphicsContext
#endif

// The following values are the default sizes for the various pieces. 
  
#define RADIUS		14.5 			// Stone radius
#define STONEWIDTH	29.0			// Stone width
#define STONEHEIGHT	29.0			// Stone height
  
  // SHADOWOFFSET defines the amount the shadow is offset from the piece. 
  
#define SHADOWOFFSET 2.0
  
#define BASEBOARDX 19.0
#define BASEBOARDY 19.0
#define WINDOWOFFSETX 12.0
#define WINDOWOFFSETY 12.0
  
#define PSLine(a, b, x, y)	PSmoveto(a, b); PSlineto(x, y)

float stoneX, stoneY;
int blackStones, whiteStones;
char currentCharacter;
unsigned char oldBoard[19][19];

void setStoneLoc(int x, int y)
{
  stoneX = ((19.0 - MAXX)/2.0)*STONEWIDTH + BASEBOARDX - RADIUS + (x*STONEWIDTH);
  stoneY = BASEBOARDY - RADIUS + ((18 - y)*STONEHEIGHT) - ((19.0 - MAXY)/2.0)*STONEHEIGHT;
}  

@implementation GoView
  
- initWithFrame:(NSRect)frm
{
  NSSize stoneSize;
  
  stoneSize.width = STONEWIDTH;
  stoneSize.height = STONEHEIGHT;
  
  te = 0;
  startZeit = 0;
  
  [super initWithFrame:frm];
  
  [self allocateGState];	// For faster lock/unlockFocus
    
  [(blackStone = [[NSImage allocWithZone:[self zone]] init]) setScalesWhenResized:NO];
  [blackStone addRepresentation:[[[NSCustomImageRep alloc] initWithDrawSelector:@selector(drawBlackStone:) delegate:self] autorelease]];
  [blackStone setSize:stoneSize];
  
  [(whiteStone = [[NSImage allocWithZone:[self zone]] init]) setScalesWhenResized:NO];
  [whiteStone addRepresentation:[[[NSCustomImageRep alloc] initWithDrawSelector:@selector(drawWhiteStone:) delegate:self] autorelease]];
  [whiteStone setSize:stoneSize];
  
  [(grayStone = [[NSImage allocWithZone:[self zone]] init]) setScalesWhenResized:NO];
  [grayStone addRepresentation:[[[NSCustomImageRep alloc] initWithDrawSelector:@selector(drawGrayStone:) delegate:self] autorelease]];
  [grayStone setSize:stoneSize];
  
  [(upperLeft = [[NSImage allocWithZone:[self zone]] init]) setScalesWhenResized:NO];
  [upperLeft addRepresentation:[[[NSCustomImageRep alloc] initWithDrawSelector:@selector(drawUpperLeft:) delegate:self] autorelease]];
  [upperLeft setSize:stoneSize];
  
  [(upperRight = [[NSImage allocWithZone:[self zone]] init]) setScalesWhenResized:NO];
  [upperRight addRepresentation:[[[NSCustomImageRep alloc] initWithDrawSelector:@selector(drawUpperRight:) delegate:self] autorelease]];
  [upperRight setSize:stoneSize];
  
  [(lowerLeft = [[NSImage allocWithZone:[self zone]] init]) setScalesWhenResized:NO];
  [lowerLeft addRepresentation:[[[NSCustomImageRep alloc] initWithDrawSelector:@selector(drawLowerLeft:) delegate:self] autorelease]];
  [lowerLeft setSize:stoneSize];
  
  [(lowerRight = [[NSImage allocWithZone:[self zone]] init]) setScalesWhenResized:NO];
  [lowerRight addRepresentation:[[[NSCustomImageRep alloc] initWithDrawSelector:@selector(drawLowerRight:) delegate:self] autorelease]];
  [lowerRight setSize:stoneSize];
  
  [(midLeft = [[NSImage allocWithZone:[self zone]] init]) setScalesWhenResized:NO];
  [midLeft addRepresentation:[[[NSCustomImageRep alloc] initWithDrawSelector:@selector(drawMidLeft:) delegate:self] autorelease]];
  [midLeft setSize:stoneSize];
  
  [(midRight = [[NSImage allocWithZone:[self zone]] init]) setScalesWhenResized:NO];
  [midRight addRepresentation:[[[NSCustomImageRep alloc] initWithDrawSelector:@selector(drawMidRight:) delegate:self] autorelease]];
  [midRight setSize:stoneSize];
  
  [(midTop = [[NSImage allocWithZone:[self zone]] init]) setScalesWhenResized:NO];
  [midTop addRepresentation:[[[NSCustomImageRep alloc] initWithDrawSelector:@selector(drawMidTop:) delegate:self] autorelease]];
  [midTop setSize:stoneSize];
  
  [(midBottom = [[NSImage allocWithZone:[self zone]] init]) setScalesWhenResized:NO];
  [midBottom addRepresentation:[[[NSCustomImageRep alloc] initWithDrawSelector:@selector(drawMidBottom:) delegate:self] autorelease]];
  [midBottom setSize:stoneSize];
  
  [(innerSquare = [[NSImage allocWithZone:[self zone]] init]) setScalesWhenResized:NO];
  [innerSquare addRepresentation:[[[NSCustomImageRep alloc] initWithDrawSelector:@selector(drawInnerSquare:) delegate:self] autorelease]];
  [innerSquare setSize:stoneSize];
  
  [(innerHandicap = [[NSImage allocWithZone:[self zone]] init]) setScalesWhenResized:NO];
  [innerHandicap addRepresentation:[[[NSCustomImageRep alloc] initWithDrawSelector:@selector(drawInnerHandicap:) delegate:self] autorelease]];
  [innerHandicap setSize:stoneSize];
  
  [self setBackgroundFile:[[[NSUserDefaults standardUserDefaults] objectForKey:@"BackGround"] cString] 
 andRemember:NO];
  
  [self startNewGame];

  historyFont = [ [NSFont fontWithName:@"Helvetica" size:9.0] retain];
  blackTerrFont = [ [NSFont fontWithName:@"Helvetica" size:25.0] retain];
  whiteTerrFont = [ [NSFont fontWithName:@"Helvetica" size:22.5] retain];
#ifndef GNUSTEP
  stoneClick = [Sound findSoundFor:@"Pop"];
#endif
  {
      struct timeval tp;
      struct timezone tzp;
      gettimeofday(&tp, &tzp);
      time = tp.tv_sec;
  }
  return self;
}

// free simply gets rid of everything we created for MainGoView, including
  // the instance of MainGoView itself. This is how nice objects clean up.
  
- (void)dealloc {
	[backGround release];
	{ [super dealloc]; return; };
}



// This methods allows changing the file used to paint the background of the
  // playing field. Set fileName to NULL to revert to the default. Set
  // remember to YES if you wish the write the value out in the defaults.
  
- setBackgroundFile:(const char *)fileName andRemember:(BOOL)remember {
    [backGround release];
    if (fileName) {
        backGround = [NSImage alloc];
        [backGround initWithContentsOfFile:[NSString stringWithCString:fileName]];
        [backGround setSize:[self bounds].size];
    	if (remember) 
      		[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithCString:fileName] forKey:@"Background"];
    } else {
        backGround = [ [NSImage imageNamed:@"Background.tiff"] retain];
        [backGround setSize:[self bounds].size];
    	if (remember)
      		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Background"];
    }
    [backGround setBackgroundColor:[NSColor whiteColor]];
    [backGround setScalesWhenResized:NO];
    [self display];

    return self;   
}

// The following two methods allow changing the background image from
// menu items or buttons.
  
- changeBackground:sender {
	
    NSString *fileType1 = @"tiff",
             *fileType2 = @"eps";

    id fileTypes = [NSArray arrayWithObjects:fileType1, fileType2, nil];

	if ([[NSOpenPanel new] runModalForTypes:fileTypes]) {
		[self setBackgroundFile:[[[NSOpenPanel new] filename] cString] andRemember:YES];
		[self display];
	}
  
	return self;
}

- revertBackground:sender
{
  [self setBackgroundFile:NULL andRemember:YES];
  [self display];
  return self;
}

- resetButtons
{
  if (SmartGoGameFlag)
    {
      [startButton setEnabled:NO];
      [stopButton setEnabled:NO];
      [passButton setEnabled:NO];

      return self;
    }
    
 if (bothSides)
    [passButton setEnabled:NO];
  else
    [passButton setEnabled:YES];
 
  if (neitherSide)
    {
      [startButton setEnabled:NO];
      [stopButton setEnabled:NO];
    }
  else
    {
      [startButton setEnabled:YES];
      [stopButton setEnabled:YES];
    }

  return self;
}

// The following method will initialize all the variables for a new game.
  
- startNewGame {
	
	int i, j;
  
	gameRunning = NO;
	finished = NO;
	gameScored = NO;
	resultsDisplayed = NO;
	scoringGame = NO;
	lastMove = 0;
  	blackCaptured = whiteCaptured = 0;
	manualScoring = manScoreTemp;
  
	seed(&rd);
  
	for (i = 0; i < MAXX; i++)
    	for (j = 0; j < MAXY; j++)
      		oldBoard[i][j] = p[i][j] = hist[i][j] = 0;
  
  	for (i = 0; i < 9; i++)
    	opn[i] = 1;
  	opn[4] = 0;


  	if (gameType == LOCAL) {
            sethand(handicap);
            currentStone = (handicap == 0)?BLACKSTONE:WHITESTONE;
            opposingStone = (currentStone == BLACKSTONE)?WHITESTONE:BLACKSTONE;

            if (currentStone == BLACKSTONE)
                [gameMessage setStringValue:@"Black's Turn"];
            else
                [gameMessage setStringValue:@"White's Turn"];

            [self resetButtons];

            if (((currentStone == BLACKSTONE) && blackSide) ||
	  		((currentStone == WHITESTONE) && whiteSide))
                [gameMessage2 setStringValue:@"Press START to begin..."];
            else
                [gameMessage2 setStringValue:@"You move first..."];
        }
  	else {
            [gameMessage2 setStringValue:@"Internet Go Server"];
            [gameMessage setStringValue:@""];
            [self setblacksPrisoners:0];
            [self setwhitesPrisoners:0];
            [passButton setEnabled:YES];
            [startButton setEnabled:NO];
            [stopButton setEnabled:NO];
            [self removeTE];
            {
                struct timeval tp;
    		struct timezone tzp;
    		gettimeofday(&tp, &tzp);
                time = tp.tv_sec;
            }	
	}
    
  	[ScoringWindow close];
  	PSWait();

  	return self;
}

// The stop method will pause a running game. The go method will start it up
  // again.
  
- go:sender
{
  if (gameType == IGSGAME)
    return self;
    
  if ((scoringGame) && (manualScoring))
    {
      int i, j;

      find_owner();
      blackTerritory = 0;
      whiteTerritory = 0;

      for (i = 0; i < MAXX; i++)
	for (j = 0; j < MAXY; j++)
	  {
	    if (ownermat[i][j] == BLACKSTONE)
	      {
		blackTerritory++;
		p[i][j] = BLACK_TERR;
	      }
	    if (ownermat[i][j] == WHITESTONE)
	      {
		whiteTerritory++;
		p[i][j] = WHITE_TERR;
	      }
	    if (ownermat[i][j] == NEUTRAL_TERR)
	      {
		p[i][j] = NEUTRAL_TERR;
	      }
	  }

      gameScored = YES;
      [self displayScoringInfo];
      PSWait();
    }

  if ((gameRunning == 0) && (finished == 0)) {
    gameRunning = YES;
    [self step];
  }
  return 0;
}

- (void)stop:(id)sender {
	if (gameType == IGSGAME)
		return;
      
	if (gameRunning) 
		gameRunning = NO;
}

- showLastMove:sender
{
  int i;

  if (SmartGoGameFlag)
    return self;

  if (finished)
    {
      NSRunAlertPanel(@"NeXTGo", @"The game has concluded.  The last move was\n the scoring.", @"OK", nil, nil);
      return self;
    }

  if (lastMove == 0)
    {
      NSRunAlertPanel(@"NeXTGo", @"The game has not yet started.", @"OK", nil, nil);
      return self;
    }

  for (i = 0; i < gameMoves[lastMove-1].numchanges; i++)
    {
      if (gameMoves[lastMove-1].changes[i].x < 0)
	{
	  NSRunAlertPanel(@"NeXTGo", @"The last move was a pass.", @"OK", nil, nil);
	  return self;
	}
    }
    
  [self lockFocus];
  for (i = 0; i < gameMoves[lastMove-1].numchanges; i++)
    {
      if (gameMoves[lastMove-1].changes[i].added)
	{
	  setStoneLoc(gameMoves[lastMove-1].changes[i].x,
		      gameMoves[lastMove-1].changes[i].y);
	  [self showGrayStone];
	}
    }
  [self unlockFocus];
  PSWait();
  
  [self lockFocus];
  [[self window] flushWindow];
  [self drawRect:[self bounds]];
  [self display];
  [self unlockFocus];
  PSWait();
  
  return self;
}

- undo
{
  int i, j, x, y;

  if (finished)
    return self;
  
  if (lastMove == 1)
    {
      [self startNewGame];
      [self display];

      return self;
    }
    
  if (lastMove > 0)
    {
      lastMove--;

      for (i = 0; i < MAXX; i++)
	for (j = 0; j < MAXY; j++)
	  p[i][j] = oldBoard[i][j];
      blackCaptured = gameMoves[lastMove].blackCaptured;
      whiteCaptured = gameMoves[lastMove].whiteCaptured;

      for (i = 0; i < gameMoves[lastMove-1].numchanges; i++)
	{
	  x = gameMoves[lastMove-1].changes[i].x;
	  y = gameMoves[lastMove-1].changes[i].y;
	  if (gameMoves[lastMove-1].changes[i].added)
	    {
	      oldBoard[x][y] = EMPTY;
	    }
	  else
	    {
	      oldBoard[x][y] = gameMoves[lastMove-1].changes[i].color;
	    }
	}
      [self refreshIO];

      currentStone = opposingStone;
      opposingStone = (currentStone == BLACKSTONE)?WHITESTONE:BLACKSTONE;

      if (gameType == LOCAL)
	{
	  [gameMessage setStringValue:(currentStone == BLACKSTONE) ? @"Black's Turn" : @"White's Turn"];
	  
	  if ((bothSides) || (((currentStone == BLACKSTONE) && (blackSide)) ||
			      ((currentStone == WHITESTONE) && (whiteSide))))
	    {
	      [gameMessage2 setStringValue:@"Press START to continue..."];
	      gameRunning = 0;
	    }
	  else
	    [gameMessage2 setStringValue:@"Your move..."];
	}
    }

  return self;
}

- undoLastMove:sender {
    if (SmartGoGameFlag)
        return self;

    if (gameType == LOCAL) {
        [self undo];
    }
    else {
        sendstr("undo\n");
    }

    return self;
}

- toggleShowHistFlag:sender {
    [self lockFocus];
    [self display];
    [self unlockFocus];

    return self;
}

- toggleSound:sender {

  return self;
}

- doClick {
#ifndef GNUSTEP
    if ([playSounds intValue])
        [stoneClick play];
#endif
    PSWait();

    return self;
}

- toggleCoords:sender {
    [self lockFocus];
    [self display];
    [self unlockFocus];

    return self;
}

- (void)mouseDown:(NSEvent *)event 
{
  	NSPoint pickedP;

	if (gameType == LOCAL) {
      	if ((((currentStone == BLACKSTONE) && blackSide) ||
	   		((currentStone == WHITESTONE) && whiteSide)) &&
	  		(!scoringGame) && (!manualScoring))
			return;

      	if (SmartGoGameFlag)
			return;
    
      	if ((!gameRunning) && (!finished))
			gameRunning = YES;
  
      	if (!finished) {
			int i, j, x, y;

			pickedP = [event locationInWindow];
    
			x = floor((pickedP.x - ((19.0 - MAXX)/2.0)*STONEWIDTH - BASEBOARDX 	
								  - WINDOWOFFSETX + RADIUS)/STONEWIDTH);
			y = 18 - floor((pickedP.y - BASEBOARDY - WINDOWOFFSETY + RADIUS +
			((19.0 - MAXY)/2.0)*STONEHEIGHT)/STONEHEIGHT);
    
			if (x < 0) x = 0;
			if (x > MAXX - 1) x = MAXX - 1;
			if (y < 0) y = 0;
			if (y > MAXY - 1) y = MAXY - 1;
    
			if ((p[x][y] == 0) && (!suicide(x,y))) {
	  			for (i = 0; i < MAXX; i++)
	    			for (j = 0; j < MAXY; j++)
	      				oldBoard[i][j] = p[i][j];

				p[x][y] = currentStone;
	  			if (currentStone == BLACKSTONE)
	    			blackPassed = 0;
	  			else
	    			whitePassed = 0;

	  			setStoneLoc(x,y);
      
	  			[self lockFocus];
	  			switch (p[x][y]) {
	    			case WHITESTONE: 
						[self showWhiteStone];
	      				break;
	    			case BLACKSTONE: 
						[self showBlackStone];
	     			 	break;
	    			default: 
						break;
	    		}
	  			[self unlockFocus];

// commented out because of double clicks	  			[self doClick];

		  		[self updateInfo];

		  		[self addMoveToGameMoves: currentStone: x: y];

		  		if ([showHistFlag intValue]) {
		      		NSRect tmpRect = {{floor(stoneX), floor(stoneY)},
							{floor(STONEWIDTH), floor(STONEHEIGHT)}};

	      			[self lockFocus];
	      			[self drawRect:tmpRect];
	      			[self unlockFocus];
	    		}

	  			if (!neitherSide)
	    			[self step];
                                [self setNeedsDisplay:YES];
			} 
		} 
		else {
			if ((scoringGame) && (manualScoring) && (!gameScored)) {
	    	int x, y;

	    	pickedP = [event locationInWindow];
    
	    	x = floor((pickedP.x - ((19.0 - MAXX)/2.0)*STONEWIDTH - BASEBOARDX
		       - WINDOWOFFSETX + RADIUS)/STONEWIDTH);
	    	y = 18 - floor((pickedP.y - BASEBOARDY - WINDOWOFFSETY + RADIUS +
			    ((19.0 - MAXY)/2.0)*STONEHEIGHT)/STONEHEIGHT);
    
	    	if (x < 0) x = 0;
	    	if (x > MAXX - 1) x = MAXX - 1;
	    	if (y < 0) y = 0;
	    	if (y > MAXY - 1) y = MAXY - 1;

	    	if (p[x][y] != EMPTY) {
                    int k, l;

                    currentStone = p[x][y];

                    find_pattern_in_board(x, y);
                    for (k = 0; k < MAXX; k++)
                        for (l = 0; l < MAXY; l++)
                            if (patternmat[k][l]) {
                                p[k][l] = EMPTY;
                                if (currentStone == BLACKSTONE)
                                    blackCaptured++;
                                else
                                    whiteCaptured++;
                            }
		
                    [self setblacksPrisoners:blackCaptured];
                    [self setwhitesPrisoners:whiteCaptured];

                    [self setNeedsDisplay:YES];
                }
            }
  	}
    }
    else {
        int x, y;
      	char s[50], n[50];
      	extern int observing, ingame;

      	if (observing || (ingame == -1)) {
            NSRunAlertPanel(@"IGS Error", @"You cannot make a move unless you are playing.", @"OK", nil, nil);		  		return;
	}

      	pickedP = [event locationInWindow];
    
      	x = floor((pickedP.x - ((19.0 - MAXX)/2.0)*STONEWIDTH - BASEBOARDX -
		 	WINDOWOFFSETX + RADIUS)/STONEWIDTH);
      	y = 18 - floor((pickedP.y - BASEBOARDY - WINDOWOFFSETY + RADIUS +
		      ((19.0 - MAXY)/2.0)*STONEHEIGHT)/STONEHEIGHT);

      	if (x < 0) x = 0;
      	if (x > MAXX - 1)
            x = MAXX - 1;
      	if (y < 0) y = 0;
      	if (y > MAXY - 1)
            y = MAXY - 1;

      	s[0] = x + 'a';
      	if (x > 7)
            s[0] = x + 'b';
      	s[1] = 0;
      	sprintf(n, "%d", MAXY-y);
      	strcat(s, n);
	{
            struct timeval tp;
            struct timezone tzp;
            gettimeofday(&tp, &tzp);
            time = tp.tv_sec - time;
        }

        sprintf(n, " %d", ingame); 	
      	strcat(s, n);

        sprintf(n, " %ld", time); 	
      	strcat(s, n);
      	strcat(s, "\n");
      	sendstr(s);
    }
}


- passMove {
    if (gameType == LOCAL) {
        if (((currentStone == BLACKSTONE) && blackSide) ||
            ((currentStone == WHITESTONE) && whiteSide)) {
            return self;
        }
        if (currentStone == BLACKSTONE) {
            blackPassed = 1;
            if (AGAScoring) blackCaptured++;
        }
      	else {
            whitePassed = 1;
            if (AGAScoring) whiteCaptured++;
        }

      	[self updateInfo];

      	[self addMoveToGameMoves: currentStone: -1: -1];
    
      	if ((!neitherSide) && (!finished))
            [self step];
    }
    else {
        sendstr("pass\n");
    }
    
  return self;
}

- refreshIO {
    [self setblacksPrisoners:blackCaptured];
    [self setwhitesPrisoners:whiteCaptured];

    [self lockFocus];
    [[self window] flushWindow];
    [self drawRect:[self bounds]];
    [self display];
    [self unlockFocus];

    PSWait();

    return self;
}

- addMoveToGameMoves: (int)color: (int)x: (int)y {
    int i, j, k, numchanges;

    numchanges = 0;
    for (i = 0; i < MAXX; i++)
        for (j = 0; j < MAXY; j++)
            if (p[i][j] != oldBoard[i][j])
                numchanges++;
    if (x < 0 || y < 0)
        numchanges++;
    gameMoves[lastMove].numchanges = numchanges;
    gameMoves[lastMove].changes = (struct change *)
        malloc((size_t)sizeof(struct change)*numchanges);
    k = 0;
    if (x < 0 || y < 0) {
        gameMoves[lastMove].changes[0].added = NO;
      	gameMoves[lastMove].changes[0].x = x;
        gameMoves[lastMove].changes[0].y = y;
        gameMoves[lastMove].changes[0].color = color;
      	k++;
    }
    for (i = 0; i < MAXX; i++)
        for (j = 0; j < MAXY; j++)
            if (p[i][j] != oldBoard[i][j]) {
                gameMoves[lastMove].changes[k].x = i;
                gameMoves[lastMove].changes[k].y = j;
                if (p[i][j] != EMPTY) {
                    gameMoves[lastMove].changes[k].added = YES;
                    gameMoves[lastMove].changes[k].color = p[i][j];
                }
                else {
                    gameMoves[lastMove].changes[k].added = NO;
                    gameMoves[lastMove].changes[k].color = oldBoard[i][j];
                }
                k++;
            }
    gameMoves[lastMove].blackCaptured = blackCaptured;
    gameMoves[lastMove].whiteCaptured = whiteCaptured;

    lastMove++;

    if (x >= 0)
        hist[x][y] = lastMove;

    return self;
}

- makeMove: (int)color: (int)x: (int)y {
	int oldwhitesPrisoners, oldblacksPrisoners, i, j;

	currentStone = color;
	opposingStone = (currentStone == BLACKSTONE)?WHITESTONE:BLACKSTONE;

	if ((x >= 0) && (y >= 0)) {
		for (i = 0; i < MAXX; i++)
        	for (j = 0; j < MAXX; j++)
          		oldBoard[i][j] = p[i][j];

      	p[x][y] = color;
      
      	setStoneLoc(x,y);

	    [self lockFocus];
      	switch (p[x][y]) {
        	case WHITESTONE: 
				[self showWhiteStone];
          		break;
        	case BLACKSTONE: 
				[self showBlackStone];
          		break;
        	default: 
				break;
        }
      	[self unlockFocus];

      	oldblacksPrisoners = blackCaptured;
      	oldwhitesPrisoners = whiteCaptured;
      
      	examboard(opposingStone);
  
      	[self setblacksPrisoners:blackCaptured];
      	[self setwhitesPrisoners:whiteCaptured];
  
      	if (((oldblacksPrisoners != blackCaptured) ||
           (oldwhitesPrisoners != whiteCaptured))) {
        	[self lockFocus];
	  		[self display];
          	[self unlockFocus];
        
		}

      	if ([showHistFlag intValue]) {
          	NSRect tmpRect = {{floor(stoneX), floor(stoneY)},
	    		      {floor(STONEWIDTH), floor(STONEHEIGHT)}};

          	[self lockFocus];
          	[self drawRect:tmpRect];
          	[self display];
			[self unlockFocus];
		}
		
		if (blackPassed) {
			blackPassed = 0;
			[gameMessage2 setStringValue:@""];
		}
		
		if (whitePassed) {
			whitePassed = 0;
			[gameMessage2 setStringValue:@""];
		}
	}
	[self addMoveToGameMoves: color: x: y];
	
	[gameMessage setStringValue:(opposingStone == BLACKSTONE) ? @"Black's Turn" : @"White's Turn"];
	
	if ((-1 == x) && (-1 == y)) {		/* opponent has passed */
		if (currentStone == BLACKSTONE) {
			blackPassed = 1;
    		[gameMessage2 setStringValue:@"Black has passed."];
		}
		else {
 			whitePassed = 1;
    		[gameMessage2 setStringValue:@"White has passed."];
		}
    }
    {
	struct timeval tp;
    	struct timezone tzp;
    	gettimeofday(&tp, &tzp);
		time = tp.tv_sec;
    }	
    [self doClick];
    [self setNeedsDisplay:YES];
    return self;
}

- makeMoveSilent: (int)color: (int)x: (int)y
{
  int i, j;
      
  if ((x >= 0) && (y >= 0))
    {
      for (i = 0; i < MAXX; i++)
	for (j = 0; j < MAXY; j++)
	  oldBoard[i][j] = p[i][j];

      p[x][y] = color;

      currentStone = color;
      opposingStone = (currentStone == BLACKSTONE)?WHITESTONE:BLACKSTONE;

      examboard(opposingStone);

      [self addMoveToGameMoves: color: x: y];
    }
  
  return self;
}

- setTimeAndByo: (int)btime: (int)bbyo: (int)wtime: (int)wbyo {
#ifdef DEBUG
    printf("setTimeAndByo: BlackTime = %d, BlackByo = %d, WhitTime = %d, Whitebyo = %d\n", btime, bbyo, wtime, wbyo);
#endif
    if (bTime != -1) {
        if (bTime < 0)
            bTime = 0;
        if (wTime < 0)
            wTime = 0;
        [self removeTE];
        startZeit = 0;
        if (currentStone == WHITESTONE) {		/* Black moved */
            ts.byo = bbyo;
            ts.time = btime;
            ts.timeToHandle = blackTime;
        }
        else {						/* White moved */
            ts.byo = wbyo;
            ts.time = wtime;
            ts.timeToHandle = whiteTime;
	}
        te = [[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(TEHandler:) userInfo:self repeats:YES] retain];
        bTime = btime;
        bByo = bbyo;
        wTime = wtime;
        wByo = wbyo;
    }
    return self;
}

- dispTime
{
	char bltime[25], whtime[25];

    sprintf(bltime, "%d:%02d", bTime / 60, bTime % 60);
    if (bByo != -1)
		sprintf(bltime, "%s, %d", bltime, bByo);
    sprintf(whtime, "%d:%02d", wTime / 60, wTime % 60);
    if (wByo != -1)
		sprintf(whtime, "%s, %d", whtime, wByo);
	[blackTime setStringValue:[NSString stringWithCString:bltime]];
	[blackTime display];
	[whiteTime setStringValue:[NSString stringWithCString:whtime]];
	[whiteTime display];
	return self;
}

- setGameNumber: (int)n
{
  [IGSGameNumber setIntValue:n];
  [IGSGameNumber display];
  
  return self;
}

- updateTitle {
    id buf = [ NSString stringWithString:[IGSBlackPlayer stringValue]];
    buf = [buf stringByAppendingString:[NSString stringWithString:@" - "] ];
    buf = [buf stringByAppendingString:[IGSWhitePlayer stringValue]];
    [[self window] setTitle:buf];
	
    return self;	
}

- setWhiteName: (char *)wname {
	
	[IGSWhitePlayer setStringValue:[NSString stringWithCString:wname]];
	[IGSWhitePlayer display];
	[self updateTitle];

	return self;
}

- setBlackName: (char *)bname {

	[IGSBlackPlayer setStringValue:[NSString stringWithCString:bname]];
	[IGSBlackPlayer display];
	[self updateTitle];

	return self;
}

- setIGSHandicap: (int)h
{
  [IGShandicap setIntValue:h];
  [IGShandicap display];

  return self;
}

- setIGSKomi: (char *)k
{
  [IGSkomi setStringValue:[NSString stringWithCString:k]];
  [IGSkomi display];

  return self;
}

- setByoTime: (int)aByoTime {
	ByoTime = aByoTime;
	
	return self;
}

- (int) ByoTime {
	return ByoTime;
}

- updateInfo {
    int oldblacksPrisoners, oldwhitesPrisoners, i, j;

    if (finished && gameScored && resultsDisplayed) {
        [startButton setEnabled:NO];
        [stopButton setEnabled:NO];
        [passButton setEnabled:NO];
        return self;
    }

    oldblacksPrisoners = blackCaptured;
    oldwhitesPrisoners = whiteCaptured;

    examboard(opposingStone);

    if (currentStone == BLACKSTONE) {
        opposingStone = BLACKSTONE;
    	currentStone = WHITESTONE;
    	[gameMessage setStringValue:@"White's Turn"];
    }
    else {
        opposingStone = WHITESTONE;
    	currentStone = BLACKSTONE;
    	[gameMessage setStringValue:@"Black's Turn"];
    }

    [self setblacksPrisoners:blackCaptured];
    [self setwhitesPrisoners:whiteCaptured];

    if (((oldblacksPrisoners != blackCaptured) ||
         (oldwhitesPrisoners != whiteCaptured))) {
        [self lockFocus];
      	for (i = 0; i < MAXX; i++)
            for (j = 0; j < MAXX; j++)
                if ((oldBoard[i][j] != EMPTY) && (p[i][j] == EMPTY)) {
                    setStoneLoc(i, j);
                    [self eraseStone];
                    [self showBackgroundPiece: i: j];
                }
        [self unlockFocus];
    }

    if ([showHistFlag intValue]) {
        NSRect tmpRect = {{floor(stoneX), floor(stoneY)},
			  {floor(STONEWIDTH), floor(STONEHEIGHT)}};

        [self lockFocus];
        [self drawRect:tmpRect];
        [self display];
        [self unlockFocus];
    }

    if ((blackPassed) && (opposingStone == BLACKSTONE))
        [gameMessage2 setStringValue:@"Black has passed."];

    if ((whitePassed) && (opposingStone == WHITESTONE))
        [gameMessage2 setStringValue:@"White has passed."];

    if ((!blackPassed) && (!whitePassed))
        [gameMessage2 setStringValue:@""];

    if ((blackPassed) && (whitePassed) && (!manualScoring) && (!gameScored)) {
        [self lockFocus];
        [[self window] flushWindow];
        [gameMessage setStringValue:@"Scoring Game, Please Wait"];
        [gameMessage2 setStringValue:@"Removing Dead Groups..."];
        [self display];
        [self unlockFocus];
        finished = 1;
        score_game();
//      [self scoreGame];
        manualScoring = 1;
    }
    
    if ((blackPassed) && (whitePassed) && (manualScoring) && (!gameScored)) {
        [self lockFocus];
        [[self window] flushWindow];
        [gameMessage setStringValue:@"Please remove dead groups"];
        [gameMessage2 setStringValue:@"When finished, press Start..."];
        [self display];
        [self unlockFocus];
        [passButton setEnabled:NO];
        [stopButton setEnabled:NO];
        finished = 1;
        scoringGame = YES;
    }

  return self;

}

- displayScoringInfo
{
  char s[35];
  int i, j;

  if (gameScored)
    {
      resultsDisplayed = YES;
      if (typeOfScoring == 0)
	{
	  black_Score = (float)blackTerritory - (float)blackCaptured;
	  white_Score = (float)whiteTerritory - (float)whiteCaptured;
	  white_Score += (handicap == 0)?KOMI:0.5;
	  [TypeOfScoring setStringValue:@"Japanese Scoring Method"];
	  [BlackTerrString setStringValue:@"Territory"];
	  [WhiteTerrString setStringValue:@"Territory"];
	  [BlackTerrValue setIntValue:blackTerritory];
	  [WhiteTerrValue setIntValue:whiteTerritory];
	  [BlackPrisonString setStringValue:@"Prisoners"];
	  [WhitePrisonString setStringValue:@"Prisoners"];
	  [BlackPrisonValue setIntValue:blackCaptured];
	  [WhitePrisonValue setIntValue:whiteCaptured];
	  [BlackTotalValue setFloatValue:black_Score];
	  [WhiteTotalValue setFloatValue:white_Score];
	}
      else
	{
	  blackStones = whiteStones = 0;
	  for (i = 0; i < MAXX; i++)
	    for (j = 0; j < MAXY; j++)
	      {
		if (p[i][j] == BLACKSTONE) blackStones++;
		if (p[i][j] == WHITESTONE) whiteStones++;
	      }
	  black_Score = (float)blackTerritory + (float)blackStones;
	  white_Score = (float)whiteTerritory + (float)whiteStones;
	  white_Score += (handicap == 0)?KOMI:0.5;
	  [TypeOfScoring setStringValue:@"Chinese Scoring Method"];
	  [BlackTerrString setStringValue:@"Territory"];
	  [WhiteTerrString setStringValue:@"Territory"];
	  [BlackTerrValue setIntValue:blackTerritory];
	  [WhiteTerrValue setIntValue:whiteTerritory];
	  [BlackPrisonString setStringValue:@"Stones"];
	  [WhitePrisonString setStringValue:@"Stones"];
	  [BlackPrisonValue setIntValue:blackStones];
	  [WhitePrisonValue setIntValue:whiteStones];
	  [BlackTotalValue setFloatValue:black_Score];
	  [WhiteTotalValue setFloatValue:white_Score];
	}
      if (black_Score > white_Score)
	sprintf(s, "Result:  Black wins by %3.1f points.", black_Score - white_Score);
      if (white_Score > black_Score)
	sprintf(s, "Result:  White wins by %3.1f points.", white_Score - black_Score);
      if (black_Score == white_Score)
	sprintf(s, "Result:  The game was a tie.");
      [KomiValue setFloatValue:((handicap == 0)?KOMI:0.5)];
      [GameResult setStringValue:[NSString stringWithCString:s]];
      [ScoringWindow makeKeyAndOrderFront:self];
      [gameMessage setStringValue:@"Game Over"];
      [self lockFocus];
      [self display];
      [self unlockFocus];
    }
  
  return self;
}

- scoreGame
{
  int i, j, k, l, changes = 1, num_in_pattern;

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      scoringmat[i][j] = 0;
      
  while (changes)
    {
      changes = 0;
      find_owner();

      for (i = 0; i < MAXX; i++)
	for (j = 0; j < MAXY; j++)
	  if ((p[i][j] != 0) && (scoringmat[i][j] == 0))
	    {
	      if (surrounds_territory(i, j))
		{
		  find_pattern_in_board(i, j);

		  for (k = 0; k < MAXX; k++)
		    for (l = 0; l < MAXY; l++)
		      if (patternmat[k][l])
			scoringmat[k][l] = p[k][l];
		}
	      else
		{
		  find_pattern_in_board(i, j);
		  set_temp_to_p();
		  num_in_pattern = 0;

		  for (k = 0; k < MAXX; k++)
		    for (l = 0; l < MAXY; l++)
		      if (patternmat[k][l])
			{
			  p[k][l] = EMPTY;
			  [self flashStone:k:l];
			  num_in_pattern++;
			}

		  find_owner();

		  if ((ownermat[i][j] != NEUTRAL_TERR) &&
		      (ownermat[i][j] != tempmat[i][j]))
		    {
		      if (tempmat[i][j] == BLACKSTONE)
			blackCaptured += num_in_pattern;
		      else
			whiteCaptured += num_in_pattern;
		      changes++;
		      [self lockFocus];
		      [self display];
		      [self unlockFocus];
		    }
		  else
		    {
		      set_p_to_temp();
		      find_owner();
		    }
		}
	    }
    }

/*  blackTerritory = 0;
  whiteTerritory = 0;

  [self lockFocus];
  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      {
	if (ownermat[i][j] == BLACKSTONE)
	  {
	    blackTerritory++;
	    p[i][j] = BLACK_TERR;
	  }
	if (ownermat[i][j] == WHITESTONE)
	  {
	    whiteTerritory++;
	    p[i][j] = WHITE_TERR;
	  }
	if (ownermat[i][j] == NEUTRAL_TERR)
	  {
	    [self flashStone:i:j];
	    p[i][j] = NEUTRAL_TERR;
	  }
      }
  [self unlockFocus];   */

  return self;
}

// The following methods draw the pieces.
  
  - drawBlackStone:imageRep 
{
  if ([[NSDPSContext currentContext] isDrawingToScreen]) {
    PSsetalpha (1.0);
  }
  
  // Draw the stone.
  PSarc (RADIUS, RADIUS, 
	 RADIUS, 0.0, 360.0);
  PSsetgray (NSBlack);
  PSfill ();
  
  // And the lighter & darker spots on the stone...  
  PSarcn (RADIUS, RADIUS, 
	  RADIUS-SHADOWOFFSET-3.0, 170.0, 100.0);
  PSarc (RADIUS, RADIUS, 
	 RADIUS-SHADOWOFFSET-2.0, 100.0, 170.0);
  PSsetgray (NSDarkGray);
  PSfill ();
  PSarcn (RADIUS, RADIUS, 
	  RADIUS-SHADOWOFFSET-3.0, 350.0, 280.0);
  PSarc (RADIUS, RADIUS, 
	 RADIUS-SHADOWOFFSET-2.0, 280.0, 350.0);
  PSsetgray (NSLightGray);
  PSfill ();
  
  return self;
}

- drawWhiteStone:imageRep 
{
  if ([[NSDPSContext currentContext] isDrawingToScreen]) 
    {
      PSsetalpha (1.0);
    }
  
  // Draw the stone.
  PSarc (RADIUS, RADIUS, 
	 RADIUS, 0.0, 360.0);
  PSsetgray (NSWhite);
  PSfill ();
  
  // And the lighter & darker spots on the stone...
    
    PSarcn (RADIUS, RADIUS, 
	    RADIUS-SHADOWOFFSET-3.0, 170.0, 100.0);
  PSarc (RADIUS, RADIUS, 
	 RADIUS-SHADOWOFFSET-2.0, 100.0, 170.0);
  PSsetgray (NSLightGray);
  PSfill ();
  PSarcn (RADIUS, RADIUS, 
	  RADIUS-SHADOWOFFSET-3.0, 350.0, 280.0);
  PSarc (RADIUS, RADIUS, 
	 RADIUS-SHADOWOFFSET-2.0, 280.0, 350.0);
  PSsetgray (NSDarkGray);
  PSfill ();
  
  return self;
}

- drawGrayStone:imageRep 
{
  if ([[NSDPSContext currentContext] isDrawingToScreen]) 
    {
      PSsetalpha (1.0);
    }
  
  // Draw the stone.
  PSarc (RADIUS, RADIUS, 
	 RADIUS, 0.0, 360.0);
  PSsetgray (NSDarkGray);
  PSfill ();
  
  // And the lighter & darker spots on the stone...
  PSarcn (RADIUS, RADIUS, 
	  RADIUS-SHADOWOFFSET-3.0, 170.0, 100.0);
  PSarc (RADIUS, RADIUS, 
	 RADIUS-SHADOWOFFSET-2.0, 100.0, 170.0);
  PSsetgray (NSLightGray);
  PSfill ();
  PSarcn (RADIUS, RADIUS, 
	  RADIUS-SHADOWOFFSET-3.0, 350.0, 280.0);
  PSarc (RADIUS, RADIUS, 
	 RADIUS-SHADOWOFFSET-2.0, 280.0, 350.0);
  PSsetgray (NSWhite);
  PSfill ();
  
  return self;
}

- drawUpperLeft:imageRep
{
  PSsetgray(NSBlack);
  PSsetlinewidth(0.0);
  if ([[NSDPSContext currentContext] isDrawingToScreen]) {
    PSsetalpha (1.0);
  }

  PSnewpath();
  PSmoveto(RADIUS, RADIUS);
  PSlineto([self bounds].size.width,RADIUS);
  PSmoveto(RADIUS, RADIUS);
  PSlineto(RADIUS, 0.0);
  PSmoveto(RADIUS-SHADOWOFFSET, RADIUS+SHADOWOFFSET);
  PSlineto([self bounds].size.width, RADIUS+SHADOWOFFSET);
  PSmoveto(RADIUS-SHADOWOFFSET, RADIUS+SHADOWOFFSET);
  PSlineto(RADIUS-SHADOWOFFSET, 0.0);
  PSstroke();

  return self;
}

- drawUpperRight:imageRep
{
  PSsetgray(NSBlack);
  PSsetlinewidth(0.0);
  if ([[NSDPSContext currentContext] isDrawingToScreen]) {
    PSsetalpha (1.0);
  }

  PSnewpath();
  PSmoveto(RADIUS, RADIUS);
  PSlineto(0.0,RADIUS);
  PSmoveto(RADIUS, RADIUS);
  PSlineto(RADIUS, 0.0);
  PSmoveto(RADIUS+SHADOWOFFSET, RADIUS+SHADOWOFFSET);
  PSlineto(0.0, RADIUS+SHADOWOFFSET);
  PSmoveto(RADIUS+SHADOWOFFSET, RADIUS+SHADOWOFFSET);
  PSlineto(RADIUS+SHADOWOFFSET, 0.0);
  PSstroke();

  return self;
}

- drawLowerLeft:imageRep
{
  PSsetgray(NSBlack);
  PSsetlinewidth(0.0);
  if ([[NSDPSContext currentContext] isDrawingToScreen]) {
    PSsetalpha (1.0);
  }

  PSnewpath();
  PSmoveto(RADIUS, RADIUS);
  PSlineto([self bounds].size.width,RADIUS);
  PSmoveto(RADIUS, RADIUS);
  PSlineto(RADIUS, [self bounds].size.height);
  PSmoveto(RADIUS-SHADOWOFFSET, RADIUS-SHADOWOFFSET);
  PSlineto([self bounds].size.width, RADIUS-SHADOWOFFSET);
  PSmoveto(RADIUS-SHADOWOFFSET, RADIUS-SHADOWOFFSET);
  PSlineto(RADIUS-SHADOWOFFSET, [self bounds].size.height);
  PSstroke();

  return self;
}

- drawLowerRight:imageRep
{
  PSsetgray(NSBlack);
  PSsetlinewidth(0.0);
  if ([[NSDPSContext currentContext] isDrawingToScreen]) {
    PSsetalpha (1.0);
  }

  PSnewpath();
  PSmoveto(RADIUS, RADIUS);
  PSlineto(0.0,RADIUS);
  PSmoveto(RADIUS, RADIUS);
  PSlineto(RADIUS, [self bounds].size.height);
  PSmoveto(RADIUS+SHADOWOFFSET, RADIUS-SHADOWOFFSET);
  PSlineto(0.0, RADIUS-SHADOWOFFSET);
  PSmoveto(RADIUS+SHADOWOFFSET, RADIUS-SHADOWOFFSET);
  PSlineto(RADIUS+SHADOWOFFSET, [self bounds].size.height);
  PSstroke();

  return self;
}

- drawMidLeft:imageRep
{
  PSsetgray(NSBlack);
  PSsetlinewidth(0.0);
  if ([[NSDPSContext currentContext] isDrawingToScreen]) {
    PSsetalpha (1.0);
  }

  PSnewpath();
  PSmoveto(RADIUS, RADIUS);
  PSlineto([self bounds].size.width,RADIUS);
  PSmoveto(RADIUS, [self bounds].size.height);
  PSlineto(RADIUS, 0.0);
  PSmoveto(RADIUS-SHADOWOFFSET, [self bounds].size.height);
  PSlineto(RADIUS-SHADOWOFFSET, 0.0);
  PSstroke();

  return self;
}

- drawMidRight:imageRep
{
  PSsetgray(NSBlack);
  PSsetlinewidth(0.0);
  if ([[NSDPSContext currentContext] isDrawingToScreen]) {
    PSsetalpha (1.0);
  }

  PSnewpath();
  PSmoveto(RADIUS, RADIUS);
  PSlineto(0.0,RADIUS);
  PSmoveto(RADIUS, [self bounds].size.height);
  PSlineto(RADIUS, 0.0);
  PSmoveto(RADIUS+SHADOWOFFSET, [self bounds].size.height);
  PSlineto(RADIUS+SHADOWOFFSET, 0.0);
  PSstroke();

  return self;
}

- drawMidTop:imageRep
{
  PSsetgray(NSBlack);
  PSsetlinewidth(0.0);
  if ([[NSDPSContext currentContext] isDrawingToScreen]) {
    PSsetalpha (1.0);
  }

  PSnewpath();
  PSmoveto(RADIUS, RADIUS);
  PSlineto(RADIUS,0.0);
  PSmoveto(0.0, RADIUS);
  PSlineto([self bounds].size.width, RADIUS);
  PSmoveto(0.0, RADIUS+SHADOWOFFSET);
  PSlineto([self bounds].size.width, RADIUS+SHADOWOFFSET);
  PSstroke();

  return self;
}

- drawMidBottom:imageRep
{
  PSsetgray(NSBlack);
  PSsetlinewidth(0.0);
  if ([[NSDPSContext currentContext] isDrawingToScreen]) {
    PSsetalpha (1.0);
  }

  PSnewpath();
  PSmoveto(RADIUS, RADIUS);
  PSlineto(RADIUS,[self bounds].size.height);
  PSmoveto(0.0, RADIUS);
  PSlineto([self bounds].size.width, RADIUS);
  PSmoveto(0.0, RADIUS-SHADOWOFFSET);
  PSlineto([self bounds].size.width, RADIUS-SHADOWOFFSET);
  PSstroke();

  return self;
}

- drawInnerSquare:imageRep
{
  PSsetgray(NSBlack);
  PSsetlinewidth(0.0);
  if ([[NSDPSContext currentContext] isDrawingToScreen]) {
    PSsetalpha (1.0);
  }

  PSnewpath();
  PSmoveto(0.0, RADIUS);
  PSlineto([self bounds].size.width,RADIUS);
  PSmoveto(RADIUS, [self bounds].size.height);
  PSlineto(RADIUS, 0.0);
  PSstroke();

  return self;
}

- drawInnerHandicap:imageRep
{
  PSsetgray(NSBlack);
  PSsetlinewidth(0.0);
  if ([[NSDPSContext currentContext] isDrawingToScreen]) {
    PSsetalpha (1.0);
  }

  PSnewpath();
  PSmoveto(0.0, RADIUS);
  PSlineto([self bounds].size.width,RADIUS);
  PSmoveto(RADIUS, [self bounds].size.height);
  PSlineto(RADIUS, 0.0);
  PSstroke();
  
  PSarc(RADIUS, RADIUS, SHADOWOFFSET, 0.0, 360.0);
  PSfill();

  return self;
}

// The following methods show or erase the stones from the board.
  
- showBlackStone 
{
  NSRect tmpRect = {{floor(stoneX), floor(stoneY)},
		      {floor(STONEWIDTH), floor(STONEHEIGHT)}};
  [blackStone compositeToPoint:tmpRect.origin operation:NSCompositeSourceOver];
  return self;
}

- showWhiteStone
{
  NSRect tmpRect = {{floor(stoneX), floor(stoneY)},
		      {floor(STONEWIDTH), floor(STONEHEIGHT)}};
  [whiteStone compositeToPoint:tmpRect.origin operation:NSCompositeSourceOver];
  return self;
}

- showGrayStone
{
  NSRect tmpRect = {{floor(stoneX), floor(stoneY)},
		      {floor(STONEWIDTH), floor(STONEHEIGHT)}};
  [grayStone compositeToPoint:tmpRect.origin operation:NSCompositeSourceOver];
  return self;
}

- eraseStone
{
  NSRect tmpRect = {{floor(stoneX), floor(stoneY)}, {floor(STONEWIDTH), floor(STONEHEIGHT)}};
  return [self drawBackground:&tmpRect];
}

// drawBackground: just draws the specified piece of the background by
// compositing from the background image.

- showBackgroundPiece: (int)x: (int)y {
  int q;
  NSRect tmpRect = {{floor(stoneX), floor(stoneY)}, {floor(STONEWIDTH), floor(STONEHEIGHT)}};

  if ((x == 0) && (y == 0))
    [upperLeft compositeToPoint:tmpRect.origin operation:NSCompositeSourceOver];
  
  if ((x == 0) && (y == MAXY - 1))
    [lowerLeft compositeToPoint:tmpRect.origin operation:NSCompositeSourceOver];
  
  if ((x == MAXX - 1) && (y == 0))
    [upperRight compositeToPoint:tmpRect.origin operation:NSCompositeSourceOver];
  
  if ((x == MAXX - 1) && (y == MAXY - 1))
    [lowerRight compositeToPoint:tmpRect.origin operation:NSCompositeSourceOver];
  
  if ((x == 0) && (y > 0) && (y < MAXY - 1))
    [midLeft compositeToPoint:tmpRect.origin operation:NSCompositeSourceOver];
  
  if ((x == MAXX - 1) && (y > 0) && (y < MAXY - 1))
    [midRight compositeToPoint:tmpRect.origin operation:NSCompositeSourceOver];
  
  if ((x > 0) && (x < MAXX - 1) && (y == 0))
    [midTop compositeToPoint:tmpRect.origin operation:NSCompositeSourceOver];
  
  if ((x > 0) && (x < MAXX - 1) && (y == MAXY - 1))
    [midBottom compositeToPoint:tmpRect.origin operation:NSCompositeSourceOver];
  
  if ((x > 0) && (x < MAXX - 1) && (y > 0) && (y < MAXY - 1))
    [innerSquare compositeToPoint:tmpRect.origin operation:NSCompositeSourceOver];
    
  if (MAXX < 13)
    q = 2;
  else
    q = 3;
  
  if (((x == q) && (y == q)) || ((x == q) && (y == MAXY/2)) ||
      ((x == q) && (y == MAXY-q-1)) || ((x == MAXX/2) && (y == q)) ||
      ((x == MAXX/2) && (y == MAXY/2)) || ((x == MAXX/2) && (y == MAXY-q-1)) ||
      ((x == MAXX-q-1) && (y == q)) || ((x == MAXX-q-1) && (y == MAXY/2)) ||
      ((x == MAXX-q-1) && (y == MAXY-q-1)))
    [innerHandicap compositeToPoint:tmpRect.origin operation:NSCompositeSourceOver];

  return self;
}
  
  - drawBackground:(NSRect *)rect
{
  NSRect tmpRect = *rect;
  
  (&tmpRect)->origin.x = floor(NSMinX(tmpRect));
  (&tmpRect)->origin.y = floor(NSMinY(tmpRect));
  if ([[NSDPSContext currentContext] isDrawingToScreen]) {
    PSsetgray (NSWhite);
    PScompositerect (NSMinX(tmpRect), NSMinY(tmpRect),
		     NSWidth(tmpRect), NSHeight(tmpRect), NSCompositeCopy);
  }
  [backGround compositeToPoint:tmpRect.origin fromRect:tmpRect operation:NSCompositeSourceOver];
  return self;
}

// drawSelf::, a method every decent View should have, redraws the game
// in its current state. This allows us to print the game very easily.
  
- (void)drawRect:(NSRect)rects {
  int xcnt, ycnt;
  char s[5], specialChar;
  NSRect  aRect = [self bounds];
  [self drawBackground:(&rects ? &rects : &aRect)];

  specialChar = 'a';

  for (xcnt = 0; xcnt < MAXX; xcnt++)
    {
      for (ycnt = 0; ycnt < MAXY; ycnt++)
	{
	  setStoneLoc(xcnt, ycnt);

	  switch (p[xcnt][ycnt])
	    {
	    case EMPTY: currentCharacter = 0;
	      [self showBackgroundPiece: xcnt: ycnt];
	      break;
	    case WHITESTONE: [self showWhiteStone];
	      if ([showHistFlag intValue])
		{
		  char s[5];
		  
		  [historyFont set];
		  PSsetgray(NSBlack);
		  PSmoveto(stoneX+RADIUS -
			   (floor(log(hist[xcnt][ycnt]+0.5)/log(10))+1.0)*3,
			   stoneY+RADIUS - 4);
		  if (hist[xcnt][ycnt] > 0)
		    {
		      sprintf(s, "%d", hist[xcnt][ycnt]);
		      PSshow(s);
		    }
		  else
		    {
		      PSmoveto(stoneX + RADIUS - 4, stoneY + RADIUS - 4);
		      PSshow("H");
		    }
		}
	      break;
	    case BLACKSTONE: [self showBlackStone];
	      if ([showHistFlag intValue])
		{
		  char s[5];

		  [historyFont set];
		  PSsetgray(NSWhite);
		  PSmoveto(stoneX+RADIUS -
			   (floor(log(hist[xcnt][ycnt]+0.5)/log(10))+1.0)*3,
			   stoneY+RADIUS - 4);
		  if (hist[xcnt][ycnt] > 0)
		    {
		      sprintf(s, "%d", hist[xcnt][ycnt]);
		      PSshow(s);
		    }
		  else
		    {
		      PSmoveto(stoneX + RADIUS - 4, stoneY + RADIUS - 4);
		      PSshow("H");
		    }
		}
	      break;
	    case NEUTRAL_TERR: [self showGrayStone];
	      break;
	    case WHITE_TERR: [self showBackgroundPiece: xcnt: ycnt];
	      [whiteTerrFont set];
	      PSsetgray(NSWhite);
	      PSmoveto(stoneX+RADIUS/3, stoneY+RADIUS/3+2);
	      PSshow("W");
	      break;
	    case BLACK_TERR: [self showBackgroundPiece: xcnt: ycnt];
	      [blackTerrFont set];
	      PSsetgray(NSDarkGray);
	      PSmoveto(stoneX+RADIUS/3+1, stoneY+RADIUS/3);
	      PSshow("B");
	      break;
	    case SPECIAL_CHAR: [self showBackgroundPiece: xcnt: ycnt];
	      // PSselectfont("Helvetica", 25.0);
	      PSsetgray(NSDarkGray);
	      PSmoveto(stoneX+RADIUS/3+1, stoneY+RADIUS/3);
	      sprintf(s,"%c",specialChar);
	      specialChar++;
	      PSshow(s);
	      break;
	    default: currentCharacter = 0;
	      [self showBackgroundPiece: xcnt: ycnt];
	      break;
	    }
	}
    }

  if ([showCoords intValue])
    {
      for (xcnt = 0; xcnt < MAXX; xcnt++)
	{
	  setStoneLoc(xcnt, 0);

	  [historyFont set];
	  PSsetgray(NSDarkGray);
	  PSmoveto(stoneX + RADIUS - 3, stoneY + RADIUS + 11);
	  s[0] = 'A' + xcnt;
	  if (xcnt > 7) s[0]++;
	  s[1] = 0;
	  PSshow(s);

          setStoneLoc(xcnt, MAXY - 1);
          PSmoveto(stoneX + RADIUS - 3, stoneY - 3);
	  PSshow(s);
	}
      for (ycnt = 0; ycnt < MAXX; ycnt++)
	{
	  setStoneLoc(0, ycnt);

	  [historyFont set];
	  PSsetgray(NSDarkGray);
	  PSmoveto(stoneX - 4, stoneY + RADIUS - 4);
	  sprintf(s, "%d", MAXY-ycnt);
	  PSshow(s);

	  setStoneLoc(MAXX - 1, ycnt);
	  if (xcnt < 10)
	    {
	      PSmoveto(stoneX + STONEWIDTH, stoneY + RADIUS - 4);
	    }
	  else
	    {
	      PSmoveto(stoneX + STONEWIDTH - 6, stoneY + RADIUS - 4);
	    }
	  PSshow(s);
	}
    }
}

- step {
//    NSEvent *peek_ev, *get_ev;

    if (gameType == IGSGAME) {
        return self;
    }

    if (neitherSide)
        return self;

    if (((currentStone == BLACKSTONE) && !blackSide) ||
        ((currentStone == WHITESTONE) && !whiteSide))
        return self;

    if (bothSides) {
        while ((gameRunning) && (!finished)) {
            [self selectMove];
            PSWait();
/*
            if( peek_ev = [NSApp nextEventMatchingMask:NSLeftMouseDownMask untilDate:[NSDate distantFuture] inMode:NSEventTrackingRunLoopMode dequeue:NO] ){
                get_ev = [ [self window] nextEventMatchingMask:NSLeftMouseDownMask untilDate:[NSDate distantFuture] inMode:NSEventTrackingRunLoopMode dequeue:YES];
                [NSApp sendEvent: get_ev];
            }
*/
        }

        PSWait();
    }
    else {
        [passButton setEnabled:NO];
        [self selectMove];

        PSWait();

        PSWait();
        [passButton setEnabled:YES];
        PSWait();
    }
    return self;
}

- selectMove {
    int i, j;

    PSWait();

    if( !bothSides )
    [stopButton setEnabled:NO];
  else
    [stopButton setEnabled:YES];

  for (i = 0; i < MAXX; i++)
    for (j = 0; j < MAXY; j++)
      oldBoard[i][j] = p[i][j];
  
  genmove( &i, &j );
  if (i >= 0)
    {
      p[i][j] = currentStone;

      [self flashStone: i: j];
    }

  if (((i < 0) || (j < 0)) && (AGAScoring))
    {
      if (currentStone == BLACKSTONE)
        blackCaptured++;
      else
        whiteCaptured++;
    }
  
  [self selectMoveEnd];
    
  if (i >= 0)
    {
      [self lockFocus];
      if (currentStone == BLACKSTONE)
        [self showBlackStone];
      else
        [self showWhiteStone];
      [self unlockFocus];

      [self doClick];
    }

  [self updateInfo];
    
  [self addMoveToGameMoves: currentStone: i: j];
  
  if ([showHistFlag intValue])
    {
      NSRect tmpRect = {{floor(stoneX), floor(stoneY)},
			  {floor(STONEWIDTH), floor(STONEHEIGHT)}};

      [self lockFocus];
      [self drawRect:tmpRect];
      [self display];
      [self unlockFocus];
    }

  PSWait();
  return self;
}

- selectMoveEnd
{
  PSWait();

  [startButton setEnabled:YES];
  [stopButton setEnabled:YES];
  PSWait();

  return self;
}

- flashStone: (int)x :(int)y
{
  
  setStoneLoc(x, y);
  
  [self lockFocus];
  [self showGrayStone];
  [self unlockFocus];
  
  return self;
}

- setMess1:(char *)s
{
  [gameMessage setStringValue:[NSString stringWithCString:s]];
  [gameMessage display];

  return self;
}

- setMess2:(char *)s
{
  [gameMessage2 setStringValue:[NSString stringWithCString:s]];
  [gameMessage2 display];

  return self;
}

- setblacksPrisoners:(int)bp
{
  [blacksPrisoners setIntValue:bp];
  [blacksPrisoners display];

  return self;
}

- setwhitesPrisoners:(int)wp
{
  [whitesPrisoners setIntValue:wp];
  [whitesPrisoners display];

  return self;
}

- (long)startZeit {
	return startZeit;
}

- setStartZeit:(long)aTime {
	startZeit = aTime;
	return self;
}

- (int)bByo {
	return bByo;
}

- (TimeStruct*)ts {
	return &ts;
}

- gameCompleted {
	
	[self removeTE];	
  	[self setblacksPrisoners:0];
  	[self setwhitesPrisoners:0];
	[IGSGameNumber setStringValue:@""]; 
	[IGSBlackPlayer setStringValue:@""]; 
	[IGSWhitePlayer setStringValue:@""]; 
	[IGShandicap setStringValue:@""]; 
	[IGSkomi setStringValue:@""];
	[blackTime setStringValue:@""];
	[whiteTime setStringValue:@""];

	return self;
}

- removeTE {
    if (te) {
	[te invalidate];
        [te release];
        te = 0;
    }
    return self;
}

- (void) TEHandler:(NSTimer *)aTimer {
    id obj;
    NSString *buf;
    int myTime, now;
    struct timeval tp;
    struct timezone tzp;
    gettimeofday(&tp, &tzp);
    now = tp.tv_sec;

    obj  = [aTimer userInfo];

    if ([obj startZeit] == 0L) {
        [obj setStartZeit:now];
    }
    myTime = ts.time - (now - [obj startZeit]);
#ifdef TIMEDEBUG
    printf("TEHandler: now = %ld, startZeit = %ld, ts.time = %d, myTime = %d\n", now, [obj startZeit], ts.time, myTime); 
#endif
    if (myTime < 0) {
        if (ts.byo == -1 || 		/* player is in normal game time */
            ts.byo == 25) { 		/* player is in byo-yomi but did 	*/
                                        /* not yet move */
            myTime += [obj ByoTime] * 60;
            ts.byo = 25;
        }
    }
    buf = [NSString stringWithFormat:@"%d:%02d", myTime / 60, myTime % 60];
    if (ts.byo != -1) {
        buf = [buf stringByAppendingFormat:@", %d", ts.byo];
    }
    [ts.timeToHandle setStringValue:buf];
    [ts.timeToHandle display];
}

@end

