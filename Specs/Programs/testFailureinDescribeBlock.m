#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecOutputter.h"
#import "Specs/Utils/TemporaryFileStuff.h"

CONTEXT(OCDSpecFail)
{
  describe(@"The Failures",
           it(@"Fails", 
            ^{
              FAIL(@"FAILURE");
            }),
           it(@"Also Fails",
            ^{
              FAIL(@"Another Failure");
            }),
           
           it(@"Will Fail You punk",
            ^{
              FAIL(@"Failed");
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
     
    NSString *outputException = ReadTemporaryFile();
    
    // Need an 'after'    
   // DeleteTemporaryFile();
    outputter.fileHandle = [NSFileHandle fileHandleWithStandardError];
    
    // For some reason outputException is faling, thats why this doesn't work.
    // Make the TemporaryFile stuff in to part of the Spec of the Spec not the Spec itself
    // Maybe it's a library object
    if ([outputException compare:@"Tests ran with 0 passing tests and 3 failing tests\n"] != 0)
    {
      FAIL(@"The wrong number of failing tests was written");
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
