#import "OCDSpecShouldObject.h"

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
    [actualObject isEqual:expectedObject];
}

-(void) dealloc
{
    [actualObject release];
    [super dealloc];
}

@end
