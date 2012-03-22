#include <objc/runtime.h>
#import "OCDSpecSuiteRunner.h"
#import "OCDSpec/OCDSpecOutputter.h"
#import "OCDSpec/OCDSpecResults.h"
#import "OCDSpec/OCDSpecDescriptionRunner.h"

@class TestDescriptionRunner;

@implementation OCDSpecSuiteRunner

@synthesize successes, failures, baseClass;

-(id) init
{
  if ((self = [super init]))
  {
    baseClass = [OCDSpecDescriptionRunner class];
  }

  return self;
}

-(BOOL) isDescriptionRunner:(Class)klass
{
  return class_getSuperclass(klass) == baseClass;
}

-(void) getListOfClassesInBundle
{
  classCount = objc_getClassList(NULL, 0);
  NSMutableData *classData = [NSMutableData dataWithLength:sizeof(Class) * classCount];

  // Allocate a list of classes of max size.  Could I make this an NSArray?
  classes = (Class *) [classData mutableBytes];

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
      OCDSpecResults results = [currClass run];

      successes += results.successes;
      failures += results.failures;
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
