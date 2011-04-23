#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecExpectation.h"
#import "OCDSpec/OCDSpecFail.h"
#import "Specs/Mocks/MockObjectWithEquals.h"

CONTEXT(OCDSpecExpectation)
{
    describe(@"The Expecation",
             it(@"delegates beEqualTo to equalTo on the object its holding", 
                ^{
                    MockObjectWithEquals *actualObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    MockObjectWithEquals *expectedObject = [[[MockObjectWithEquals alloc] init] autorelease];

                    OCDSpecExpectation *expectation = [[[OCDSpecExpectation alloc] initWithObject:actualObject inFile:@"" atLineNumber:0] autorelease];
                    
                    [expectation toBeEqualTo:expectedObject];
                    
                    [expect(actualObject) toBeEqualTo:expectedObject];

              }),
             
             it(@"throws a failure when the objects aren't equal with an explanatory reason if the two objects are not equal to each other",
                ^{
                    MockObjectWithEquals *actualObject = [[[MockObjectWithEquals alloc] initAsNotEqual] autorelease];
                    MockObjectWithEquals *expectedObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    
                    OCDSpecExpectation *expectation = [[[OCDSpecExpectation alloc] initWithObject:actualObject inFile:@"" atLineNumber:0] autorelease];
                    
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
                    MockObjectWithEquals *actualObject = [[[MockObjectWithEquals alloc] initAsNotEqual] autorelease];
                    MockObjectWithEquals *expectedObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    
                    OCDSpecExpectation *expectation = [[[OCDSpecExpectation alloc] initWithObject:actualObject inFile:@"FILENAME" atLineNumber:120] autorelease];
                    
                    @try
                    {
                        [expectation toBeEqualTo:expectedObject];
                        FAIL(@"Code did not throw a failure exception");
                    }
                    @catch (NSException *exception)
                    {
                        [expect([[exception userInfo] objectForKey:@"file"]) toBeEqualTo:@"FILENAME"];
                        
                        if (![[[exception userInfo] objectForKey:@"line"] isEqual:[NSNumber numberWithLong:120]])
                            FAIL(@"Should have had line number 120, didn't");
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
                
             // [expect(object.blah) toBeEqualTo:object.blah]
           nil);
}