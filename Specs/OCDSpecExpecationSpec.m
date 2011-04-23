#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecExpectation.h"
#import "OCDSpec/OCDSpecFail.h"
#import "Specs/Mocks/MockObjectWithEquals.h"

CONTEXT(OCDSpecExpectation)
{
    describe(@"The Should object", 
             it(@"delegates beEqualTo to equalTo on the object its holding", 
                ^{
                    MockObjectWithEquals *actualObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    MockObjectWithEquals *expectedObject = [[[MockObjectWithEquals alloc] init] autorelease];

                    OCDSpecExpectation *shouldAh = [[[OCDSpecExpectation alloc] initWithObject:actualObject inFile:@"" atLineNumber:0] autorelease];
                    
                    [shouldAh beEqualTo:expectedObject];
                    
                    if (actualObject.expected != expectedObject)
                        FAIL(@"The beEqualTo object did not delegate to the wrapped objects isEqual method");

              }),
             
             it(@"Throws a failure exception with an explanatory reason if the two objects are not equal to each other",
                ^{
                    MockObjectWithEquals *actualObject = [[[MockObjectWithEquals alloc] initAsNotEqual] autorelease];
                    MockObjectWithEquals *expectedObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    
                    OCDSpecExpectation *shouldAh = [[[OCDSpecExpectation alloc] initWithObject:actualObject inFile:@"" atLineNumber:0] autorelease];
                    
                    @try
                    {
                        [shouldAh beEqualTo:expectedObject];
                        FAIL(@"Code did not throw a failure exception");
                    }
                    @catch (NSException *exception)
                    {
                        NSString *expectedReason = [NSString stringWithFormat:@"%@ was expected to be equal to %@, and isn't", actualObject, expectedObject];
                        
                        if (![[exception reason]isEqual:expectedReason])
                        {
                            NSString *stringComparison = [NSString stringWithFormat:@"Expected Reason '%@', Actual Reason '%@'", expectedReason, [exception reason]];
                            FAIL(stringComparison);
                        }
                    }
                }),
             
             it(@"Throws a failure with the line and file passed in - i.e. uses OCDSpecFail", 
                ^{
                    MockObjectWithEquals *actualObject = [[[MockObjectWithEquals alloc] initAsNotEqual] autorelease];
                    MockObjectWithEquals *expectedObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    
                    OCDSpecExpectation *shouldAh = [[[OCDSpecExpectation alloc] initWithObject:actualObject inFile:@"FILENAME" atLineNumber:120] autorelease];
                    
                    @try
                    {
                        [shouldAh beEqualTo:expectedObject];
                        FAIL(@"Code did not throw a failure exception");
                    }
                    @catch (NSException *exception)
                    {
                        if (![[[exception userInfo] objectForKey:@"file"]isEqual:@"FILENAME"])
                            FAIL(@"Did not have FILENAME in spec fail");
                        
                        if (![[[exception userInfo] objectForKey:@"line"] isEqual:[NSNumber numberWithLong:120]])
                            FAIL(@"Should have had line number 120, didn't");
                    }
                    
                }),
                                // beEqualTo will need to throw an exception - create a fail object
                        // 
             // [expect(object.blah) toBeEqualTo:object.blah]
           nil);
}