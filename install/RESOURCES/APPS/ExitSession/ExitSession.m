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
### EndSession.m: implementation
####################################################
*/

#include "ExitSession.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSWindow *window = [[NSWindow alloc]
        initWithContentRect:NSMakeRect(100, 100, 300, 200)
        styleMask:(NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable)
        backing:NSBackingStoreBuffered
        defer:NO];

    [window setTitle:@"Session Manager"];
    [window makeKeyAndOrderFront:nil];

    NSButton *killButton = [[NSButton alloc] initWithFrame:NSMakeRect(50, 100, 200, 50)];
    [killButton setTitle:@"Exit Session"];
    [killButton setTarget:self];
    [killButton setAction:@selector(endSession)];
    [[window contentView] addSubview:killButton];
}

- (void)endSession {
    NSTask *task = [[NSTask alloc] init];
    NSString *userName = NSUserName();
    [task setLaunchPath:@"/usr/bin/loginctl"];
    [task setArguments:[NSArray arrayWithObjects:@"terminate-user", userName, nil]];
    [task launch];
}

@end
