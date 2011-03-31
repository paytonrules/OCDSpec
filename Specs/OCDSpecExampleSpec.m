#import "OCDSpec/OCDSpecDescriptionRunner.h"
#import "OCDSpec/OCDSpecFail.h"
#import "OCDSpec/OCDSpecExample.h"
#import "Specs/Utils/TemporaryFileStuff.h"

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

              if (caughtFailure != YES) 
              {
                [[object should] fail];
                FAIL(@"This should have raised a failure");
              }
            }),

         it(@"Should Pass An empty Test",
            ^{
            }),
 
         it(@"writes its exceptions to the outputter",
            ^{
              OCDSpecExample *example = [[[OCDSpecExample alloc] initWithBlock:^{ FAIL(@"FAIL"); }] autorelease];
              example.outputter = GetTemporaryFileHandle();
      
              [example run];
      
              NSString *outputException = ReadTemporaryFile();
      
              if (outputException.length == 0)
              {
                FAIL(@"An exception should have been written to the outputter - but wasn't.");
              }
      
              DeleteTemporaryFile();
            }),
 
         it(@"Examples write their output in a XCode friendly format",
            ^{
              int outputLine = __LINE__ + 1;
              OCDSpecExample *example = [[[OCDSpecExample alloc] initWithBlock:^{ FAIL(@"FAIL"); }] autorelease];
              example.outputter = GetTemporaryFileHandle();
      
              [example run];
      
              NSString *outputException = ReadTemporaryFile();
      
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
      
              DeleteTemporaryFile();
            })
           );
}
