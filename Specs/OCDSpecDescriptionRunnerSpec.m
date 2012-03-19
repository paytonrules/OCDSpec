#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecOutputter.h"
#import "OCDSpecOutputter+RedirectOutput.h"

static BOOL descriptionWasRun = false;

void testDescription(void)
{
  descriptionWasRun = true;

  [OCDSpecOutputter withRedirectedOutput:^{
    describe(@"MyFakeTest",
            it(@"succeeds", ^{
            }),
            it(@"Fails", ^{
              FAIL(@"FAILURE IN TEST");
            }),
            nil
    );
  }];
}

CONTEXT(OCDSpecDescriptionRunner)
{
  __block OCDSpecDescriptionRunner *runner;
  describe(@"OCDSpecDescriptionRunner",

          beforeEach(^{
            runner = [[[OCDSpecDescriptionRunner alloc] init] autorelease];
          }),

          it(@"runs the passed in C function", ^{
            [runner runContext:testDescription];

            expectTruth(descriptionWasRun);
          }),

          // runDescription
          it(@"returns the results from runDescription", ^{
            OCDSpecSharedResults *results = [runner runContext:testDescription];

            [expect(results.failures) toBeEqualTo:[NSNumber numberWithInt:1]];
            [expect(results.successes) toBeEqualTo:[NSNumber numberWithInt:1]];
          }),

          it(@"stores the results of a describe on itself", ^{
            [runner runDescription: description];


          }),

          // Those will return the global (make the tests not care)
          // self describe needs to get under test to match the describe method
          //
          // After this you'll want to hit the describe method in OCDSpec DescriptionRunner, only returning results rather than
          // setting a global, adding whats in the context block to the the  class so that [self describe] is actually able to
          // count stuff.
          // Finally add a macro, which might be tricky.
          // This should fix the issue where you are miscounting success/failures.
          // Then see if you can delete the global shared results
          nil
  );
}