#import "OCDSpec/OCDSpec.h"
#import "Specs/Mocks/MockExample.h"
#import "OCDSpec/OCDSpecOutputter+RedirectOutput.h"
#import "OCDSpec/OCDSpecDescription.h"

CONTEXT(OCDSpecDescription){
  __block OCDSpecDescription *description;
  __block OCDSpecOutputter *outputter;

  describe(@"The Description",

          beforeEach(^{
            description = [[OCDSpecDescription alloc] init];
            outputter = [OCDSpecOutputter sharedOutputter];
            outputter.fileHandle = [NSFileHandle fileHandleWithNullDevice];
          }),

          afterEach(^{
            outputter.fileHandle = [NSFileHandle fileHandleWithStandardError];
          }),

          it(@"describes one example without errors", ^{
            [description describe:@"It Should Do Something" onArrayOfExamples:[[NSArray alloc] init]];

            [expect(description.failures) toBeEqualTo:[NSNumber numberWithInt:0]];
          }),

          it(@"describes an example with one error", ^{
            MockExample *example = [MockExample newExampleThatFailed];
            NSArray *examples = [NSArray arrayWithObjects:example, nil];

            [description describe:@"It Should Do Something" onArrayOfExamples:examples];

            [expect(description.failures) toBeEqualTo:[NSNumber numberWithInt:1]];
          }),

          it(@"writes the exceptions to the shared outputter", ^{
            __block NSString *outputException;
            [OCDSpecOutputter withRedirectedOutput:^{
              OCDSpecExample *example = [[OCDSpecExample alloc] initWithBlock:^{
                FAIL(@"FAIL");
              }];
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
            OCDSpecExample *exampleOne = [[OCDSpecExample alloc] initWithBlock:^{
              FAIL(@"Fail One");
            }];
            OCDSpecExample *exampleTwo = [[OCDSpecExample alloc] initWithBlock:^{
              FAIL(@"Fail Two");
            }];

            NSArray *tests = [NSArray arrayWithObjects:exampleOne, exampleTwo, nil];

            [description describe:@"It Should Do Something" onArrayOfExamples:tests];

            [expect(description.failures) toBeEqualTo:[NSNumber numberWithInt:2]];
          }),

          it(@"can describe multiple successes", ^{
            OCDSpecExample *exampleOne = [[OCDSpecExample alloc] initWithBlock:^{
            }];
            OCDSpecExample *exampleTwo = [[OCDSpecExample alloc] initWithBlock:^{
            }];

            NSArray *tests = [NSArray arrayWithObjects:exampleOne, exampleTwo, nil];

            [description describe:@"It Should Do Something" onArrayOfExamples:tests];

            [expect(description.successes) toBeEqualTo:[NSNumber numberWithInt:2]];
          }),

          it(@"runs a precondition before each example", ^{
            __block NSMutableArray *callsMade = [[NSMutableArray alloc] init];

            OCDSpecExample *exampleOne = [[OCDSpecExample alloc] initWithBlock:^{
              [callsMade addObject:@"Ran First Example"];
            }];
            OCDSpecExample *exampleTwo = [[OCDSpecExample alloc] initWithBlock:^{
              [callsMade addObject:@"Ran Second Example"];
            }];

            NSArray *tests = [NSArray arrayWithObjects:exampleOne, exampleTwo, nil];

            OCDSpecDescription *description = [[OCDSpecDescription alloc] initWithName:@"Something" examples:tests];
            description.precondition = ^{
              [callsMade addObject:@"Precondition Called"];
            };
            [description describe];

            [expect(callsMade) toBeEqualTo:[NSArray arrayWithObjects:@"Precondition Called",
                                                                     @"Ran First Example",
                                                                     @"Precondition Called",
                                                                     @"Ran Second Example",
                                                                     nil ]];
          }),

          it(@"runs a postcondition after each example", ^{
            __block NSMutableArray *callsMade = [[NSMutableArray alloc] init];

            OCDSpecExample *exampleOne = [[OCDSpecExample alloc] initWithBlock:^{
              [callsMade addObject:@"Ran First Example"];
            }];
            OCDSpecExample *exampleTwo = [[OCDSpecExample alloc] initWithBlock:^{
              [callsMade addObject:@"Ran Second Example"];
            }];

            NSArray *tests = [NSArray arrayWithObjects:exampleOne, exampleTwo, nil];

            OCDSpecDescription *description = [[OCDSpecDescription alloc] initWithName:@"Something" examples:tests];
            description.postcondition = ^{
              [callsMade addObject:@"Postcondition Called"];
            };
            [description describe];

            [expect(callsMade) toBeEqualTo:[NSArray arrayWithObjects:@"Ran First Example",
                                                                     @"Postcondition Called",
                                                                     @"Ran Second Example",
                                                                     @"Postcondition Called",
                                                                     nil]];
          }),

          it(@"Will still run the postcondition even if the example throws an exception", ^{
            __block bool calledPost = NO;

            OCDSpecExample *exampleGoBoom = [[OCDSpecExample alloc] initWithBlock:^{
              [NSException raise:@"OH NO" format:@"This is a test exception"];
            }];

            NSArray *tests = [NSArray arrayWithObject:exampleGoBoom];

            OCDSpecDescription *desc = [[OCDSpecDescription alloc] initWithName:@"test"
                                                                       examples:tests];

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