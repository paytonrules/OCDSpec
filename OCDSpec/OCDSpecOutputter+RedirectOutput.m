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
  
  context();
  
  outputter.fileHandle = [NSFileHandle fileHandleWithStandardError];
}

@end
