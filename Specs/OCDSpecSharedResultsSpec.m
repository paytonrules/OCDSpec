#import "OCDSpec/OCDSpec.h"

// I don't care for this class, but I need to communicate from a C function back to a macro.
CONTEXT(OCDSpecSharedResults)
{
    describe(@"The Singleton Shared Results",
             it(@"returns the same instance each time", 
                ^{
                    OCDSpecSharedResults *resultsOne = [OCDSpecSharedResults sharedResults];
                    OCDSpecSharedResults *resultsTwo = [OCDSpecSharedResults sharedResults];
                    
                    [expect(resultsOne) toBe:resultsTwo];
               }),
               /*
               THESE ARE SILLY TESTS.  When you remove the crash problem make a better test around using the shared results.
             it(@"Has a number of failures", 
                ^{
                    OCDSpecSharedResults *results = [OCDSpecSharedResults sharedResults];
                    results.failures = [NSNumber numberWithInt:2];
                
                    OCDSpecSharedResults *newResults = [OCDSpecSharedResults sharedResults];
                    
                    [expect(newResults.failures) toBeEqualTo:[NSNumber numberWithInt:2]];
                }),
             
             it(@"Has a number of successes",
                ^{
                    OCDSpecSharedResults *results = [OCDSpecSharedResults sharedResults];
                    results.successes = [NSNumber numberWithInt:2];
                    
                    OCDSpecSharedResults *newResults = [OCDSpecSharedResults sharedResults];
                    
                    [expect(newResults.successes) toBeEqualTo:[NSNumber numberWithInt:2]];
                }),    */
             
             nil);
}