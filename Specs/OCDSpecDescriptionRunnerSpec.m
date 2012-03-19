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

void testContextWithTwoDescribes(void)
{
  [OCDSpecOutputter withRedirectedOutput:^{
    describe(@"MyFakeTest",
            it(@"succeeds", ^{
            }),
            it(@"Fails", ^{
              FAIL(@"FAILURE IN TEST");
            }),
            nil
    );

    describe(@"Empty Description", nil);
  }];
}

@interface FakeDescription : OCDSpecDescription
{
  bool wasRun;
}

@property(assign) bool wasRun;
@end

@implementation FakeDescription
@synthesize wasRun;

-(void) describe
{
  wasRun = true;
}
@end

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

          it(@"returns the results from runContext", ^{
            OCDSpecSharedResults *results = [runner runContext:testDescription];

            [expect(results.failures) toBeEqualTo:[NSNumber numberWithInt:1]];
            [expect(results.successes) toBeEqualTo:[NSNumber numberWithInt:1]];
          }),

          it(@"Runs an individual description", ^{
            FakeDescription *desc = [[[FakeDescription alloc] init]  autorelease];
            desc.wasRun = false;

            [runner runDescription: desc];

            expectTruth(desc.wasRun);
          }),

          it(@"stores the results of a description on itself", ^{
            OCDSpecDescription *description = [[[OCDSpecDescription alloc] init] autorelease];
            description.failures = [NSNumber numberWithInt: 8 ];
            description.successes = [NSNumber numberWithInt: 6 ];

            [runner runDescription: description];

            [expect(runner.failures) toBeEqualTo:[NSNumber numberWithInt:8] ];
            [expect(runner.successes) toBeEqualTo:[NSNumber numberWithInt:6] ];
          }),

          it(@"Totals up the runDescriptions on multiple runs", ^{
            OCDSpecDescription *descriptionOne = [[[OCDSpecDescription alloc] init] autorelease];
            descriptionOne.failures = [NSNumber numberWithInt: 8 ];
            descriptionOne.successes = [NSNumber numberWithInt: 1 ];
            OCDSpecDescription *descriptionTwo = [[[OCDSpecDescription alloc] init] autorelease];
            descriptionTwo.successes = [NSNumber numberWithInt: 8 ];

            [runner runDescription: descriptionOne];
            [runner runDescription: descriptionTwo];

            [expect(runner.failures) toBeEqualTo:[NSNumber numberWithInt:8] ];
            [expect(runner.successes) toBeEqualTo:[NSNumber numberWithInt:9] ];
          }),

          it(@"Does not overwrite counts when two describes are nested in a context", ^{
            OCDSpecSharedResults *results = [runner runContext:testContextWithTwoDescribes];

            [expect(results.failures) toBeEqualTo:[NSNumber numberWithInt:1]];
            [expect(results.successes) toBeEqualTo:[NSNumber numberWithInt:1]];
          }),


          // Finally add a currentContext so you can use the describe function
          // This should fix the issue where you are miscounting success/failures.
          // Replace global shared results with a struct
          // Get describe method in the OCDSpecDescription method working
          // Look around for stray tests.  beforeEach, describe, you've got some stuff out there nowhere near the right spots.
          nil
  );
}