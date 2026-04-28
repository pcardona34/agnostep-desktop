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
### Pass.app: Debian packages updater
### Interface: Search.h
####################################################
*/

#import <AppKit/AppKit.h>

@interface Search : NSObject

{   
  NSWindow *searchWindow;
  NSTextField *keyTextField;     
}

- (instancetype) init;
- (IBAction) showSearch:(id)sender; 
- (IBAction) performSearch:(id)sender;
- (IBAction) cancelSearch:(id)sender;


@end