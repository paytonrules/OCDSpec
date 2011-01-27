#import "OCSpecDescription.h"
#import "OCSpecExample.h"

@implementation OCSpecDescription

@synthesize errors, successes, outputter;

-(id) init
{
  if (self = [super init]) 
  {
    self.outputter = [NSFileHandle fileHandleWithStandardError];
  }
  return self;
}

-(id) initWithName:(NSString *) name examples:(NSArray *)examples
{
  if (self = [super init])
  {
    [super init];
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
  [itsExamples enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop)
  {
    OCSpecExample *example = (OCSpecExample *) obj;
    example.outputter = self.outputter;
     
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
