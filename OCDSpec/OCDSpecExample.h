#import <Foundation/Foundation.h>
#import "OCDSpec/Protocols/Example.h"

@interface OCDSpecExample : NSObject<Example>
{
  BOOL          failed;
  id            itsExample;
}

@property(readonly) BOOL failed;
-(void) run;
-(id) initWithBlock:(void (^)(void))example;

@end
OCDSpecExample *it(NSString *description, void (^example)(void));