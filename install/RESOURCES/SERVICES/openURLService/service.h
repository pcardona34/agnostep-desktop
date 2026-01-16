/* 
   service.m

   Inspired by:
   
   GNUstep example services facility
   Copyright (C) 1998 Free Software Foundation, Inc.
   Author:  Richard Frith-Macdonald <richard@brainstorm.co.uk>
   Date: November 1998
   
   Author: Patrick Cardona for this Service applied to openURL
   Date: December 2025
   
   This Service is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License
   as published by the Free Software Foundation; either version 2
   of the License, or (at your option) any later version.
    
   You should have received a copy of the GNU General Public  
   License along with this library; see the file COPYING.LIB.
   If not, write to the Free Software Foundation,
   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

*/ 

#import <Foundation/Foundation.h>
#import <AppKit/NSApplication.h>
#import <AppKit/NSPasteboard.h>

@interface openURLService : NSObject
- (void) openURLSelected: (NSPasteboard*)bp
	userData: (NSString*)ud
	   error: (NSString**)err;
	   
@end
