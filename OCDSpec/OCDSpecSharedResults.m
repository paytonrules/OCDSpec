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

-(BOOL) equalTo:(OCDSpecSharedResults *)otherResults
{
  if (sharedResults != nil &&
      sharedResults.failures == self.failures &&
      sharedResults.successes == self.successes)
    return YES;
  
  return NO;
}

@end