#import <Foundation/Foundation.h>
#import "OCDSpec/Protocols/DescriptionRunner.h"
#import "OCDSpec/OCDSpecDescription.h"

@interface OCDSpecDescriptionRunner : NSObject 
{
  Class         *classes;
  NSInteger     classCount;
  NSFileHandle  *outputter;
  id            specProtocol;
  int           successes;
  int           failures;
}

@property(nonatomic, retain) NSFileHandle *outputter;
@property(nonatomic, assign) id specProtocol;
@property(readonly) int successes;
@property(readonly) int failures;

-(void) runAllDescriptions;
@end

// Note - the ARRAY and IDARRAY macros are grabbed from MACollectionUtilities by mike ash - 
// I don't really need the rest of the MACollectionUtilities, but proper credit where credit is due and such.
// https://github.com/mikeash/MACollectionUtilities/blob/master/MACollectionUtilities.h
#define ARRAY(...) ([NSArray arrayWithObjects: IDARRAY(__VA_ARGS__) count: IDCOUNT(__VA_ARGS__)])
#define IDARRAY(...) ((id[]){ __VA_ARGS__ })
#define IDCOUNT(...) (sizeof(IDARRAY(__VA_ARGS__)) / sizeof(id))

#define DESCRIBE(classname, ...)\
static OCDSpecDescription *desc##classname;\
@interface TestRunner##classname : NSObject<DescriptionRunner>\
@end\
@implementation TestRunner##classname\
+(void) run \
{ \
desc##classname = [[[OCDSpecDescription alloc] initWithName:@"##classname" examples:ARRAY(__VA_ARGS__)] autorelease]; \
[desc##classname describe]; \
} \
+(NSNumber *)getFailures \
{ \
return [NSNumber numberWithInt:[desc##classname errors]];\
} \
+(NSNumber *)getSuccesses \
{ \
return [NSNumber numberWithInt:[desc##classname successes]];\
} \
@end
