// ####################################################
// ### A G N o S t e p  -  Desktop - by Patrick Cardona
// ### pcardona34 @ Github
// ###
// ### Thanks for the GNUstep Developers Community
// ### This is Free and Open Source software.
// ### Read License in the root directory.
// ####################################################

// ################################
// ### UpMem.app
// ### Memory.h
// ################################

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface Memory : NSObject {
    NSWindow *window;
    NSTextField *memoryUsageLabel;
}

// Method to start the application
- (instancetype) init;
- (void) openMemory: (id) sender;

// Method to update memory usage
- (void)updateMemoryUsage:(NSTimer *)timer;

// Method to get memory usage
- (size_t)getMemoryUsage; // Declare getMemoryUsage method

// Method to get memory Total
- (size_t)getMemoryTotal; // Declare getMemoryTotal method


@end
