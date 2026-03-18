/* All rights reserved */

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
