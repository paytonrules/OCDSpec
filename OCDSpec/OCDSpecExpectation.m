#import "OCDSpecExpectation.h"
#import "OCDSpec/OCDSpecFail.h"

@interface OCDSpecExpectation(private)
-(void) fail:(NSString *)errorFormat with: (id) expectedObject;
@end

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
        [self fail:@"%@ was expected to be equal to %@, and isn't" with:expectedObject];
}

-(void) toBe:(id) expectedObject
{
    if (actualObject != expectedObject)
        [self fail:@"%@ was expected to be the same object as %@, but wasn't" with:expectedObject];
}

-(void) fail:(NSString *)errorFormat with:(id)expectedObject
{
    [OCDSpecFail fail:[NSString stringWithFormat:errorFormat, actualObject, expectedObject]
               atLine:line
               inFile:file];
}

-(void) dealloc
{
    [actualObject release];
    [file release];
    [super dealloc];
}

@end
