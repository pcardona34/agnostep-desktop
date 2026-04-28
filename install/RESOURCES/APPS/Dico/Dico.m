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
### Dico.app
### A French Dictionary Lookup App and Service
### Dico.m
####################################################
*/

#import "Dico.h"

@implementation Dico

- (void) awakeFromNib
{
  NSArray *arguments = [[NSProcessInfo processInfo] arguments];
  // Check if there are any arguments passed
    if ([arguments count] > 1) 
      {
        NSString *mot = [arguments lastObject]; // The last argument is the motif to search
        [motif setStringValue: mot];
        [self searchMotif: nil];
      }
}

- (IBAction) searchMotif: (id)sender
{
  if ( [motif stringValue] )
    {
    NSTask *task = [[NSTask alloc] init];
    NSString *dvlf = @"https://dvlf.uchicago.edu/mot/";
    NSString *url = [dvlf stringByAppendingString: [[motif stringValue] lowercaseString]];
    [task setLaunchPath: @"/usr/bin/surf"];
    [task setArguments: [NSArray arrayWithObjects: @"-z", @"1.5", url, nil]];
    [task launch];
    }
}

@end
