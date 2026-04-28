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
### Main.m
####################################################
*/


#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>
#include "MyDelegate.h"

int main(int argc, const char * argv[]) 
{
    [NSApplication sharedApplication];
    MyDelegate *delegate = [MyDelegate new];
    [NSApp setDelegate: delegate];

    //Run the application loop
    return NSApplicationMain (argc, argv);
}
