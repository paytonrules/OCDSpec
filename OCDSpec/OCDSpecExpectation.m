#import "OCDSpecExpectation.h"
#import "OCDSpec/OCDSpecFail.h"

@implementation OCDSpecExpectation

@synthesize line, file;

-(id) initWithObject:(id) object inFile:(NSString*) fileName atLineNumber:(int) lineNumber
{
    self = [super init];
    if (self) {
        actualObject = object;
        line = lineNumber;
        file = fileName;
        [file retain];
        [actualObject retain];
    }
    
    return self;
}

-(void) toBeEqualTo:(id) expectedObject
{
    if (![actualObject isEqual:expectedObject])
    {
        [OCDSpecFail fail:[NSString stringWithFormat:@"%@ was expected to be equal to %@, and isn't", actualObject, expectedObject] 
                   atLine:line 
                   inFile:file];
    }
}

-(void) dealloc
{
    [actualObject release];
    [file release];
    [super dealloc];
}

@end
