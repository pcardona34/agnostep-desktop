/* 
####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### (c) 2026 - pcardona34 @ Github
### Author: Patrick Cardona
###
### Thanks for the GNUstep Developers Community.
### This application is free software.
### Read complete License in the root directory.
####################################################

####################################################
### Pass.app
### Interface: New.h
####################################################
*/

#import <AppKit/AppKit.h>

@interface New : NSObject

{   
  NSWindow *newWindow;
  NSTextField *keyTextField;     
}

- (instancetype) init;
- (IBAction) showNew:(id)sender; 
- (IBAction) create:(id)sender;
- (IBAction) cancelCreate:(id)sender;


@end