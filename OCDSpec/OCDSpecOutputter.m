#import "OCDSpecOutputter.h"

@implementation OCDSpecOutputter

static OCDSpecOutputter *sharedOutputter = nil;

@synthesize fileHandle;

-(id) init
{
  if ((self = [super init]))
  {
    fileHandle = [NSFileHandle fileHandleWithStandardError];
  }
  
  return self;
}

+(OCDSpecOutputter *)sharedOutputter
{
  if (sharedOutputter == nil) {
    sharedOutputter = [[super alloc] init];
  }
  return sharedOutputter;
}

+(NSString *)temporaryDirectory
{
  return [NSTemporaryDirectory() stringByAppendingPathComponent:@"test.txt"];
}

-(void) writeMessage:(NSString *)message
{
  [fileHandle writeData:[message dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
