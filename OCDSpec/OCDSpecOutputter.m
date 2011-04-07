#import "OCDSpecOutputter.h"

@implementation OCDSpecOutputter

static OCDSpecOutputter *sharedOutputter = nil;

@synthesize fileHandle;

-(id) init
{
  if (self = [super init]) 
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

-(void) writeData:(NSString *)data
{
  [fileHandle writeData:[data dataUsingEncoding:NSUTF8StringEncoding]];
}

// I intentionally do not override alloc with zone etc, because I want to be able to test this. 


@end
