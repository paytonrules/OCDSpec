#import <Foundation/Foundation.h>
#import "Example.h"

@interface OCSpecExample : NSObject<Example>
{
  BOOL          failed;
  id            itsExample;
  NSFileHandle  *outputter;
}

@property(readonly) BOOL failed;
-(void) run;
-(id) initWithBlock:(void (^)(void))example;

@end


#define IT(description, example) [[OCSpecExample alloc] initWithBlock:example]