#import "OCDSpecDescriptionRunner.h"
#import "OCDSpec/OCDSpecDescription.h"

static OCDSpecDescriptionRunner *currentRunner = NULL;

@implementation OCDSpecDescriptionRunner

@synthesize failures, successes;
+(OCDSpecResults) run
{
    OCDSpecResults results;
    [self doesNotRecognizeSelector:_cmd];
    return results;
}

-(OCDSpecResults) runContext:(void( *)(void))context
{
  OCDSpecResults results;
  currentRunner = self;
  (*context)();
  results.failures = [failures intValue];
  results.successes = [successes intValue];
  return results;
}

-(void) runDescription:(OCDSpecDescription *)desc
{
  [desc describe];
  failures = [NSNumber numberWithInt:[desc.failures intValue] + [failures intValue] ];
  successes = [NSNumber numberWithInt:[desc.successes intValue] + [successes intValue] ];
}

@end

void describe(NSString *descriptionName, ...) {
  va_list examples;
  id example;
  NSMutableArray *examplesAsArray = [[NSMutableArray alloc] init];

  va_start(examples, descriptionName);
  while ((example = va_arg(examples, id)))
  {
    [examplesAsArray addObject:example];
  }

  OCDSpecDescription *description = [OCDSpecDescription descriptionFromName:descriptionName examples:examplesAsArray];
  [currentRunner runDescription:description];
  va_end(examples);
}