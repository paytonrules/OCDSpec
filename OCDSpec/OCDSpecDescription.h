#import <Foundation/Foundation.h>

typedef void (^VOIDBLOCK)();

@class OCDSpecExample;
@class OCDSpecPostCondition;

@interface OCDSpecDescription : NSObject 
{
    NSNumber        *failures;
    NSNumber        *successes;
    NSArray         *itsExamples;
    NSString        *itsName;
    VOIDBLOCK       precondition;
    VOIDBLOCK       postcondition;
}

@property(nonatomic, retain) NSNumber *failures;
@property(nonatomic, retain) NSNumber *successes;
@property(readwrite, copy) VOIDBLOCK precondition;
@property(readwrite, copy) VOIDBLOCK postcondition;

// NOTE - this describe is probably deletable!
-(void) describe:(NSString *)name onArrayOfExamples:(NSArray *) examples;

-(void) describe;
-(id) initWithName:(NSString *) name examples:(NSArray *)examples;

@end

void describe(NSString *description,  ...);
VOIDBLOCK beforeEach(VOIDBLOCK precondition);
OCDSpecPostCondition *afterEach(VOIDBLOCK postcondition);
