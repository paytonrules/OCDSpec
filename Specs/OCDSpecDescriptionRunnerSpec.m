#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecOutputter+RedirectOutput.h"

static bool validClassWasRun = false;

@interface AbstractBaseClass : NSObject<DescriptionRunner>
@end

@implementation AbstractBaseClass
@end

@interface ValidClass : AbstractBaseClass
@end

@implementation ValidClass

+(void) run
{
  validClassWasRun = true;
}

+(bool) wasRun
{
  return validClassWasRun;
}

+(int) getSuccesses
{
  return 0;
}
+(int)getFailures
{
  return 0;
}
@end

CONTEXT(OCDSpecDescriptionRunner){
  describe(@"Running descriptions",
          it(@"it runs classes based on the base class", ^{
            OCDSpecDescriptionRunner *runner = [[[OCDSpecDescriptionRunner alloc] init] autorelease];
            runner.baseClass = [AbstractBaseClass class];
            [OCDSpecOutputter withRedirectedOutput:^{
              [runner runAllDescriptions];
            }];

            expectTruth([ValidClass wasRun]);
          }),

          // Doesn't run other classes
          // Counting
          // Cleanup
          nil);
}

