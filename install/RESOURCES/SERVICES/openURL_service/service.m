#import <Foundation/Foundation.h>  
#import <AppKit/AppKit.h>  
  
@interface OpenURLService : NSObject  
@end  
  
@implementation OpenURLService  
  
- (void)openURL:(NSPasteboard *)pboard   
       userData:(NSString *)userData   
          error:(NSString **)error   
{  
  NSString *url = [pboard stringForType:NSStringPboardType];  
  if (url) {  
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];  
  }  
}  
  
@end

int main(int argc, char **argv)  
{  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];  
  [NSApplication sharedApplication];  
    
  OpenURLService *service = [[OpenURLService alloc] init];  
  [NSApp setServicesProvider:service];  
  [service release];  
    
  [NSApp run];  
  [pool release];  
  return 0;  
}