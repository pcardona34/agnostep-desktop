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
### Interface: ProgressController.h
####################################################
*/

#import <AppKit/AppKit.h>

@interface ProgressController : NSObject

{    
  
  NSButton *closeButton;
  NSUInteger currentIndex;    
  NSString *currentPackageName;
  NSArray *instanceLines;  
  NSTextField *label;
  NSProgressIndicator *progressBar;
  NSWindow *progressWindow;
  NSUInteger totalItems;
   
}

- (IBAction) closeWindow:(id)sender;
- (instancetype) init;
- (void) performUpgrade: (NSString *) packageName;
- (void) processNextLineSimple: (NSTimer *)timer;
- (IBAction) showProgress: (id)sender;

@end