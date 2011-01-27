#import <Foundation/Foundation.h>
#import "Example.h"

@interface MockExample : NSObject<Example>
{
  BOOL failed;
}

@property(assign) BOOL failed;
+(MockExample*) exampleThatFailed;
-(void) run;

@end
