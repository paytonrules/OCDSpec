#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecOutputter+RedirectOutput.h"
#import "TemporaryFileStuff.h"

CONTEXT(OCDSpecOutputter_RedirectOutput)
{
  describe(@"The redirected output category", 
           it(@"redirects the output within the block",
              ^{
                __block NSString *outputData;
                [OCDSpecOutputter withRedirectedOutput:
                 ^{
                   OCDSpecOutputter *sharedOutputter = [OCDSpecOutputter sharedOutputter];
                   [sharedOutputter writeMessage:@"Test Data"];
                   
                   outputData = [ReadTemporaryFile() stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                 }];
                
                if ( [outputData compare:@"Test Data"] != 0) 
                {
                  FAIL(@"The Test data was not redirected");
                }
              }),
           
           it(@"still restores the outputter to the standard error if the call raises an exception",
              ^{
                @try {
                  [OCDSpecOutputter withRedirectedOutput:
                   ^{
                     [NSException raise:@"Oh No" format: @"I am an exception"];
                   }];                  
                }
                @catch (NSException * e) {
                  if ([e.name compare:@"Oh No"] != 0) 
                  {
                    FAIL(@"This raised an exception other than the expected one");
                  }
                }
                @finally 
                {
                  OCDSpecOutputter *outputter = [OCDSpecOutputter sharedOutputter];
                  if ( outputter.fileHandle != [NSFileHandle fileHandleWithStandardError] )
                  {
                    FAIL(@"ERROR filehandle was not redirected back to standard error");
                  }
                }
              }),

           it(@"Make sure the file is deleted",
              ^{
                FAIL(@"PLACEHOLDER");
              }),
           
           nil);
}