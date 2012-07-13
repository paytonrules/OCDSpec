#import <Foundation/Foundation.h>
#import "Protocols/Expectation.h"

@interface OCDSpecExpectation : NSObject<Expectation> {
    id actualObject;
    int line;
    NSString *file;
}
@property(readonly) int line;
@property(readonly) NSString *file;

-(id) initWithObject:(id) object inFile:(NSString*) fileName atLineNumber:(int) lineNumber;
-(void) toBeFalse;
-(void) failWithMessage:(NSString *)message;
-(void) failWithErrorFormat:(NSString *)errorFormat expectedObject: (id) expectedObject;
-(void) toBeTrue;
-(void) toExist;

@end

#define expect(obj)       [[OCDSpecExpectation alloc] initWithObject:obj inFile:[NSString stringWithUTF8String:__FILE__] atLineNumber:__LINE__]
#define expectTruth(obj)  [[[OCDSpecExpectation alloc] initWithObject:[NSNumber numberWithBool:obj] inFile:[NSString stringWithUTF8String:__FILE__] atLineNumber:__LINE__] toBeTrue]
#define expectFalse(obj)  [[[OCDSpecExpectation alloc] initWithObject:[NSNumber numberWithBool:obj] inFile:[NSString stringWithUTF8String:__FILE__] atLineNumber:__LINE__] toBeFalse]
