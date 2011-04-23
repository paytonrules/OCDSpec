#import <Foundation/Foundation.h>

@interface OCDSpecExpectation : NSObject {
    id actualObject;
    int line;
    NSString *file;
}
-(id) initWithObject:(id) object inFile:(NSString*) fileName atLineNumber:(int) lineNumber;
-(void) beEqualTo:(id) expectedObject;

@end
