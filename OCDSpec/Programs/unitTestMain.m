#import "OCDSpecSuiteRunner.h"

@interface TestClass : NSObject
{
}

@end

@implementation TestClass

-(void) applicationDidFinishLaunching:(UIApplication *) app
{
  OCDSpecSuiteRunner *runner = [[[OCDSpecSuiteRunner alloc] init] autorelease];
  
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
