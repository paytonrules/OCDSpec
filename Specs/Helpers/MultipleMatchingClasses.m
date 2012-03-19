#import "MultipleMatchingClasses.h"
#import "OCDSpec/OCDSpecSharedResults.h"

@implementation MultipleMatchingClasses

@end

static int multipleClassSuccesses = 0;
static int multipleClassFailures = 0;
@implementation FirstMultipleClass

+(void) setSuccesses: (int) successes andFailures: (int) failures
{
  multipleClassSuccesses = successes;
  multipleClassFailures = failures;
}

+ (OCDSpecSharedResults *)run
{
  OCDSpecSharedResults *results = [[[OCDSpecSharedResults alloc] init] autorelease];
  results.failures = [NSNumber numberWithInt:multipleClassFailures];
  results.successes = [NSNumber numberWithInt:multipleClassSuccesses];
  return results;
}
@end

static int multipleSecondClassSuccesses = 0;
static int multipleSecondClassFailures = 0;
@implementation SecondMultipleClass

+(void) setSuccesses: (int) successes andFailures: (int) failures
{
  multipleSecondClassSuccesses = successes;
  multipleSecondClassFailures = failures;
}

+ (OCDSpecSharedResults *)run
{
  OCDSpecSharedResults *results = [[[OCDSpecSharedResults alloc] init] autorelease];
  results.failures = [NSNumber numberWithInt:multipleSecondClassFailures];
  results.successes = [NSNumber numberWithInt:multipleSecondClassSuccesses];
  return results;
}
@end