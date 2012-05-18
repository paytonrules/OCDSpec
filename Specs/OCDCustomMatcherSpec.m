#import "OCDSpec/OCDSpec.h"
#import "OCDSpecExpectation+CustomMatcher.h"

CONTEXT(OCDSpecExpectation_CustomMatcherSpec)
{
    describe(@"toEqualABC",
             it(@"fails when the object is not ABC",
                ^{
                    @try
                    {
                        [expect(@"123") toEqualABC];
                        FAIL(@"Code did not throw a failure exception");
                    }
                    @catch (NSException *exception)
                    {
                        [expect([exception reason]) toBeEqualTo: @"Expected ABC, but got 123"];
                    }
                }),
             it(@"passes when the object is ABC",
                ^{
                    [expect(@"ABC") toEqualABC];
                }),
             nil);
}