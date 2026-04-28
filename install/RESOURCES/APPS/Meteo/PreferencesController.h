/* PreferencesController.h */

#import <AppKit/AppKit.h>

@interface PreferencesController : NSObject


{    
  NSWindow *prefsWindow;    
  NSTextField *locationTextField;
}

- (instancetype) init;
- (IBAction) showPreferences: (id)sender;
- (IBAction) saveLocation: (id)sender;
- (IBAction) cancelPreferences: (id)sender;

@end