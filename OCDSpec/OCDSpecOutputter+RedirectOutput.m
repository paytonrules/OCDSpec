#import "TemporaryFileStuff.h"
#import "OCDSpecOutputter+RedirectOutput.h"

@implementation OCDSpecOutputter (RedirectOutput)

// Exception in call
// delete the temp file
// Move temp file stuff to here - maybe test paths and such
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
    [[NSFileManager defaultManager] removeItemAtPath:OutputterPath() error:nil];
  }
}

@end
