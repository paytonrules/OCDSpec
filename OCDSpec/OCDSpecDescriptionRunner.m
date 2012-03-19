#import "OCDSpecDescriptionRunner.h"
#import "OCDSpec/OCDSpecSharedResults.h"
#import "OCDSpec/OCDSpecDescription.h"

static OCDSpecDescriptionRunner *currentRunner = NULL;

@implementation OCDSpecDescriptionRunner

@synthesize failures, successes;

+(int) getFailures
{
  return [[OCDSpecSharedResults sharedResults].failures intValue];;
}

+(int) getSuccesses
{
  return [[OCDSpecSharedResults sharedResults].successes intValue];
}

-(OCDSpecSharedResults *) runContext:(void( *)(void))context
{
  currentRunner = self;
  (*context)();
  OCDSpecSharedResults *results = [[[OCDSpecSharedResults alloc] init] autorelease];
  results.failures = failures;
  results.successes = successes;
  return results;
}

-(void) runDescription:(OCDSpecDescription *)desc
{
  [desc describe];
  failures = [NSNumber numberWithInt:[desc.failures intValue] + [failures intValue] ];
  successes = [NSNumber numberWithInt:[desc.successes intValue] + [successes intValue] ];
}

+(void) describe:(NSString *)descriptionName withExamples:(va_list)examples
{
  OCDSpecDescription *description = [OCDSpecDescription descriptionFromName:descriptionName examples:examples];

  [description describe];

  OCDSpecSharedResults *results = [OCDSpecSharedResults sharedResults];
  results.successes = description.successes;
  results.failures = description.failures;
}

@end

void describe(NSString *descriptionName, ...) {
  va_list examples;

  va_start(examples, descriptionName);
  OCDSpecDescription *description = [OCDSpecDescription descriptionFromName:descriptionName examples:examples];
  [currentRunner runDescription:description];
  va_end(examples);
}