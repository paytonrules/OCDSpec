#import <Foundation/Foundation.h>
#import "OCDSpec/OCDSpecResults.h"

@interface InvalidClass : NSObject
+ (OCDSpecResults)run;
+ (bool)wasRun;
@end