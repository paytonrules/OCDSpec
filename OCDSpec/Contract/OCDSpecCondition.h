#import <Foundation/Foundation.h>
#import "OCDSpec/VoidBlock.h"

@interface OCDSpecCondition : NSObject {
    VOIDBLOCK condition;
}
@property(readwrite, copy) VOIDBLOCK condition;
@end