#import <objc/objc.h>

@protocol Expectation
-(void) toBeEqualTo:(id) expectedObject;
-(void) toBe:(id) expectedObject;
@end