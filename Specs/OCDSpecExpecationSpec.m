#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecExpectation.h"
#import "Specs/Mocks/MockObjectWithEquals.h"

CONTEXT(OCDSpecExpectation)
{
    describe(@"The Should object", 
             it(@"delegates beEqualTo to equalTo on the object its holding", 
                ^{
                    MockObjectWithEquals *actualObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    MockObjectWithEquals *expectedObject = [[[MockObjectWithEquals alloc] init] autorelease];

                    OCDSpecExpectation *shouldAh = [[[OCDSpecExpectation alloc] initWithObject:actualObject andLineNumber:0] autorelease];
                    
                    [shouldAh beEqualTo:expectedObject];
                    
                    if (actualObject.expected != expectedObject)
                        FAIL(@"The beEqualTo object did not delegate to the wrapped objects isEqual method");

              }),
             
             it(@"Throws an exception if the two objects are not equal to each other",
                ^{
                    MockObjectWithEquals *actualObject = [[[MockObjectWithEquals alloc] initAsNotEqual] autorelease];
                    MockObjectWithEquals *expectedObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    
                    OCDSpecExpectation *shouldAh = [[[OCDSpecExpectation alloc] initWithObject:actualObject andLineNumber:0] autorelease];
                    
                    @try
                    {
                        [shouldAh beEqualTo:expectedObject];
                        FAIL(@"Code did not throw a failure exception");
                    }
                    @catch (NSException *exception)
                    {
                        if ([exception reason] == @"Code did not throw a failure exception")
                            @throw exception;
                    }
                }),
                        // beEqualTo will need to throw an exception - create a fail object
                        // 
             // [expect(object.blah) toBeEqualTo:object.blah]
           nil);
}