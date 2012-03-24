#import "OCDSpec/OCDSpecExample.h"
#import "OCDSpec/OCDSpecOutputter.h"

@implementation OCDSpecExample

@synthesize failed;

-(id) init
{
  if ((self = [super init]))
  {
    failed = NO;
  }
  return self;
}

-(id) initWithBlock:(void (^)(void))example
{
  if ((self = [self init]))
  {
    itsExample = [example copy];
  }
  return self;
}

-(void) run
{
  @try
  {
    void (^test) (void) = itsExample;
    test();
  }
  @catch (NSException * e)
  {
    NSString *errorString = [NSString stringWithFormat:@"%s:%ld: error: %@\n",
                             [[[e userInfo] objectForKey:@"file"] UTF8String],
                             [[[e userInfo] objectForKey:@"line"] longValue],
                             [e reason]];

    [[OCDSpecOutputter sharedOutputter] writeMessage:errorString];
    
    failed = YES;
  }
}

// Dealloc the block

@end

// It helper function for testing
OCDSpecExample *it(NSString *description, void (^example)(void))
{
  return [[OCDSpecExample alloc] initWithBlock:example];
}
