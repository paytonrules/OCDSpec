#import "ValidClass.h"
#import "OCDSpec/OCDSpecSharedResults.h"

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

+ (OCDSpecSharedResults *)run
{
  OCDSpecSharedResults *results = [[[OCDSpecSharedResults alloc] init] autorelease];
  results.failures = [NSNumber numberWithInt:validClassFailures];
  results.successes = [NSNumber numberWithInt:validClassSuccesses];
  validClassWasRun = true;
  return results;
}

+ (bool)wasRun
{
  return validClassWasRun;
}
@end