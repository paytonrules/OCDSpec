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

+ (void)run
{
  validClassWasRun = true;
}

+ (bool)wasRun
{
  return validClassWasRun;
}

+ (int)getSuccesses
{
  return 0;
}

+ (int)getFailures
{
  return 0;
}
@end

@interface InvalidClass : NSObject
@end

@implementation InvalidClass

+ (void)run
{
  inValidClassWasRun = true;
}

+ (bool)wasRun
{
  return inValidClassWasRun;
}

@end

CONTEXT(OCDSpecDescriptionRunner){
  __block OCDSpecDescriptionRunner *runner;

  describe(@"Running descriptions",
          beforeEach(^{
             runner = [[OCDSpecDescriptionRunner alloc] init];
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
          // Counting
          // Cleanup - I don't know what this means
          nil);
}

