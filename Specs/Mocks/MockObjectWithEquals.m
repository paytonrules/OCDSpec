#import "MockObjectWithEquals.h"

@implementation MockObjectWithEquals
@synthesize expected;

-(id) init
{
    self = [super init];
    if (self) {
        equal = TRUE;
    }
    
    return self;
}

-(id) initAsNotEqual
{
    self = [super init];
    if (self) {
        equal = FALSE;
    }
    
    return self;    
}

-(BOOL) isEqual:(id) object
{
    self.expected = object;
    return equal;
}

@end
