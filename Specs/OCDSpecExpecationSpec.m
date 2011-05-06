#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecFail.h"
#import "Specs/Mocks/MockObjectWithEquals.h"

CONTEXT(OCDSpecExpectation)
{
    __block MockObjectWithEquals *actualObject;
    __block MockObjectWithEquals *expectedObject;
    __block OCDSpecExpectation *expectation;
    
    describe(@"The Expectation",
             it(@"delegates beEqualTo to equalTo on the object its holding", 
                ^{
                    actualObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    expectedObject = [[[MockObjectWithEquals alloc] init] autorelease];

                    expectation = [[[OCDSpecExpectation alloc] initWithObject:actualObject inFile:@"" atLineNumber:0] autorelease];
                    
                    [expectation toBeEqualTo:expectedObject];
                    
                    [expect(actualObject) toBeEqualTo:expectedObject];
              }),
             
             it(@"throws a failure when the objects aren't equal with an explanatory reason if matcher fails",
                ^{
                    actualObject = [[[MockObjectWithEquals alloc] initAsNotEqual] autorelease];
                    expectedObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    
                    expectation = [[[OCDSpecExpectation alloc] initWithObject:actualObject inFile:@"" atLineNumber:0] autorelease];
                    
                    @try
                    {
                        [expectation toBeEqualTo:expectedObject];
                        FAIL(@"Code did not throw a failure exception");
                    }
                    @catch (NSException *exception)
                    {
                        NSString *expectedReason = [NSString stringWithFormat:@"%@ was expected to be equal to %@, and isn't", actualObject, expectedObject];
                        
                        [expect([exception reason]) toBeEqualTo:expectedReason];
                    }
                }),
             
             it(@"throws a failure with the line and file passed in - i.e. uses OCDSpecFail", 
                ^{
                    actualObject = [[[MockObjectWithEquals alloc] initAsNotEqual] autorelease];
                    expectedObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    
                    OCDSpecExpectation *expectation = [[[OCDSpecExpectation alloc] initWithObject:actualObject inFile:@"FILENAME" atLineNumber:120] autorelease];
                    
                    @try
                    {
                        [expectation toBeEqualTo:expectedObject];
                        FAIL(@"Code did not throw a failure exception");
                    }
                    @catch (NSException *exception)
                    {
                        [expect([[exception userInfo] objectForKey:@"file"]) toBeEqualTo:@"FILENAME"];
                        [expect([[exception userInfo] objectForKey:@"line"]) toBeEqualTo:[NSNumber numberWithLong:120]];
                    }
                    
                }),
             
             it(@"Is created helpfully by the expect macro",
                ^{
                    NSObject *innerObject;
                    
                    OCDSpecExpectation *expectation = expect(innerObject);
                    
                    if (expectation.line != __LINE__ -2)
                        FAIL(@"Line Number is wrong");
                    
                    [expect(expectation.file) toBeEqualTo:[NSString stringWithUTF8String:__FILE__]];
                }),
           nil);

    describe(@"toBe", 
             it(@"fails if two objects are not the same object",
                ^{
                    actualObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    expectedObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    
                    @try
                    {
                        [expect(actualObject) toBe: expectedObject];
                        FAIL(@"Should have thrown an exception, but didn't");
                    }
                    @catch (NSException *exception)
                    {
                        NSString *expectedReason = [NSString stringWithFormat:@"%@ was expected to be the same object as %@, but wasn't", actualObject, expectedObject];
                        
                        [expect([exception reason]) toBeEqualTo:expectedReason];
                    }
                }),
             
             it(@"does not fail if the two objects are the same",
                ^{
                    actualObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    
                    [expect(actualObject) toBe: actualObject];
                }),
             
             nil);
    
    describe(@"toBeTrue",
             it(@"fails if the value is not truthy",
                ^{
                    @try
                    {
                        expectTruth(FALSE);
                        FAIL(@"Should have thrown an exception, but didn't");
                    }
                    @catch (NSException *exception)
                    {
                        NSString *expectedReason = [NSString stringWithFormat:@"%b was expected to be true, but was false", FALSE];
                        
                        [expect([exception reason]) toBeEqualTo:expectedReason];
                    }
                }),
             
             nil);
}