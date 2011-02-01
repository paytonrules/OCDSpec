#import <Foundation/Foundation.h>`
#import "OCDSpec/Protocols/Example.h"

@interface OCDSpecExample : NSObject<Example>
{
  BOOL          failed;
  id            itsExample;
  NSFileHandle  *outputter;
}

@property(readonly) BOOL failed;
-(void) run;
-(id) initWithBlock:(void (^)(void))example;

@end

#define IT(description, example) [[OCDSpecExample alloc] initWithBlock:example]
OCDSpecExample *it(NSString *description, void (^example)(void));