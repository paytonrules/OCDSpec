#import "OCDSpec/OCDSpecDescription.h"
#import "OCDSpec/OCDSpecExample.h"
#import "OCDSpec/OCDSpecSharedResults.h"
#import "OCDSpec/Contract/OCDSpecPreCondition.h"
#import "OCDSpec/Contract/OCDSpecPostCondition.h"
#import "OCDSpec/Abstract/OCDSpecAbstractDescriptionRunner.h"

OCDSpecPreCondition *beforeEach(VOIDBLOCK precondition) {
  OCDSpecPreCondition *cond = [[[OCDSpecPreCondition alloc] init] autorelease];
  cond.condition = precondition;

  return cond;
}

OCDSpecPostCondition *afterEach(VOIDBLOCK postcondition) {
  OCDSpecPostCondition *cond = [[[OCDSpecPostCondition alloc] init] autorelease];
  cond.condition = postcondition;

  return cond;
}

@implementation OCDSpecDescription

@synthesize failures, successes, precondition, postcondition;

- (id)init
{
  if ((self = [super init]))
  {
    successes = [NSNumber numberWithInt:0];
    failures = [NSNumber numberWithInt:0];
    precondition = postcondition = ^{
    };
  }

  return self;
}

- (id)initWithName:(NSString *)name examples:(NSArray *)examples
{
  if ((self = [self init]))
  {
    itsExamples = examples;
    itsName = name;
  }
  return self;
}

- (void)describe:(NSString *)name onArrayOfExamples:(NSArray *)examples
{
  itsExamples = examples;
  itsName = name;
  [self describe];
}

- (void)describe
{
  [itsExamples enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    OCDSpecExample *example = (OCDSpecExample *) obj;

    self.precondition();
    [example run];
    if (example.failed)
    {
      self.failures = [NSNumber numberWithInt:[failures intValue] + 1];
    }
    else
    {
      self.successes = [NSNumber numberWithInt:[successes intValue] + 1];
    }
    self.postcondition();
  }];
}

// TEST DEALLOC

@end
