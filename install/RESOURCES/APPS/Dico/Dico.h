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
### Dico.h
####################################################
*/

#ifndef Dico_H_INCLUDE
#define Dico_H_INCLUDE

#import <AppKit/AppKit.h>

@interface Dico : NSObject
{
  IBOutlet id motif;
}

- (void) awakeFromNib;
- (IBAction) searchMotif: (id)sender;

@end

#endif // Dico_H_INCLUDE
