#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecOutputter.h"

CONTEXT(OCDSpecOutputter)
{
    describe(@"Shared singleton Outputter",
             it(@"has a default ouputter of standard error",
                ^{
                    OCDSpecOutputter *outputter = [OCDSpecOutputter sharedOutputter];
                    
                    [expect(outputter.fileHandle) toBe:[NSFileHandle fileHandleWithStandardError]];
                }),
             nil);
}