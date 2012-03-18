#import <Foundation/Foundation.h>
#import "OCDSpecSuiteRunner.h"

int main (int argc, const char * argv[])
{

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    OCDSpecSuiteRunner *runner = [[[OCDSpecSuiteRunner alloc] init] autorelease];
    
    [runner runAllDescriptions];

    [pool drain];
    return 0;
}

