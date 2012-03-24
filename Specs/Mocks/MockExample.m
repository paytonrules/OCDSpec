#import "MockExample.h"

@implementation MockExample
@synthesize failed;

+(MockExample *)exampleThatFailed
{
  MockExample *example = [[MockExample alloc] init];
  example.failed = YES;
  return example;
}

-(void) run
{
} 

@end
