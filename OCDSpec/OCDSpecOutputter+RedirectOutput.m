#import "OCDSpecOutputter+RedirectOutput.h"


@implementation OCDSpecOutputter (RedirectOutput)

+(NSFileHandle *) temporaryFileHandle
{
  [[NSFileManager defaultManager] createFileAtPath:[OCDSpecOutputter temporaryDirectory] contents: nil attributes: nil];
  return [NSFileHandle fileHandleForWritingAtPath:[OCDSpecOutputter temporaryDirectory]];
}

+(void) withRedirectedOutput:(void (^)(void))context
{
  OCDSpecOutputter *outputter = [OCDSpecOutputter sharedOutputter];
  outputter.fileHandle = [self temporaryFileHandle];
  
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

-(NSString *) readOutput __attribute((ns_returns_retained))
{
  NSFileHandle *inputFile = [NSFileHandle fileHandleForReadingAtPath:[OCDSpecOutputter temporaryDirectory]];
  NSString *output = [[NSString alloc] initWithData:[inputFile readDataToEndOfFile] 
                                           encoding:NSUTF8StringEncoding];
  return output;
}

@end