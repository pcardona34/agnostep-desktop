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
### Main.m: main function
####################################################
*/

#include "ExitSession.h"

int main(int argc, const char *argv[]) 
{
  NSApplication *app = [NSApplication sharedApplication];
  AppDelegate *delegate = [[AppDelegate alloc] init];
  [app setDelegate: delegate];
  [app run];
  return 0;
}
