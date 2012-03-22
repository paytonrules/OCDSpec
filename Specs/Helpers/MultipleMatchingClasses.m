#import "MultipleMatchingClasses.h"
#import "OCDSpecResults.h"

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

+ (OCDSpecResults)run
{
  OCDSpecResults results;
  results.failures = multipleClassFailures;
  results.successes = multipleClassSuccesses;
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

+ (OCDSpecResults)run
{
  OCDSpecResults results;
  results.failures = multipleSecondClassFailures;
  results.successes = multipleSecondClassSuccesses;
  return results;
}
@end