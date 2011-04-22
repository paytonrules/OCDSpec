#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecShouldObject.h"
#import "Specs/Mocks/MockObjectWithEquals.h"

CONTEXT(OCDSpecShouldObject)
{
    describe(@"The Should object", 
             it(@"delegates beEqualTo to equalTo on the object its holding", 
                ^{
                    MockObjectWithEquals *genericObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    MockObjectWithEquals *secondObject = [[[MockObjectWithEquals alloc] init] autorelease];

                    OCDSpecShouldObject *shouldAh = [[[OCDSpecShouldObject alloc] initWithObject:genericObject andLineNumber:0] autorelease];
                    
                    [shouldAh beEqualTo:secondObject];
                    
                    if (genericObject.expected != secondObject)
                        FAIL(@"The beEqualTo object did not delegate to the wrapped objects isEqual method");

              }),
                        // beEqualTo will need to throw an exception - create a fail object
                        // 
             // [expect(object.blah) toBeEqualTo:object.blah]
           nil);
}