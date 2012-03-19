#import "InvalidClass.h"
#import "OCDSpec/OCDSpecSharedResults.h"

static BOOL inValidClassWasRun = false;

@implementation InvalidClass

+ (OCDSpecSharedResults *)run
{
  inValidClassWasRun = true;
}

+ (bool)wasRun
{
  return inValidClassWasRun;
}

@end
