#import "OCDSpec/OCDSpec.h"

@protocol EmptyProtocol
  
@end

@interface EmptyClass : NSObject<EmptyProtocol>

@end

CONTEXT(OCDSpecDescriptionRunner)
{
  describe(@"Running descriptions based on a protocol", 
            it(@"Has no successes or failures when the there are no matching protocols", 
               ^{
                 OCDSpecDescriptionRunner *runner = [[[OCDSpecDescriptionRunner alloc] init] autorelease];
                 runner.specProtocol = @protocol(EmptyProtocol);
                 
                 [runner runAllDescriptions];
                 
                 FAIL(@"This should fail cause the EmptyClass class doesn't have a run method, but isn't casue it's a dick");
                 
                 if (runner.failures != 0 || runner.successes != 0)
                   FAIL(@"There were failures or successes, and there shouldn't be");
               }),
           nil);
}