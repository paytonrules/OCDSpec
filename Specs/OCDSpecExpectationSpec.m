#import "OCDSpec/OCDSpec.h"
#import "Specs/Mocks/MockObjectWithEquals.h"

CONTEXT(OCDSpecExpectation)
{
    __block MockObjectWithEquals *actualObject;
    __block MockObjectWithEquals *expectedObject;
    __block OCDSpecExpectation *expectation;
    
    describe(@"The Expectation",
             
             it(@"throws its failures with the line and file passed in", 
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
                    NSObject *innerObject = nil;
                    
                    OCDSpecExpectation *expectation = expect(innerObject);
                    
                    [expect([NSNumber numberWithInt:expectation.line]) toBeEqualTo:[NSNumber numberWithInt: (__LINE__ - 2)]];
                    [expect(expectation.file) toBeEqualTo:[NSString stringWithUTF8String:__FILE__]];
                }),
             nil);
    
    describe(@"toBeEqualTo",
             it(@"passes when two objects are equal",
                ^{
                    actualObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    expectedObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    
                    expectation = [[[OCDSpecExpectation alloc] initWithObject:actualObject inFile:@"" atLineNumber:0] autorelease];
                    
                    [expectation toBeEqualTo:expectedObject];
                }),
             
             it(@"fails if the two objects are not equal using equalTo",
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

             it(@"does not fail if the value is TRUE",
                ^{
                    expectTruth(TRUE);
                }),
             
             it(@"Passes with YES, fails with NO",
                ^{
                    expectTruth(YES);
                    @try
                    {
                        expectTruth(NO);
                        FAIL(@"Did not fail for NO");
                    }
                    @catch (NSException *exception)
                    {
                    }
                }),
             
             it(@"Passes with true, fails with false",
                ^{
                    expectTruth(true);
                    @try
                    {
                        expectTruth(false);
                        FAIL(@"Did not fail for false");
                    }
                    @catch (NSException *exception)
                    {
                    }
                }),
                
             
             nil);
    
    describe(@"expectFalse",
             it(@"fails if the value is truthy",
                ^{
                    @try
                    {
                        expectFalse(YES);
                        FAIL(@"Should have thrown an exception, but didn't");
                    }
                    @catch (NSException *exception)
                    {
                        NSString *expectedReason = [NSString stringWithFormat:@"%b was expected to be false, but was true", FALSE];
                        
                        [expect([exception reason]) toBeEqualTo:expectedReason];
                    }
                }),
             it(@"passes if the value is false",
                ^{
                    expectFalse(false);
                }),
             it(@"passes if the value is NO",
                ^{
                    expectFalse(NO);
                }),
             nil);

}
