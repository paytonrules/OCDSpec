#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecSharedResults.h"

// I don't care for this class, but I need to communicate from a C function back to a macro.

CONTEXT(OCDSpecSharedResults)
{
  describe(@"The Singleton Shared Results", 
           it(@"returns the same instance each time", 
              ^{
                OCDSpecSharedResults *resultsOne = [OCDSpecSharedResults sharedResults];
                OCDSpecSharedResults *resultsTwo = [OCDSpecSharedResults sharedResults];
                
                if (![resultsOne isEqual:resultsTwo])
                {
                  FAIL(@"Each time shared results is called it should return the same results.  It didn't");
                }
                
               }),
           
           it(@"Has a number of failures", 
              ^{
                OCDSpecSharedResults *results = [OCDSpecSharedResults sharedResults];
                results.failures = 2;
                
                OCDSpecSharedResults *newResults = [OCDSpecSharedResults sharedResults];
                
                if (newResults.failures != 2)
                {
                  FAIL(@"You were not able to set, and then later read, the failures");
                }
                
              }),
           
           it(@"Has a number of successes",
              ^{
                OCDSpecSharedResults *results = [OCDSpecSharedResults sharedResults];
                results.successes = 2;
                
                OCDSpecSharedResults *newResults = [OCDSpecSharedResults sharedResults];
                
                if (newResults.successes != 2)
                {
                  FAIL(@"You were not able to set, and then later read, the successes");
                }
              }),
           
           nil);
}