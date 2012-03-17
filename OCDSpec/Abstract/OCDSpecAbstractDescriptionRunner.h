#import <Foundation/Foundation.h>
#import "OCDSpec/Protocols/DescriptionRunner.h"

@interface OCDSpecAbstractDescriptionRunner : NSObject<DescriptionRunner>
-(void) runDescription:(void(*)(void)) desc;
@end
