#import "OCDSpec/OCDSpec.h"
#import "Specs/Mocks/MockExample.h"
#import "OCDSpec/OCDSpecOutputter+RedirectOutput.h"

CONTEXT(OCDSpecDescription)
{
    describe(@"The Description",
             it(@"describes one example without errors",
                ^{
                    OCDSpecDescription *description = [[[OCDSpecDescription alloc] init] autorelease];
                    
                    [description describe:@"It Should Do Something" onArrayOfExamples: [[[NSArray alloc] init] autorelease]];
                    
                    [expect(description.failures) toBeEqualTo:[NSNumber numberWithInt:0]];
                }),
             
             it(@"describes an example with one error",
                ^{
                    OCDSpecDescription *description = [[[OCDSpecDescription alloc] init] autorelease];
                    OCDSpecOutputter *outputter = [OCDSpecOutputter sharedOutputter];
                    outputter.fileHandle = [NSFileHandle fileHandleWithNullDevice];
                    
                    MockExample *example = [MockExample exampleThatFailed];  
                    NSArray *examples = [NSArray arrayWithObjects:example, nil];
                    
                    [description describe:@"It Should Do Something" onArrayOfExamples: examples];
                    
                    outputter.fileHandle = [NSFileHandle fileHandleWithStandardError];
                    
                    [expect(description.failures) toBeEqualTo:[NSNumber numberWithInt:1]];
                }),
             
             it(@"writes the exceptions to the shared outputter", 
                ^{
                    OCDSpecDescription *description = [[[OCDSpecDescription alloc] init] autorelease];
                    __block NSString *outputException;
                    [OCDSpecOutputter withRedirectedOutput:^{
                        OCDSpecExample *example = [[[OCDSpecExample alloc] initWithBlock:^{ FAIL(@"FAIL"); }] autorelease];
                        NSArray *tests = [NSArray arrayWithObject: example];
                        
                        [description describe:@"It Should Do Something" onArrayOfExamples: tests];
                        
                        outputException = [[OCDSpecOutputter sharedOutputter] readOutput];;
                    }];
                    
                    if (outputException.length == 0)
                    {
                        FAIL(@"An exception should have been written to the outputter - but wasn't.");
                    }
                }),
             
             it(@"can describe multiple examples", 
                ^{
                    OCDSpecDescription *description = [[[OCDSpecDescription alloc] init] autorelease];
                    OCDSpecOutputter *outputter = [OCDSpecOutputter sharedOutputter];
                    outputter.fileHandle = [NSFileHandle fileHandleWithNullDevice];
                    
                    OCDSpecExample *exampleOne = [[[OCDSpecExample alloc] initWithBlock: ^{ FAIL(@"Fail One"); }] autorelease];
                    OCDSpecExample *exampleTwo = [[[OCDSpecExample alloc] initWithBlock: ^{ FAIL(@"Fail Two"); }] autorelease];
                    
                    NSArray *tests = [NSArray arrayWithObjects:exampleOne, exampleTwo, nil];
                    
                    [description describe:@"It Should Do Something" onArrayOfExamples: tests];
                    
                    outputter.fileHandle = [NSFileHandle fileHandleWithStandardError];
                    
                    [expect(description.failures) toBeEqualTo:[NSNumber numberWithInt:2]];
                }),
             
             it(@"can describe multiple successes",
                ^{
                    OCDSpecDescription *description = [[[OCDSpecDescription alloc] init] autorelease];
                    OCDSpecOutputter *outputter = [OCDSpecOutputter sharedOutputter];
                    outputter.fileHandle = [NSFileHandle fileHandleWithNullDevice];
                    
                    OCDSpecExample *exampleOne = [[[OCDSpecExample alloc] initWithBlock: ^{ }] autorelease];
                    OCDSpecExample *exampleTwo = [[[OCDSpecExample alloc] initWithBlock: ^{ }] autorelease];
                    
                    NSArray *tests = [NSArray arrayWithObjects:exampleOne, exampleTwo, nil];
                    
                    [description describe:@"It Should Do Something" onArrayOfExamples: tests];
                    
                    outputter.fileHandle = [NSFileHandle fileHandleWithStandardError];
                    
                    [expect(description.successes) toBeEqualTo:[NSNumber numberWithInt:2]];
                }),
             nil
             );
}

CONTEXT(DescribeMethod)
{
    describe(@"The describe helper method", 
             it(@"has no shared results changes on a nil list", 
                ^{
                    describe(@"Empty List", nil);
                    
                    OCDSpecSharedResults *sharedResults = [OCDSpecSharedResults sharedResults];
                    OCDSpecSharedResults *expectedResults = [[[OCDSpecSharedResults alloc] init] autorelease];
                    
                    [expect(sharedResults) toBeEqualTo: expectedResults];
                }),
             
             it(@"has one failure on a list with one failure",
                ^{
                    [OCDSpecOutputter withRedirectedOutput:
                     ^{
                         describe(@"one failure",
                                  it(@"Failure", 
                                     ^{
                                         FAIL(@"FAIL");
                                     }),
                                  nil);
                     }];
                    
                    [expect([OCDSpecSharedResults sharedResults].failures) toBeEqualTo:[NSNumber numberWithInt:1]];
                }),
             
             it(@"has one success on a list with one success", 
                ^{
                    [OCDSpecOutputter withRedirectedOutput:
                     ^{
                         describe(@"one success",
                                  it(@"Succeeds", 
                                     ^{
                                     }),
                                  nil);
                     }];
                    
                    [expect([OCDSpecSharedResults sharedResults].successes) toBeEqualTo:[NSNumber numberWithInt:1]];
                }),
             
             nil
             );
}
