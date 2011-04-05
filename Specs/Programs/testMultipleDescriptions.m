#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecExample.h"
#import "OCDSpec/OCDSpecOutputter.h"
#import "TemporaryFileStuff.h"

CONTEXT(Test1)
{
  describe(@"First Description/Context",
           it(@"Fails",
              ^{
                FAIL(@"FAILURE");
              }),
           nil
           );
}

CONTEXT(Test2)
{
  describe(@"Second Context",
           it(@"Doesnt fail",
              ^{
                // Success
              }), 
           nil
           );
}

@interface TestClass : NSObject
-(void) applicationDidFinishLaunching:(UIApplication *)app;
@end

@implementation TestClass

-(void) applicationDidFinishLaunching:(UIApplication *)app
{
  OCDSpecExample *example = [[OCDSpecExample alloc] initWithBlock: ^{
    OCDSpecDescriptionRunner *runner = [[[OCDSpecDescriptionRunner alloc] init] autorelease];
    OCDSpecOutputter *outputter = [OCDSpecOutputter sharedOutputter];
    outputter.fileHandle = GetTemporaryFileHandle();
    
    [runner runAllDescriptions];
    
    outputter.fileHandle = [NSFileHandle fileHandleWithStandardError];
    DeleteTemporaryFile();
    
    if (runner.failures != 1)
    {
      FAIL(@"Did not run the failing test");
    }

    if (runner.successes != 1) 
    {
      FAIL(@"Did not run the successful test");
    }
    
  }];
  
  [example run];
  
  [app performSelector:@selector(_terminateWithStatus:) withObject:(id) (example.failed ? 1 : 0)];
}
@end

// This one off program exists specifically to test that the DESCRIBE macro generates 
// the classes necessary for the auto runners.  Putting them in with the other tests
// causes them to interfere with those tests, so I've got this tiny program.
// Theoretically redundant since the Macros are implicitly tested by being used in the tests.
int main(int argc, char *argv[]) 
{  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  UIApplicationMain(argc, argv, nil, @"TestClass");
  
  [pool release];
  return 0;
}
