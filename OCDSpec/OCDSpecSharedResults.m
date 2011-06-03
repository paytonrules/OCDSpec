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

-(id) init
{
    if ((self = [super init]))
    {
        failures = [[NSNumber alloc] initWithInt:0];
        successes = [[NSNumber alloc] initWithInt:0];
    }
    
    return self;
}

-(BOOL) isEqual:(OCDSpecSharedResults *)otherResults
{
    if (otherResults != nil &&
        [otherResults.failures isEqualToNumber:self.failures] &&
        [otherResults.successes isEqualToNumber:self.successes])
    {
        return YES;
    }
  
    return NO;
}

@end