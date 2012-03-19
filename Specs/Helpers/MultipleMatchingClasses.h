#import <Foundation/Foundation.h>


@interface MultipleMatchingClasses : NSObject
@end

@interface FirstMultipleClass : MultipleMatchingClasses
+(void) setSuccesses: (int) successes andFailures: (int) failures;
@end

@interface SecondMultipleClass : MultipleMatchingClasses
+(void) setSuccesses: (int) successes andFailures: (int) failures;
@end
