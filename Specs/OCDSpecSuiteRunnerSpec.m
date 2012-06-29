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

          it(@"totals the results from multiple classes", ^{
            runner.baseClass = [MultipleMatchingClasses class];

            [FirstMultipleClass setSuccesses: 1 andFailures:3];
            [SecondMultipleClass setSuccesses: 2 andFailures:2];

            [OCDSpecOutputter withRedirectedOutput:^{
              [runner runAllDescriptions];
            }];

            [expect([NSNumber numberWithInt: runner.successes]) toBeEqualTo:[NSNumber numberWithInt: 3]];
            [expect([NSNumber numberWithInt: runner.failures]) toBeEqualTo:[NSNumber numberWithInt: 5]];
          }),

          it(@"reports the results when it is done", ^{
            __block NSString *report;
            runner.baseClass = [AbstractBaseClass class];

            [ValidClass setSuccesses:3 andFailures:4];

            [OCDSpecOutputter withRedirectedOutput:^{
              [runner runAllDescriptions];
              report = [[OCDSpecOutputter sharedOutputter] readOutput];
            }];

            [expect(report) toBeEqualTo:@"Tests ran with 3 passing tests and 4 failing tests\n" ];
          }),
          nil);
}

