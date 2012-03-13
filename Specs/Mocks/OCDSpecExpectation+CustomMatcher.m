#import "OCDSpecExpectation+CustomMatcher.h"

@implementation OCDSpecExpectation (CustomMatcher)

-(void) toEqualABC
{
    if (actualObject != @"ABC")
        [self failWithMessage: [NSString stringWithFormat: @"Expected ABC, but got %@", actualObject]];
}

@end
