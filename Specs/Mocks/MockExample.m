#import "MockExample.h"

@implementation MockExample
@synthesize failed;

+(MockExample *)newExampleThatFailed
{
  MockExample *example = [[MockExample alloc] init];
  example.failed = YES;
  return example;
}

-(void) run
{
} 

@end
