#import "OCDSpec/OCDSpecFail.h"

@implementation OCDSpecFail


+(void) fail:(NSString *)reason atLine:(int) line inFile: (NSString *)file
{
    NSException *exception = [NSException exceptionWithName:@"Test Failed"
                                                     reason:reason
                                                   userInfo:[NSDictionary dictionaryWithObjectsAndKeys: @"TestClass", @"className",
                                                             @"GameCallsUpdateOnController", @"name",
                                                             [NSNumber numberWithLong:line], @"line",
                                                             file, @"file", nil]];
    
    [exception raise];
}

@end
