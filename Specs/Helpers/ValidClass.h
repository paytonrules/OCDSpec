#include "OCDSpec/OCDSpecResults.h"

@interface AbstractBaseClass : NSObject
@end

@interface ValidClass : AbstractBaseClass
+(void) setSuccesses: (int) successes andFailures: (int) failures;
+ (OCDSpecResults)run;
+ (bool)wasRun;
@end