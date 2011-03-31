#import <Foundation/Foundation.h>
#import "OCDSpec/Protocols/DescriptionRunner.h"
#import "OCDSpec/OCDSpecDescription.h"

@interface OCDSpecDescriptionRunner : NSObject 
{
  Class         *classes;
  NSInteger     classCount;
  id            specProtocol;
  int           successes;
  int           failures;
}

@property(nonatomic, assign) id specProtocol;
@property(readonly) int successes;
@property(readonly) int failures;

-(void) runAllDescriptions;
@end

#define CONTEXT(classname) \
void descriptionOf##classname();\
static OCDSpecDescription *desc##classname;\
@interface TestRunner##classname : NSObject<DescriptionRunner>\
@end\
@implementation TestRunner##classname\
+(NSNumber *)getFailures \
{ \
  return [NSNumber numberWithInt:[desc##classname errors]];\
} \
+(NSNumber *)getSuccesses \
{ \
  return [NSNumber numberWithInt:[desc##classname successes]];\
} \
+(void) run \
{ \
  descriptionOf##classname(); \
} \
@end \
void descriptionOf##classname()
