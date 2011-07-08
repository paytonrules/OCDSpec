#import <Foundation/Foundation.h>

@interface OCDSpecExpectation : NSObject {
    id actualObject;
    int line;
    NSString *file;
}
@property(readonly) int line;
@property(readonly) NSString *file;

-(id) initWithObject:(id) object inFile:(NSString*) fileName atLineNumber:(int) lineNumber;
-(void) toBeEqualTo:(id) expectedObject;
-(void) toBe:(id) expectedObject;
-(void) toBeTrue;
-(void) toBeFalse;

@end

#define expect(obj)       [[[OCDSpecExpectation alloc] initWithObject:obj inFile:[NSString stringWithUTF8String:__FILE__] atLineNumber:__LINE__] autorelease]
#define expectTruth(obj)  [[[[OCDSpecExpectation alloc] initWithObject:[NSNumber numberWithBool:obj] inFile:[NSString stringWithUTF8String:__FILE__] atLineNumber:__LINE__] autorelease] toBeTrue]
#define expectFalse(obj)  [[[[OCDSpecExpectation alloc] initWithObject:[NSNumber numberWithBool:obj] inFile:[NSString stringWithUTF8String:__FILE__] atLineNumber:__LINE__] autorelease] toBeFalse]