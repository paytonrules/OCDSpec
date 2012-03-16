#import <Foundation/Foundation.h>
#import "OCDSpec/Protocols/DescriptionRunner.h"
#import "OCDSpec/OCDSpecDescription.h"
#import "OCDSpec/OCDSpecSharedResults.h"
#import "OCDSpec/Abstract/AbstractDescriptionRunner.h"

@interface OCDSpecDescriptionRunner : NSObject 
{
  Class         *classes;
  int           classCount;
  id            specProtocol;
  id            baseClass;
  int           successes;
  int           failures;
}

@property(nonatomic, assign) id specProtocol;
@property(nonatomic, assign) id baseClass;
@property(readonly) int successes;
@property(readonly) int failures;

-(void) runAllDescriptions;
@end

#define CONTEXT(classname) \
void descriptionOf##classname();\
@interface TestRunner##classname : AbstractDescriptionRunner \
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
