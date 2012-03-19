#import <Foundation/Foundation.h>
#import "OCDSpec/Protocols/DescriptionRunner.h"
@class OCDSpecSharedResults;
@class OCDSpecDescription;

@interface OCDSpecDescriptionRunner : NSObject<DescriptionRunner>
{
  NSNumber *failures;
  NSNumber *successes;
}

@property(nonatomic, retain) NSNumber *failures;
@property(nonatomic, retain) NSNumber *successes;
-(OCDSpecSharedResults *) runContext:(void(*)(void)) context;
-(OCDSpecSharedResults *) runDescription:(OCDSpecDescription *) desc;

+(void) describe: (NSString *) descriptionName withExamples: (va_list) examples;
@end

void describe(NSString *description,  ...);

#define CONTEXT(classname) \
void descriptionOf##classname(void);\
void (*funcPtr)(void); \
@interface TestRunner##classname : OCDSpecDescriptionRunner \
@end\
@implementation TestRunner##classname\
+(OCDSpecSharedResults *) run \
{ \
  TestRunner##classname *runner = [[[TestRunner##classname alloc] init] autorelease]; \
  return [runner runContext: &descriptionOf##classname]; \
} \
@end \
void descriptionOf##classname(void)