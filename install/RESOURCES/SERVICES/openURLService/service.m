/* 
   service.m

   Inspired by:
   GNUstep example services facility
   Copyright (C) 1998 Free Software Foundation, Inc.
   Author:  Richard Frith-Macdonald <richard@brainstorm.co.uk>
   Date: November 1998
   
   Author: Patrick Cardona for the service applied to openURL
   Date: December 2025-January 2026
   
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

@implementation openURLService


- (void) openURLSelected: (NSPasteboard*)pb
	userData: (NSString*)ud
	   error: (NSString**)err
{
  NSString	*url;
  NSArray	*types;
  NSArray	*args;
  NSString	*path;
  NSString         *browser;
  NSUserDefaults   *defs = [NSUserDefaults standardUserDefaults];

  *err = nil;
  types = [pb types];
  if (![types containsObject: NSStringPboardType])
    {
      *err = @"No string type supplied on pasteboard";
      return;
    }

  url = [pb stringForType: NSStringPboardType];
  if (url == nil)
    {
      *err = @"No string value supplied on pasteboard";
      return;
    }

  browser = [defs objectForKey:@"NSWebBrowser"];
  if(!browser || [browser isEqualToString:@""])
  {
    browser = @"/usr/bin/firefox --new-window";
  }

  path = @"/bin/bash";
  args = [NSArray arrayWithObjects:
    @"-c",
    [NSString stringWithFormat: @"%@ %@", browser, url],
    nil];

  [NSTask launchedTaskWithLaunchPath: path
                           arguments: args];
}

@end
