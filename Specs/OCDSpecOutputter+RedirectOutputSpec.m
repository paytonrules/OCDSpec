#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/OCDSpecOutputter+RedirectOutput.h"

CONTEXT(OCDSpecOutputter_RedirectOutput)
{
  describe(@"The redirected output category", 
           it(@"redirects the output within the block", ^{
                __block NSString *outputData;
                [OCDSpecOutputter withRedirectedOutput:
                 ^{
                   OCDSpecOutputter *sharedOutputter = [OCDSpecOutputter sharedOutputter];
                   [sharedOutputter writeMessage:@"Test Data"];
                   
                   outputData = [[sharedOutputter readOutput] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                 }];
                
                if ( [outputData compare:@"Test Data"] != 0) 
                {
                  FAIL(@"The Test data was not redirected");
                }
              }),
           
           it(@"still restores the outputter to the standard error if the call raises an exception", ^{
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

           it(@"Make sure the file is deleted on exception", ^{
                @try {
                  [OCDSpecOutputter withRedirectedOutput:
                   ^{
                     [NSException raise:@"Oh No" format: @"I am another exception"];
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
                  if ([[NSFileManager defaultManager] fileExistsAtPath: [OCDSpecOutputter temporaryDirectory]] == YES)
                  {
                    FAIL(@"File should not have existed but did");
                  }
                }
              }),
           
           it(@"Allows you to read the redirected output", ^{
                __block NSString *outputData;
                [OCDSpecOutputter withRedirectedOutput: ^{
                  [[OCDSpecOutputter sharedOutputter] writeMessage:@"Message"];
                  
                  outputData = [[OCDSpecOutputter sharedOutputter] readOutput];
                }];
                
                if ([outputData compare:@"Message"] != 0)
                {
                  FAIL(@"You could not read back the data the redirected outputter");
                }
              }),
           
           nil);
}