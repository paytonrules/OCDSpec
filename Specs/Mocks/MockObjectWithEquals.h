#import <Foundation/Foundation.h>


@interface MockObjectWithEquals : NSObject {
    id expected;
    BOOL equal;
}

@property(nonatomic, retain) id expected;
-(BOOL) isEqual:(id) object;
-(id) initAsNotEqual;

@end
