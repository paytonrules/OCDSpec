#import <Foundation/Foundation.h>

@class OCDSpecSharedResults;

@interface InvalidClass : NSObject
+ (OCDSpecSharedResults *)run;
+ (bool)wasRun;
@end