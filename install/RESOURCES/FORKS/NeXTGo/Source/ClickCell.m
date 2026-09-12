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

/* $Id: ClickCell.m,v 1.2 2005/04/06 00:32:58 gcasa Exp $ */

/*
 * $Log: ClickCell.m,v $
 * Revision 1.2  2005/04/06 00:32:58  gcasa
 * Cleaned up the code.
 *
 * Revision 1.1  2003/01/12 04:01:51  gcasa
 * Committing the entire GNU Go and NeXT Go application to the repository.
 * See COPYING file for GNU License.
 *
 * Revision 1.4  1997/11/04 16:49:53  ergo
 * ported to OpenStep
 *
 * Revision 1.3  1997/07/06 19:37:56  ergo
 * actual version
 *
 * Revision 1.2  1997/05/04 18:56:51  ergo
 * added time control for moves
 *
 */

#import "ClickCell.h"
#import "GoApp.h"

#import <AppKit/NSText.h>
#import <AppKit/NSFont.h>
#import <AppKit/NSWindow.h>
#import <AppKit/NSApplication.h>

#import <stdio.h>

@implementation ClickCell

- (BOOL)trackMouse:(NSEvent *)theEvent inRect:(NSRect)cellFrame ofView:(NSView *)controlView untilMouseUp:(BOOL)_untilMouseUp
{
    [(GoApp *)NSApp cellClicked:self];

    return  YES;   
}    

- initTextCell:(NSString *)aString
{
    self = [super initTextCell:aString];
    [self setFont:[NSFont fontWithName:@"Helvetica" size:17]];
    [self setBackgroundColor:[NSColor lightGrayColor]];
    [self setBezeled:YES];
    [self setAlignment:NSLeftTextAlignment];
    return self;
}    
@end
