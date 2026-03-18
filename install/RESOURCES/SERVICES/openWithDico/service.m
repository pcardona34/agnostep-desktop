/* 
   service.m

   Inspired by:
   GNUstep example services facility
   Copyright (C) 1998 Free Software Foundation, Inc.
   Author:  Richard Frith-Macdonald <richard@brainstorm.co.uk>
   Date: November 1998
   
   Author: Patrick Cardona for the service applied to openWithDico
   Date: March 2026
   
   This Service is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License
   as published by the Free Software Foundation; either version 2
   of the License, or (at your option) any later version.
    
   You should have received a copy of the GNU General Public  
   License along with this library; see the file COPYING.LIB.
   If not, write to the Free Software Foundation,
   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

*/ 

#import <Cocoa/Cocoa.h>
#import "service.h"

@implementation openWithDico


- (void) openWordSelected: (NSPasteboard*)pb
	userData: (NSString*)ud
	   error: (NSString**)err
{
  NSString	*word;
  NSArray	*types;
  NSArray	*args;
  NSString	*path;

  *err = nil;
  types = [pb types];
  if (![types containsObject: NSStringPboardType])
    {
      *err = @"No string type supplied on pasteboard";
      return;
    }

  word = [pb stringForType: NSStringPboardType];
  if (word == nil)
    {
      *err = @"No string value supplied on pasteboard";
      return;
    }

  path = @"Dico";
  args = [NSArray arrayWithObjects: word,
    nil];

  [NSTask launchedTaskWithLaunchPath: path
                           arguments: args];
}

@end
