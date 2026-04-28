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
### Updater.app: Debian packages updater
### Interface: ListController.h
####################################################
*/

#import <AppKit/AppKit.h>
#import "ProgressController.h"

@interface ListController : NSObject

{    
  
  NSUInteger *counter;
  NSButton *closeButton; 
  NSWindow *listWindow;
  ProgressController *progressController; 
  NSScrollView *scrollView;
  NSTextView *textView;
  NSButton *upgradeButton;
  
}

- (instancetype) init;
- (IBAction) showList: (id)sender;
- (IBAction) closeWindow:(id)sender;
- (IBAction) upgrade:(id) sender;
- (void) loadDataSynchronously;

@end