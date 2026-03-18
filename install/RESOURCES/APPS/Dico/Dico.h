/* All rights reserved */

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
