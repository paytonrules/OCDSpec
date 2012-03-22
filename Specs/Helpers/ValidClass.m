#import "ValidClass.h"
#import "OCDSpecResults.h"

static int validClassSuccesses = 0;
static int validClassFailures = 0;
static BOOL validClassWasRun = false;

@implementation AbstractBaseClass
@end

@implementation ValidClass

+(void) setSuccesses: (int) successes andFailures: (int) failures
{
  validClassSuccesses = successes;
  validClassFailures = failures;
}

+ (OCDSpecResults)run
{
  OCDSpecResults results;
  results.failures = validClassFailures;
  results.successes = validClassSuccesses;
  validClassWasRun = true;
  return results;
}

+ (bool)wasRun
{
  return validClassWasRun;
}
@end