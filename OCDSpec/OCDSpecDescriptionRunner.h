#import <Foundation/Foundation.h>
#import "OCDSpec/Protocols/DescriptionRunner.h"
#import "OCDSpec/OCDSpecResults.h"

@class OCDSpecDescription;

@interface OCDSpecDescriptionRunner : NSObject<DescriptionRunner>
{
  NSNumber *failures;
  NSNumber *successes;
}

@property(nonatomic, retain) NSNumber *failures;
@property(nonatomic, retain) NSNumber *successes;
-(OCDSpecResults) runContext:(void(*)(void)) context;
-(void) runDescription:(OCDSpecDescription *) desc;
@end

void describe(NSString *description,  ...);

#define CONTEXT(classname) \
void descriptionOf##classname(void);\
void (*funcPtr)(void); \
@interface TestRunner##classname : OCDSpecDescriptionRunner \
@end\
@implementation TestRunner##classname\
+(OCDSpecResults) run \
{ \
  TestRunner##classname *runner = [[TestRunner##classname alloc] init]; \
  return [runner runContext: &descriptionOf##classname]; \
} \
@end \
void descriptionOf##classname(void)