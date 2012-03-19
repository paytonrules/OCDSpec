#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecOutputter+RedirectOutput.h"
#import "Helpers/ValidClass.h"
#import "Helpers/InvalidClass.h"
#import "Helpers/MultipleMatchingClasses.h"

CONTEXT(OCDSpecSuiteRunner){
  __block OCDSpecSuiteRunner *runner;

  describe(@"Running descriptions",
          beforeEach(^{
            runner = [[OCDSpecSuiteRunner alloc] init];
          }),

          afterEach(^{
            [runner release];
          }),

          it(@"runs classes based on the base class", ^{
            runner.baseClass = [AbstractBaseClass class];

            [OCDSpecOutputter withRedirectedOutput:^{
              [runner runAllDescriptions];
            }];

            expectTruth([ValidClass wasRun]);
          }),

          it(@"runs classes based on the base class", ^{
            runner.baseClass = [AbstractBaseClass class];

            [OCDSpecOutputter withRedirectedOutput:^{
              [runner runAllDescriptions];
            }];

            expectFalse([InvalidClass wasRun]);
          }),

          it(@"increments the results from the returned results", ^{
            runner.baseClass = [AbstractBaseClass class];
            [ValidClass setSuccesses: 2 andFailures: 2];

            [OCDSpecOutputter withRedirectedOutput:^{
              [runner runAllDescriptions];
            }];

            [expect([NSNumber numberWithInt: runner.successes]) toBeEqualTo:[NSNumber numberWithInt: 2]];
            [expect([NSNumber numberWithInt: runner.failures]) toBeEqualTo:[NSNumber numberWithInt: 2]];
          }),

          it(@"totals the results` from multiple classes", ^{
            runner.baseClass = [MultipleMatchingClasses class];

            [FirstMultipleClass setSuccesses: 1 andFailures:3];
            [SecondMultipleClass setSuccesses: 2 andFailures:2];

            [OCDSpecOutputter withRedirectedOutput:^{
              [runner runAllDescriptions];
            }];

            [expect([NSNumber numberWithInt: runner.successes]) toBeEqualTo:[NSNumber numberWithInt: 3]];
            [expect([NSNumber numberWithInt: runner.failures]) toBeEqualTo:[NSNumber numberWithInt: 5]];
          }),
          // Check the reporter.   You are done with the suite.

          // After this you'll want to hit the describe method in OCDSpec DescriptionRunner, only returning results rather than
          // setting a global, adding whats in the context block to the the  class so that [self describe] is actually able to
          // count stuff.
          // Finally add a macro, which might be tricky.
          // This should fix the issue where you are miscounting success/failures.
          // Then see if you can delete the global shared results
          nil);
}

