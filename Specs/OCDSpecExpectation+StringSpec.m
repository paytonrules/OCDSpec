#import "OCDSpec/OCDSpec.h"
#import "OCDSpecExpectation+NSString.h"

CONTEXT(OCDSpecExpectation_NSStringSpec)
{
    describe(@"toBeEmpty",
             it(@"passes when empty",
                ^{
                    [expect(@"") toBeEmptyString];
                }),
             it(@"fails when not empty",
                ^{
                    @try
                    {
                        [expect(@"Hello World") toBeEmptyString];
                        FAIL(@"Expected a failure but got none");
                    }
                    @catch (NSException *exception)
                    {
                        NSString *expectedReason = [NSString stringWithFormat:@"Expected empty string, but got \"Hello World\""];
                        [expect([exception reason]) toBeEqualTo:expectedReason];
                    }
                }),
             nil);
}