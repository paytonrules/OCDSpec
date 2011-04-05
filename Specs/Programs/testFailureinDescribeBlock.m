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
{
  OCDSpecOutputter *outputter;
}

-(void) applicationDidFinishLaunching:(UIApplication *)app;
@end

@implementation TestClass

-(void) redirectTestOutputToFile 
{
  outputter = [OCDSpecOutputter sharedOutputter];
  outputter.fileHandle = GetTemporaryFileHandle();
}

-(NSString *) readResultFromFile 
{
  NSString *output = ReadTemporaryFile();
  NSArray *lines = [[output stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ] componentsSeparatedByString:@"\n"];
  NSString *outputException = [lines lastObject];
  return outputException;
}

-(void) cleanupTestOutput
{
  // Need an 'after'    
  DeleteTemporaryFile();
  outputter.fileHandle = [NSFileHandle fileHandleWithStandardError];
}

-(void) setUp 
{
  [self redirectTestOutputToFile];
}

-(void) tearDown 
{
  [self cleanupTestOutput];
}

-(OCDSpecExample *) testFinalResultOfMultipleDescribeMacrosFailing 
{
  OCDSpecExample *example = [[OCDSpecExample alloc] initWithBlock: ^{
    [self setUp];
    
    OCDSpecDescriptionRunner *runner = [[[OCDSpecDescriptionRunner alloc] init] autorelease];
    [runner runAllDescriptions];
     
    NSString *outputException = [self readResultFromFile];

    [self tearDown];

    // Make the TemporaryFile stuff in to part of the Spec of the Spec not the Spec itself
    // Maybe it's a library object
    if ([outputException compare:@"Tests ran with 0 passing tests and 3 failing tests"] != 0)
    {
      NSLog(@"Exception was: %@", outputException);
      FAIL(@"The wrong number of failing tests was written");
    }
  }];
  
  [example run];
  return example;
}

-(void) applicationDidFinishLaunching:(UIApplication *)app
{
  OCDSpecExample *example;
  example = [self testFinalResultOfMultipleDescribeMacrosFailing];

  
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
