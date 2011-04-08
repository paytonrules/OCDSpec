#import "TemporaryFileStuff.h"
#import "OCDSpecOutputter+RedirectOutput.h"

@implementation OCDSpecOutputter (RedirectOutput)

+(void) withRedirectedOutput:(void (^)(void))context
{
  OCDSpecOutputter *outputter = [OCDSpecOutputter sharedOutputter];
  outputter.fileHandle = GetTemporaryFileHandle();
  
  @try
  {
    context();
  }
  @finally
  {
    outputter.fileHandle = [NSFileHandle fileHandleWithStandardError];
    [[NSFileManager defaultManager] removeItemAtPath:[self temporaryDirectory] error:nil];
  }
}

-(NSString *) readOutput
{
  NSFileHandle *inputFile = [NSFileHandle fileHandleForReadingAtPath:[OCDSpecOutputter temporaryDirectory]];
  return [[[NSString alloc] initWithData:[inputFile readDataToEndOfFile] 
                                encoding:NSUTF8StringEncoding] autorelease];
}

@end