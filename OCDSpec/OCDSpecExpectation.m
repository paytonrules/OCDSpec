#import "OCDSpecExpectation.h"
#import "OCDSpec/OCDSpecFail.h"

@interface OCDSpecExpectation(private)
-(void) fail:(NSString *)errorFormat with: (id) expectedObject;
@end

@implementation OCDSpecExpectation

@synthesize line, file;

-(id) initWithObject:(id) object inFile:(NSString*) fileName atLineNumber:(int) lineNumber
{
    if ((self = [super init])) {
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

-(void) toBeTrue
{
    if (![actualObject boolValue])
        [self failWithMessage:[NSString stringWithFormat:@"%b was expected to be true, but was false", actualObject]];
}

-(void) toBeFalse
{
    if ([actualObject boolValue])
        [self failWithMessage:[NSString stringWithFormat:@"%b was expected to be false, but was true", actualObject]];
}

-(void) fail:(NSString *)errorFormat with:(id)expectedObject
{
    [self failWithMessage:[NSString stringWithFormat:errorFormat, actualObject, expectedObject]];
}

-(void) failWithMessage:(NSString *)message
{
    [OCDSpecFail fail: message
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
