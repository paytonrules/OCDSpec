#import "MockExample.h"

@implementation MockExample
@synthesize failed, outputter;

+(MockExample *)exampleThatFailed
{
  MockExample *example = [[MockExample alloc] init];
  example.failed = YES;
  [example autorelease];
  return example;
}

-(void) run
{
} 

@end
