#import <Foundation/Foundation.h>


@interface MockObjectWithEquals : NSObject {
    id expected;
}

@property(nonatomic, retain) id expected;
-(BOOL) isEqual:(id) object;

@end
