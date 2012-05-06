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
        [OCDSpecFail fail:[NSString stringWithFormat:@"%b was expected to be true, but was false", actualObject] atLine:line inFile:file];
}

-(void) toBeFalse
{
    if ([actualObject boolValue]) {
        [OCDSpecFail fail:[NSString stringWithFormat:@"%b was expected to be false, but was true", actualObject] atLine:line inFile:file];
    }
}

-(void) toExist
{
    if (!actualObject)
        [OCDSpecFail fail:@"Object was expected to exist, but didn't"
                   atLine: line
                   inFile: file];
}

-(void) fail:(NSString *)errorFormat with:(id)expectedObject
{
    [OCDSpecFail fail:[NSString stringWithFormat:errorFormat, actualObject, expectedObject]
               atLine:line
               inFile:file];
}

@end
