#import <Foundation/Foundation.h>
#import "OCDSpec/VoidBlock.h"

@class OCDSpecExample;
@class OCDSpecPostCondition;
@class OCDSpecPreCondition;

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
OCDSpecPreCondition *beforeEach(VOIDBLOCK precondition);
OCDSpecPostCondition *afterEach(VOIDBLOCK postcondition);
