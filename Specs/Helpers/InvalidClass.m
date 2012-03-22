#import "InvalidClass.h"
#import "OCDSpecResults.h"

static BOOL inValidClassWasRun = false;

@implementation InvalidClass

+ (OCDSpecResults *)run
{
  inValidClassWasRun = true;
}

+ (bool)wasRun
{
  return inValidClassWasRun;
}

@end
