#import <Foundation/Foundation.h>

@interface OCDSpecFail : NSObject
{

}

+(void) fail:(NSString*)reason atLine:(int) line inFile: (NSString *)file;

@end

#define FAIL(reason) [OCDSpecFail fail:reason atLine: __LINE__ inFile: [NSString stringWithUTF8String: __FILE__]]
