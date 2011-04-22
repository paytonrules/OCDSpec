#import <Foundation/Foundation.h>

@interface OCDSpecExpectation : NSObject {
    id actualObject;
}
-(id) initWithObject:(id) object andLineNumber:(int) lineNumber;
-(void) beEqualTo:(id) expectedObject;

@end
