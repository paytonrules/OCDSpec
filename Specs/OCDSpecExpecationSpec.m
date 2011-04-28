#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecExpectation.h"
#import "OCDSpec/OCDSpecFail.h"
#import "Specs/Mocks/MockObjectWithEquals.h"

CONTEXT(OCDSpecExpectation)
{
    __block MockObjectWithEquals *actualObject;
    __block MockObjectWithEquals *expectedObject;
    __block OCDSpecExpectation *expectation;
    
    describe(@"The Expecation",                    
             it(@"delegates beEqualTo to equalTo on the object its holding", 
                ^{
                    actualObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    expectedObject = [[[MockObjectWithEquals alloc] init] autorelease];

                    expectation = [[[OCDSpecExpectation alloc] initWithObject:actualObject inFile:@"" atLineNumber:0] autorelease];
                    
                    [expectation toBeEqualTo:expectedObject];
                    
                    [expect(actualObject) toBeEqualTo:expectedObject];

              }),
             
             it(@"throws a failure when the objects aren't equal with an explanatory reason if the two objects are not equal to each other",
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
                    
                    expectation = [[[OCDSpecExpectation alloc] initWithObject:actualObject inFile:@"FILENAME" atLineNumber:120] autorelease];
                    
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
                    
                    expectation = expect(innerObject);
                    
                    if (expectation.line != __LINE__ -2)
                        FAIL(@"Line Number is wrong");
                    
                    [expect(expectation.file) toBeEqualTo:[NSString stringWithUTF8String:__FILE__]];
                }),
           nil);
}