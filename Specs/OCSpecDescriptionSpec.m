#import "OCDSpec/OcSpec.h"
#import "Specs/Mocks/MockExample.h"
#import "Specs/Utils/TemporaryFileStuff.h"

void testRunsOneExampleWithError()
{
  OCSpecDescription *description = [[[OCSpecDescription alloc] init] autorelease];
  description.outputter = [NSFileHandle fileHandleWithNullDevice];
  
  MockExample *example = [MockExample exampleThatFailed];  
  NSArray *examples = [NSArray arrayWithObjects:example, nil];
  
  [description describe:@"It Should Do Something" onArrayOfExamples: examples];
  
  if (description.errors != 1)
  {
    FAIL(@"Should have had 1 error, did not");
  }
}

void testDescribeWorksWithMultipleExamples()
{
  OCSpecDescription *description = [[[OCSpecDescription alloc] init] autorelease];
  description.outputter = [NSFileHandle fileHandleWithNullDevice];
  
  OCSpecExample *exampleOne = [[[OCSpecExample alloc] initWithBlock: ^{ FAIL(@"Fail One"); }] autorelease];
  OCSpecExample *exampleTwo = [[[OCSpecExample alloc] initWithBlock: ^{ FAIL(@"Fail Two"); }] autorelease];
  
  NSArray *tests = [NSArray arrayWithObjects:exampleOne, exampleTwo, nil];
  
  [description describe:@"It Should Do Something" onArrayOfExamples: tests];
  
  if (description.errors != 2)
  {
    FAIL(@"Should have had two errors, didn't");
  }
}

void testDescribeWorksWithMultipleSuccesses()
{
  OCSpecDescription *description = [[[OCSpecDescription alloc] init] autorelease];
  description.outputter = [NSFileHandle fileHandleWithNullDevice];
  
  OCSpecExample *exampleOne = [[[OCSpecExample alloc] initWithBlock: ^{ }] autorelease];
  OCSpecExample *exampleTwo = [[[OCSpecExample alloc] initWithBlock: ^{ }] autorelease];
  
  NSArray *tests = [NSArray arrayWithObjects:exampleOne, exampleTwo, nil];
  
  [description describe:@"It Should Do Something" onArrayOfExamples: tests];
  
  if (description.successes != 2)
  {
    FAIL(@"Should have had two successes, didn't");
  }
}

DESCRIBE(OCSpecDescription,
         IT(@"describes one example without errors",
            ^{
              OCSpecDescription *description = [[[OCSpecDescription alloc] init] autorelease];
              
              [description describe:@"It Should Do Something" onArrayOfExamples: [[[NSArray alloc] init] autorelease]];
              
              if (description.errors != 0) {
                FAIL(@"Should have had 0 errors.  Did not");
              }
            }),
         
         IT(@"describes an example with one error",
            ^{
              testRunsOneExampleWithError();
            }),
         
         IT(@"writes the exceptions to its outputter", 
            ^{
              OCSpecDescription *description = [[[OCSpecDescription alloc] init] autorelease];
              description.outputter = GetTemporaryFileHandle();
              
              OCSpecExample *example = [[[OCSpecExample alloc] initWithBlock:^{ FAIL(@"FAIL"); }] autorelease];
              NSArray *tests = [NSArray arrayWithObject: example];
              
              [description describe:@"It Should Do Something" onArrayOfExamples: tests];
              
              NSString *outputException = ReadTemporaryFile();  
              
              if (outputException.length == 0)
              {
                FAIL(@"An exception should have been written to the outputter - but wasn't.");
              }
              
              DeleteTemporaryFile();
            }),
         
         IT(@"has a default ouputter of standard error",
            ^{
              OCSpecDescription *description = [[[OCSpecDescription alloc] init] autorelease];
              
              if (description.outputter != [NSFileHandle fileHandleWithStandardError])
              {
                FAIL(@"Should have had standard error.  Didn't");
              }
            }),
         
         IT(@"can describe multiple examples", 
            ^{
              testDescribeWorksWithMultipleExamples();
            }),
         
         IT(@"can describe multiple successes",
            ^{
              testDescribeWorksWithMultipleSuccesses();
            }),
         );
