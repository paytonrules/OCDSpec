#import "OCDSpec/OCDSpecDescriptionRunner.h"
#import "OCDSpec/OCDSpecFail.h"
#import "OCDSpec/OCDSpecExample.h"
#import "OCDSpec/OCDSpecOutputter+RedirectOutput.h"
#import "OCDSpecExpectation.h"

CONTEXT(OCDSpecExample)
{
    describe(@"Standard Failures",
             it(@"Should Fail One Test",
                ^{
                    BOOL caughtFailure = NO;
                    @try
                    {
                        FAIL(@"You have failed");
                    }
                    @catch (NSException * e)
                    {
                        caughtFailure = YES;
                    }

                    [expect([NSNumber numberWithBool:caughtFailure]) toBeEqualTo:[NSNumber numberWithBool:YES]];
                }),

             it(@"Should Pass An empty Test",
                ^{
                }),
             
             it(@"writes its exceptions to the outputter",
                ^{
                    OCDSpecExample *example = [[[OCDSpecExample alloc] initWithBlock:^{ FAIL(@"FAIL"); }] autorelease];
                    
                    __block NSString *outputException;
                    [OCDSpecOutputter withRedirectedOutput: ^{
                        [example run];
                        
                        outputException = [[OCDSpecOutputter sharedOutputter] readOutput];
                    }];
                    
                    if (outputException.length == 0)
                    {
                        FAIL(@"An exception should have been written to the outputter - but wasn't.");
                    }
                }),
 
             it(@"Examples write their output in a XCode friendly format",
                ^{
                    int outputLine = __LINE__ + 1;
                    OCDSpecExample *example = [[[OCDSpecExample alloc] initWithBlock:^{ FAIL(@"FAIL"); }] autorelease];
                    __block NSString *outputException;
                    [OCDSpecOutputter withRedirectedOutput: ^{
                        [example run];
                        
                        outputException = [[OCDSpecOutputter sharedOutputter] readOutput];
                    }];
                    
                    NSString *errorFormat = [NSString stringWithFormat:@"%s:%ld: error: %@\n",
                                             __FILE__,
                                             outputLine,
                                             @"FAIL"];
                    
                    // This is a string match assertion :)
                    if ([outputException compare:errorFormat] != 0)
                    {
                        NSString *failMessage = [NSString stringWithFormat:@"%@ expected, received %@", errorFormat, outputException];
                        FAIL(failMessage);
                    }
                    
                }),
             nil
             );
}
