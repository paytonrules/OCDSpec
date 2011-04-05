#import <Foundation/Foundation.h>
#import "OCDSpec/Protocols/DescriptionRunner.h"
#import "OCDSpec/OCDSpecDescription.h"
#import "OCDSpec/OCDSpecSharedResults.h"

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
@interface TestRunner##classname : NSObject<DescriptionRunner>\
@end\
@implementation TestRunner##classname\
+(NSNumber *)getFailures \
{ \
  return [NSNumber numberWithInt:[OCDSpecSharedResults sharedResults].failures];\
} \
+(NSNumber *)getSuccesses \
{ \
  return [NSNumber numberWithInt:[OCDSpecSharedResults sharedResults].successes];\
} \
+(void) run \
{ \
  descriptionOf##classname(); \
} \
@end \
void descriptionOf##classname()
