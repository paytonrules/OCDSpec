#import "OCDSpecSharedResults.h"


@implementation OCDSpecSharedResults

@synthesize failures, successes;

static OCDSpecSharedResults *sharedResults = nil;

+(OCDSpecSharedResults *)sharedResults
{
  if (sharedResults == nil) 
  {
    sharedResults = [[super alloc] init];
  }
  return sharedResults;
}

@end