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
                   [sharedOutputter writeData:@"Test Data"];
                   
                   outputData = [ReadTemporaryFile() stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                 }];
                
                if ( [outputData compare:@"Test Data"] != 0) 
                {
                  NSLog(@"%@", outputData);
                  FAIL(@"The Test data was not redirected");
                }
              }),
           nil);
}