#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecOutputter+RedirectOutput.h"

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
                    
                    [OCDSpecOutputter withRedirectedOutput: ^{
                        [runner runAllDescriptions];
                    }];
                   
                    [expect([NSNumber numberWithInt:runner.failures]) toBeEqualTo:[NSNumber numberWithInt:0]];
                    [expect([NSNumber numberWithInt:runner.successes]) toBeEqualTo:[NSNumber numberWithInt:0]];
               }),
           nil);
}