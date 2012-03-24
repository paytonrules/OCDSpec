#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecOutputter+RedirectOutput.h"

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

-(NSString *) readResultFromFile 
{
  NSString *output = [[OCDSpecOutputter sharedOutputter] readOutput];
  NSArray *lines = [[output stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ] componentsSeparatedByString:@"\n"];
  NSString *outputException = [lines lastObject];
  return outputException;
}

-(OCDSpecExample *) testFinalResultOfMultipleDescribeMacrosFailing 
{
  OCDSpecExample *example = [[OCDSpecExample alloc] initWithBlock: ^{
    __block NSString *outputException;
    [OCDSpecOutputter withRedirectedOutput: ^{
      OCDSpecSuiteRunner *runner = [[OCDSpecSuiteRunner alloc] init];
      [runner runAllDescriptions];
     
      outputException = [self readResultFromFile];
    }];
    
    if ([outputException compare:@"Tests ran with 0 passing tests and 3 failing tests"] != 0)
    {
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

  
  [app performSelector:@selector(_terminateWithStatus:) withObject:[NSNumber numberWithInt:(example.failed ? 1 : 0)]];
}
@end

// This one off program exists specifically to test that the DESCRIBE macro generates 
// the classes necessary for the auto runners.  Putting them in with the other tests
// causes them to interfere with those tests, so I've got this tiny program.
// Theoretically redundant since the Macros are implicitly tested by being used in the tests.
int main(int argc, char *argv[]) 
{
  UIApplicationMain(argc, argv, nil, @"TestClass");
  return 0;
}
