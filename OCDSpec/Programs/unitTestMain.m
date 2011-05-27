#import "OCDSpec/OCDSpecDescriptionRunner.h"

@interface TestClass : NSObject
{
}

@end

@implementation TestClass

-(void) applicationDidFinishLaunching:(UIApplication *) app
{
  OCDSpecDescriptionRunner *runner = [[[OCDSpecDescriptionRunner alloc] init] autorelease];
  
  [runner runAllDescriptions];
  
  [app performSelector:@selector(_terminateWithStatus:) withObject:(id) runner.failures];
}

@end

int main(int argc, char *argv[]) 
{  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  UIApplicationMain(argc, argv, nil, @"TestClass");
    
  [pool release];
  return 0;
}
