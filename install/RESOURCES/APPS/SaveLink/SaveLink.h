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
### SaveLink: an Internet Shortcuts Manager
### SaveLink.h: Interface
####################################################
*/

#ifndef SaveLink_H_INCLUDE
#define SaveLink_H_INCLUDE

#import <AppKit/AppKit.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>

int isDirectoryExists (const char *path);
id getFavPath();

@interface SaveLink : NSObject
{
  IBOutlet id name;
  IBOutlet id link;
  IBOutlet id savebutton;
}

- (void) applicationDidFinishLaunching: (NSNotification *)aNotif;
- (void) awakeFromNib;
- (void) textDidChange: (NSNotification *)notification;
- (void) openWithPath: (NSString *)pathFile;
- (IBAction) save: (id)sender;
- (IBAction) reset: (id)sender;
- (IBAction) open: (id)sender;

@end

#endif // SaveLink_H_INCLUDE
