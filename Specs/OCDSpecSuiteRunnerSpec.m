#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecOutputter+RedirectOutput.h"

static bool validClassWasRun = false;
static bool inValidClassWasRun = false;

@interface AbstractBaseClass : NSObject <DescriptionRunner>
@end

@implementation AbstractBaseClass
@end

@interface ValidClass : AbstractBaseClass
@end

@implementation ValidClass
static int validClassSuccesses = 0;
static int validClassFailures = 0;

+(void) setSuccesses: (int) successes andFailures: (int) failures
{
  validClassSuccesses = successes;
  validClassFailures = successes;
}

+ (OCDSpecSharedResults *)run
{
  OCDSpecSharedResults *results = [[[OCDSpecSharedResults alloc] init] autorelease];
  results.failures = [NSNumber numberWithInt:validClassFailures];
  results.successes = [NSNumber numberWithInt:validClassFailures];
  validClassWasRun = true;
  return results;

}

+ (bool)wasRun
{
  return validClassWasRun;
}

@end

@interface InvalidClass : NSObject
@end

@implementation InvalidClass

+ (OCDSpecSharedResults *)run
{
  inValidClassWasRun = true;
}

+ (bool)wasRun
{
  return inValidClassWasRun;
}

@end

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
          }),

          it(@"", <#(void (^)())example#>)
          // Counting more than one description
          nil);
}

