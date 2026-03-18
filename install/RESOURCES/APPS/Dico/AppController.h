/* 
   Project: Dico

   Author: patrick

   Created: 2026-03-10 20:19:31 +0100 by patrick
   
   Application Controller
*/
 
#ifndef _PCAPPPROJ_APPCONTROLLER_H
#define _PCAPPPROJ_APPCONTROLLER_H

#import <AppKit/AppKit.h>
// Uncomment if your application is Renaissance-based
//#import <Renaissance/Renaissance.h>

@interface AppController : NSObject
{
  IBOutlet NSWindow *_window;
}

// Class methods...
+ (void)  initialize;

// Initialization
- (id) init;
- (void) dealloc;

// Notification methods...
- (void) applicationDidFinishLaunching: (NSNotification *)aNotif;
- (BOOL) applicationShouldTerminate: (id)sender;
- (void) applicationWillTerminate: (NSNotification *)aNotif;
- (BOOL) application: (NSApplication *)application
	    openFile: (NSString *)fileName;

// Actions...
- (IBAction) showPrefPanel: (id)sender;

@end

#endif
