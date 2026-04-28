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
### OpenDisk
### Open the media folder where removable disks are mounted.
### Implementation: MyDelegate.m
####################################################
*/

#import <AppKit/AppKit.h>
#import "../../../../build/apps-gworkspace/GWMetadata/MDFinder/MDFinder.h"
#import "../../../../build/apps-gworkspace/GWorkspace/GWorkspace.h"  
#import "MyDelegate.h"


@implementation MyDelegate


- (void) openMedia: (id) sender
{
    NSString *me = NSUserName();
    NSString *mediaPath = [@"/media/" stringByAppendingString: me];
    NSLog(@"Path is: %@", mediaPath);
    NSFileManager *manager = [NSFileManager defaultManager];  
    BOOL isDirectory;  
    BOOL exists = [manager fileExistsAtPath: mediaPath isDirectory: &isDirectory];  
  
    if (exists && isDirectory) {  
                    
    id workspaceApp = [NSConnection rootProxyForConnectionWithRegisteredName: @"GWorkspace" host: @""];  
    
    if (workspaceApp == nil) {  
      NSLog(@"Cannot connect to GWorkspace");  
      return;  
    }  
     
    [workspaceApp newViewerAtPath: mediaPath];  
    
    } else {  
      NSLog(@"Directory does not exist or path is not a directory");
    }  
}

/* **************************************************************************** */
/*
 * Standard method to prepare the UI from the delegate: applicationDidFinishLaunching
 *
 */

- (void)applicationDidFinishLaunching:(NSNotification *)notification 
{
    // Create a menu with a "quit" ...
    NSMenu *menu = [[NSMenu alloc] init];
    NSMenu *infoMenu;
    NSMenuItem *menuItem;
    menu = AUTORELEASE ([NSMenu new]);
    infoMenu = AUTORELEASE ([NSMenu new]);
  
    [infoMenu addItemWithTitle: @"Info Panel..." 
            action: @selector (orderFrontStandardInfoPanel:) 
            keyEquivalent: @""];

    [infoMenu addItemWithTitle: @"Help..." 
            action: @selector (orderFrontHelpPanel:)
            keyEquivalent: @"?"];

    menuItem = [menu addItemWithTitle: @"Info..." 
                   action: NULL 
                   keyEquivalent: @""];

    [menu setSubmenu: infoMenu  forItem: menuItem];
  
    [menu addItemWithTitle:@"Open Media Folder..." action:@selector(openMedia:) keyEquivalent:@""];
    [menu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@"q"];
        
    // Add the menu to the application
    NSApplication.sharedApplication.mainMenu = menu;   
}

@end
