#import <Foundation/Foundation.h>
#import "OCDSpec/Protocols/DescriptionRunner.h"
#import "OCDSpec/OCDSpecDescription.h"
#import "OCDSpec/OCDSpecSharedResults.h"
#import "OCDSpecDescriptionRunner.h"

@interface OCDSpecSuiteRunner : NSObject
{
  Class         *classes;
  int           classCount;
  id            baseClass;
  int           successes;
  int           failures;
}

@property(nonatomic, assign) id baseClass;
@property(readonly) int successes;
@property(readonly) int failures;

-(void) runAllDescriptions;
@end

#define CONTEXT(classname) \
void descriptionOf##classname(void);\
void (*funcPtr)(void); \
@interface TestRunner##classname : OCDSpecDescriptionRunner \
@end\
@implementation TestRunner##classname\
+(void) run \
{ \
  TestRunner##classname *runner = [[[TestRunner##classname alloc] init] autorelease]; \
  [runner runDescription: &descriptionOf##classname]; \
} \
@end \
void descriptionOf##classname(void)