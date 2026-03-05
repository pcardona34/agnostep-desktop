/* 
####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### (c) 2026 - pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

####################################################
### TestCuckoo: a little app to test sound...
### Main
####################################################
*/

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "Delegate.h"

int main (int argc, const char **argv)
{ 
  ENTER_POOL;
  [NSApplication sharedApplication];
  [NSApp setDelegate: AUTORELEASE([MyDelegate new])];
  [NSApp run];
  LEAVE_POOL;
  return 0;
}