#import "OCDSpec/OCDSpecDescription.h"
#import "OCDSpec/OCDSpecExample.h"
#import "OCDSpec/OCDSpecSharedResults.h"

void describe(NSString *descriptionName, ...)
{
  va_list         variableArgumentList;
  OCDSpecExample  *example;
  NSMutableArray  *exampleList = [NSMutableArray arrayWithCapacity:20];
  
  va_start(variableArgumentList, descriptionName);
  while ((example = va_arg(variableArgumentList, OCDSpecExample*) ) )
  {
    [exampleList addObject: example];
  }
  va_end(variableArgumentList);
  
  OCDSpecDescription *description = [[[OCDSpecDescription alloc] initWithName:descriptionName examples:exampleList] autorelease];
  [description describe];
  
  OCDSpecSharedResults *results = [OCDSpecSharedResults sharedResults];
  results.successes = description.successes;
  results.failures = description.failures;
}

@implementation OCDSpecDescription

@synthesize failures, successes;

-(id) initWithName:(NSString *) name examples:(NSArray *)examples
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
  // Write the name here
  
  [itsExamples enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop)
  {
    OCDSpecExample *example = (OCDSpecExample *) obj;
     
    [example run];
    if (example.failed)
    {
      self.failures++;
    }
    else 
    {
      self.successes++;
    }
  }];
}

// TEST DEALLOC

@end
