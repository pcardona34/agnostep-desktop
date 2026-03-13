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
### EndSession: a clean way to end the X session
### EndSession.h: Interface
####################################################
*/

#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
- (void)endSession;
@end


