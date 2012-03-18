#import "OCDSpecDescriptionRunner.h"
#import "OCDSpec/OCDSpecSharedResults.h"
#import "OCDSpec/Contract/OCDSpecPostCondition.h"
#import "OCDSpec/Contract/OCDSpecPreCondition.h"
#import "OCDSpec/OCDSpecExample.h"
#import "OCDSpec/OCDSpecDescription.h"

@implementation OCDSpecDescriptionRunner

+ (int)getFailures
{
  return [[OCDSpecSharedResults sharedResults].failures intValue];;
}

+ (int)getSuccesses
{
  return [[OCDSpecSharedResults sharedResults].successes intValue];\

}

- (void)runDescription:(void( *)(void))desc
{
  (*desc)();
}

+ (void)describe:(NSString *)descriptionName withExamples:(va_list)examples
{
  id example;
  NSMutableArray *exampleList = [NSMutableArray arrayWithCapacity:20];
  VOIDBLOCK precondition = ^{};
  VOIDBLOCK postcondition = ^{};

  while ((example = va_arg(examples, id)))
  {
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
  }

  OCDSpecDescription *description = [[[OCDSpecDescription alloc] initWithName:descriptionName examples:exampleList] autorelease];
  description.precondition = precondition;
  description.postcondition = postcondition;
  [description describe];

  OCDSpecSharedResults *results = [OCDSpecSharedResults sharedResults];
  results.successes = description.successes;
  results.failures = description.failures;
}

@end

void describe(NSString *descriptionName, ...)
{
  va_list variableArgumentList;

  va_start(variableArgumentList, descriptionName);
  [OCDSpecDescriptionRunner describe:descriptionName withExamples: variableArgumentList];
  va_end(variableArgumentList);
}