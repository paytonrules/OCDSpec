#import "OCDSpecShouldObject.h"
#import "OCDSpec/OCDSpecFail.h"

@implementation OCDSpecShouldObject

-(id) initWithObject:(id) object andLineNumber:(int) lineNumber
{
    self = [super init];
    if (self) {
        actualObject = object;
        [actualObject retain];
    }
    
    return self;
}

-(void) beEqualTo:(id) expectedObject
{
    if (![actualObject isEqual:expectedObject])
        FAIL(@"Error");
}

-(void) dealloc
{
    [actualObject release];
    [super dealloc];
}

@end
