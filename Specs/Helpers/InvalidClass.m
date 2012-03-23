#import "InvalidClass.h"
#import "OCDSpecResults.h"

static BOOL inValidClassWasRun = false;

@implementation InvalidClass

+ (OCDSpecResults)run
{
  OCDSpecResults results;
  inValidClassWasRun = true;
  return results;
}

+ (bool)wasRun
{
  return inValidClassWasRun;
}

@end
