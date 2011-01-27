#import "OCSpecFail.h"

@implementation OCSpecFail

+(void) fail:(NSString *)reason atLine:(NSInteger) line inFile: (NSString *)file
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
