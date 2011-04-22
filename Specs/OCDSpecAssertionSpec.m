#import "OCDSpec/OCDSpec.h"

CONTEXT(OCDSpecShouldObject)
{
  describe(@"The Should object", 
           it(@"is created holding another object, which it proxies to",
              ^{
                NSObject *genericObject = [[[NSObject alloc] init] autorelease];
                OCDSpecShouldObject *shouldAh = [[[OCDSpecShouldObject alloc] initWithObject:genericObject] autorelease];
                
                
              }),
           nil);
}