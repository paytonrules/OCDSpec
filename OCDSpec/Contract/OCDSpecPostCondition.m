#import "OCDSpec/Contract/OCDSpecPostCondition.h"

@implementation OCDSpecPostCondition

@end

OCDSpecPostCondition *afterEach(VOIDBLOCK postcondition) {
  OCDSpecPostCondition *cond = [[[OCDSpecPostCondition alloc] init] autorelease];
  cond.condition = postcondition;

  return cond;
}