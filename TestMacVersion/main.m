#import <Foundation/Foundation.h>
#import "OCDSpec/OCDSpecDescriptionRunner.h"

int main (int argc, const char * argv[])
{

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    OCDSpecDescriptionRunner *runner = [[[OCDSpecDescriptionRunner alloc] init] autorelease];
    
    [runner runAllDescriptions];

    [pool drain];
    return 0;
}

