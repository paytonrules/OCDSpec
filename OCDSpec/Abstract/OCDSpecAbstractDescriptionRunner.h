#import <Foundation/Foundation.h>
#import "OCDSpec/Protocols/DescriptionRunner.h"

@interface OCDSpecAbstractDescriptionRunner : NSObject<DescriptionRunner>
-(void) runDescription:(void(*)(void)) desc;
+(void) describe: (NSString *) descriptionName withExamples: (va_list) examples;
@end
