#import "OCDSpec/OCDSpecDescription.h"
#import "OCDSpec/Contract/OCDSpecPostCondition.h"
#import "OCDSpec/Contract/OCDSpecPreCondition.h"
#import "OCDSpec/OCDSpecExample.h"

@implementation OCDSpecDescription

@synthesize failures, successes, precondition, postcondition;

+(OCDSpecDescription *) descriptionFromName:(NSString *)descriptionName examples:(NSArray *)examplesAndConditions
{
  NSMutableArray *exampleList = [[NSMutableArray alloc] init];
  __block VOIDBLOCK precondition = ^{};
  __block VOIDBLOCK postcondition = ^{};

  [examplesAndConditions enumerateObjectsUsingBlock:^(id example, NSUInteger idx, BOOL *stop){
    if ([example isKindOfClass:[OCDSpecExample class]])
    {
      [exampleList addObject:example];
    }
    else if ([example isKindOfClass:[OCDSpecPostCondition class]])
    {
      postcondition = ((OCDSpecPostCondition *) example).condition;
    }
    else if ([example isKindOfClass:[OCDSpecPreCondition class]])
    {
      precondition = ((OCDSpecPreCondition *) example).condition;
    }

  }];

  OCDSpecDescription *description = [[OCDSpecDescription alloc] initWithName:descriptionName examples:exampleList];
  description.precondition = precondition;
  description.postcondition = postcondition;
  return description;
}

-(id) init
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

-(id) initWithName:(NSString *)name examples:(NSArray *)examples
{
  if ((self = [self init]))
  {
    itsExamples = examples;
    itsName = name;
  }
  return self;
}

-(void) describe:(NSString *)name onArrayOfExamples:(NSArray *)examples
{
  itsExamples = examples;
  itsName = name;
  [self describe];
}

-(void) describe
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

@end
