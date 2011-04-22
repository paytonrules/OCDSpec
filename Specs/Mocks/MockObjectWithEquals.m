#import "MockObjectWithEquals.h"

@implementation MockObjectWithEquals
@synthesize expected;

-(id) init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(BOOL) isEqual:(id) object
{
    self.expected = object;
    return TRUE;
}

-(void) dealloc
{
    [expected release];
    [super dealloc];
}

@end
