@class OCDSpecSharedResults;

@interface AbstractBaseClass : NSObject
@end

@interface ValidClass : AbstractBaseClass
+(void) setSuccesses: (int) successes andFailures: (int) failures;
+ (OCDSpecSharedResults *)run;
+ (bool)wasRun;
@end