#import "OCDSpec/OCDSpec.h"

@protocol EmptyProtocol
  
@end

@interface EmptyClass : NSObject<EmptyProtocol>

@end

@implementation EmptyClass

+(void) run
{
}

+(int) getSuccesses
{
  return 0;
}

+(int) getFailures
{
  return 0;
}

@end


CONTEXT(OCDSpecDescriptionRunner)
{
  describe(@"Running descriptions based on a protocol", 
            it(@"Has no successes or failures when the there are no matching protocols", 
               ^{
                 OCDSpecDescriptionRunner *runner = [[[OCDSpecDescriptionRunner alloc] init] autorelease];
                 runner.specProtocol = @protocol(EmptyProtocol);
                 
                 [runner runAllDescriptions];
                  
                 if (runner.failures != 0 || runner.successes != 0)
                   FAIL(@"There were failures or successes, and there shouldn't be");
               }),
           nil);
}