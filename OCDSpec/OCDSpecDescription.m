#import "OCDSpec/OCDSpecDescription.h"
#import "OCDSpec/OCDSpecExample.h"

// Warning - untested code
void describe(NSString *description, ...)
{
  va_list         variableArgumentList;
  OCDSpecExample  *example;
  NSMutableArray  *exampleList = [NSMutableArray arrayWithCapacity:20];
  
  va_start(variableArgumentList, description);
  while (example = va_arg(variableArgumentList, OCDSpecExample*) )
  {
    [exampleList addObject: example];
  }
  va_end(variableArgumentList);

  OCDSpecDescription *decription = [[[OCDSpecDescription alloc] initWithName:description examples:exampleList] autorelease];
  [decription describe];
}
// End untested code

@implementation OCDSpecDescription

@synthesize errors, successes;

-(id) initWithName:(NSString *) name examples:(NSArray *)examples
{
  if (self = [self init])
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
      self.errors++;
    }
    else 
    {
      self.successes++;
    }
  }];
}

// TEST DEALLOC

@end
