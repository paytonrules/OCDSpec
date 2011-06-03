#import <Foundation/Foundation.h>
#import "OCDSpec/Protocols/DescriptionRunner.h"
#import "OCDSpec/OCDSpecDescription.h"
#import "OCDSpec/OCDSpecSharedResults.h"

@interface OCDSpecDescriptionRunner : NSObject 
{
  Class         *classes;
  int           classCount;
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
+(int) getFailures \
{ \
  return [[OCDSpecSharedResults sharedResults].failures intValue];\
} \
+(int)getSuccesses \
{ \
  return [[OCDSpecSharedResults sharedResults].successes intValue];\
} \
+(void) run \
{ \
  descriptionOf##classname(); \
} \
@end \
void descriptionOf##classname()
