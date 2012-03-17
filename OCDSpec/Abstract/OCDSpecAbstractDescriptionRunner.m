#import "OCDSpecAbstractDescriptionRunner.h"
#import "OCDSpec/OCDSpecSharedResults.h"

@implementation OCDSpecAbstractDescriptionRunner

+(int) getFailures
{
  return [[OCDSpecSharedResults sharedResults].failures intValue];;
}

+(int) getSuccesses
{
  return [[OCDSpecSharedResults sharedResults].successes intValue];\
}

- (void) runDescription:(void(*)(void)) desc
{
  (*desc)();
}

@end