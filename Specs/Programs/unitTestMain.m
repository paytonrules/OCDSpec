#import "OCSpecDescriptionRunner.h"

@interface TestClass : NSObject
{
}

@end

@implementation TestClass

-(void) applicationDidFinishLaunching:(UIApplication *) app
{
  OCSpecDescriptionRunner *runner = [[[OCSpecDescriptionRunner alloc] init] autorelease];
  
  [runner runAllDescriptions];
  
  NSLog(@"Tests ran with %d passing tests and %d failing tests", runner.successes, runner.failures);
  
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
