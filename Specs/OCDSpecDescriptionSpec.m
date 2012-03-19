#import "OCDSpec/OCDSpec.h"
#import "Specs/Mocks/MockExample.h"
#import "OCDSpec/OCDSpecOutputter+RedirectOutput.h"

CONTEXT(OCDSpecDescription){
  describe(@"The Description",
          it(@"describes one example without errors", ^{
            OCDSpecDescription *description = [[[OCDSpecDescription alloc] init] autorelease];

            [description describe:@"It Should Do Something" onArrayOfExamples:[[[NSArray alloc] init] autorelease]];

            [expect(description.failures) toBeEqualTo:[NSNumber numberWithInt:0]];
          }),

          it(@"describes an example with one error", ^{
            OCDSpecDescription *description = [[[OCDSpecDescription alloc] init] autorelease];
            OCDSpecOutputter *outputter = [OCDSpecOutputter sharedOutputter];
            outputter.fileHandle = [NSFileHandle fileHandleWithNullDevice];

            MockExample *example = [MockExample exampleThatFailed];
            NSArray *examples = [NSArray arrayWithObjects:example, nil];

            [description describe:@"It Should Do Something" onArrayOfExamples:examples];

            outputter.fileHandle = [NSFileHandle fileHandleWithStandardError];

            [expect(description.failures) toBeEqualTo:[NSNumber numberWithInt:1]];
          }),

          it(@"writes the exceptions to the shared outputter", ^{
            OCDSpecDescription *description = [[[OCDSpecDescription alloc] init] autorelease];
            __block NSString *outputException;
            [OCDSpecOutputter withRedirectedOutput:^{
              OCDSpecExample *example = [[[OCDSpecExample alloc] initWithBlock:^{
                FAIL(@"FAIL");
              }] autorelease];
              NSArray *tests = [NSArray arrayWithObject:example];

              [description describe:@"It Should Do Something" onArrayOfExamples:tests];

              outputException = [[OCDSpecOutputter sharedOutputter] readOutput];
            }];

            if (outputException.length == 0)
            {
              FAIL(@"An exception should have been written to the outputter - but wasn't.");
            }
          }),

          it(@"can describe multiple examples", ^{
            OCDSpecDescription *description = [[[OCDSpecDescription alloc] init] autorelease];
            OCDSpecOutputter *outputter = [OCDSpecOutputter sharedOutputter];
            outputter.fileHandle = [NSFileHandle fileHandleWithNullDevice];

            OCDSpecExample *exampleOne = [[[OCDSpecExample alloc] initWithBlock:^{
              FAIL(@"Fail One");
            }] autorelease];
            OCDSpecExample *exampleTwo = [[[OCDSpecExample alloc] initWithBlock:^{
              FAIL(@"Fail Two");
            }] autorelease];

            NSArray *tests = [NSArray arrayWithObjects:exampleOne, exampleTwo, nil];

            [description describe:@"It Should Do Something" onArrayOfExamples:tests];

            outputter.fileHandle = [NSFileHandle fileHandleWithStandardError];

            [expect(description.failures) toBeEqualTo:[NSNumber numberWithInt:2]];
          }),

          it(@"can describe multiple successes", ^{
            OCDSpecDescription *description = [[[OCDSpecDescription alloc] init] autorelease];
            OCDSpecOutputter *outputter = [OCDSpecOutputter sharedOutputter];
            outputter.fileHandle = [NSFileHandle fileHandleWithNullDevice];

            OCDSpecExample *exampleOne = [[[OCDSpecExample alloc] initWithBlock:^{
            }] autorelease];
            OCDSpecExample *exampleTwo = [[[OCDSpecExample alloc] initWithBlock:^{
            }] autorelease];

            NSArray *tests = [NSArray arrayWithObjects:exampleOne, exampleTwo, nil];

            [description describe:@"It Should Do Something" onArrayOfExamples:tests];

            outputter.fileHandle = [NSFileHandle fileHandleWithStandardError];

            [expect(description.successes) toBeEqualTo:[NSNumber numberWithInt:2]];
          }),

          it(@"Will still run the postcondition even if the example throws an exception", ^{
            __block bool calledPost = NO;

            OCDSpecExample *exampleGoBoom = [[[OCDSpecExample alloc] initWithBlock:
                    ^{
                      [NSException raise:@"OH NO" format:@"This is a test exception"];
                    }] autorelease];

            NSArray *tests = [NSArray arrayWithObject:exampleGoBoom];

            OCDSpecDescription *desc = [[OCDSpecDescription alloc] initWithName:@"test"
                                                                       examples:tests];

            [desc autorelease];

            desc.postcondition = ^{
              calledPost = YES;
            };

            [OCDSpecOutputter withRedirectedOutput:^{
              [desc describe];
            }];

            [expect([NSNumber numberWithBool:calledPost]) toBeEqualTo:[NSNumber numberWithBool:YES]];
          }),

          nil
  );
}



CONTEXT(DescribeMethodWithBeforeAndAfter){
  __block int beforeCounter = 0;
  __block int afterCounter = 0;

  describe(@"The before each on describe",
          beforeEach(^{
            beforeCounter++;
          }),

          afterEach(^{
            afterCounter++;
          }),

          it(@"calls before each before the example", ^{
            [expect([NSNumber numberWithInteger:beforeCounter]) toBeEqualTo:[NSNumber numberWithInt:1]];
          }),

          it(@"calls after each after each example", ^{
            [expect([NSNumber numberWithInteger:afterCounter]) toBeEqualTo:[NSNumber numberWithInt:1]];
          }),
          nil
  );
}
