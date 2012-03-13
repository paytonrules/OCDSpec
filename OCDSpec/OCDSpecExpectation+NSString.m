#import "OCDSpecExpectation+NSString.h"

@implementation OCDSpecExpectation (NSString)

-(void) toBeEmptyString
{
    if (actualObject != @"") {
        [self failWithMessage: [NSString stringWithFormat: @"Expected empty string, but got \"%@\"", actualObject]];
    } 
}

@end
