#import "VoidBlock.h"
#import "OCDSpec/Contract/OCDSpecPreCondition.h"

@implementation OCDSpecPreCondition

@end

OCDSpecPreCondition *beforeEach(VOIDBLOCK precondition) {
  OCDSpecPreCondition *cond = [[[OCDSpecPreCondition alloc] init] autorelease];
  cond.condition = precondition;

  return cond;
}
