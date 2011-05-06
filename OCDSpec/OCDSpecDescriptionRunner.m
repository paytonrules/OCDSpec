#include <objc/runtime.h>
#import "OCDSpec/OCDSpecDescriptionRunner.h"
#import "OCDSpec/Protocols/DescriptionRunner.h"
#import "OCDSpec/OCDSpecOutputter.h"

@class TestDescriptionRunner;

@implementation OCDSpecDescriptionRunner

@synthesize specProtocol, successes, failures;

-(id) init
{
  if ((self = [super init]))
  {
    specProtocol = @protocol(DescriptionRunner);
  }

  return self;
}

-(BOOL) isDescriptionRunner:(Class) klass
{
  return class_respondsToSelector(klass, @selector(conformsToProtocol:)) && [klass conformsToProtocol:specProtocol]; 
}

-(void) getListOfClassesInBundle
{
  classCount = objc_getClassList(NULL, 0);
  NSMutableData *classData = [NSMutableData dataWithLength:sizeof(Class) * classCount];
  
  // Allocate a list of classes of max size.  Could I make this an NSArray?
  classes = (Class*)[classData mutableBytes];

  // Get the real class list
  objc_getClassList(classes, classCount);
}

-(void) callRunOnEachStaticDescription
{
  for (int i = 0; i < classCount; ++i)
  {
    Class currClass = classes[i];
    
    // Check if it conforms our protocol
    if ([self isDescriptionRunner:currClass])
    {
      [currClass run];
      successes += [currClass getSuccesses]; 
      failures += [currClass getFailures];
    }
  }
}

-(void) reportResults
{
  NSString *resultsMessage = [NSString stringWithFormat:@"Tests ran with %d passing tests and %d failing tests\n", successes, failures];
  [[OCDSpecOutputter sharedOutputter] writeMessage:resultsMessage];
}

-(void) runAllDescriptions
{
  successes = 0;
  failures = 0;
  [self getListOfClassesInBundle];
  [self callRunOnEachStaticDescription];
  [self reportResults];
}

@end
