#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecOutputter.h"

CONTEXT(OCDSpecOutputter)
{
  describe(@"Shared singleton Outputter", 
           it(@"has a default ouputter of standard error",
              ^{
                OCDSpecOutputter *outputter = [OCDSpecOutputter sharedOutputter];
     
                if (outputter.fileHandle != [NSFileHandle fileHandleWithStandardError])
                {
                  FAIL(@"Should have had standard error.  Didn't");
                }
              }),
           nil);
}