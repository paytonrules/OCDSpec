#import <Foundation/Foundation.h>

@interface OCDSpecSuiteRunner : NSObject
{
  Class         *classes;
  int           classCount;
  int           successes;
  int           failures;
}

@property(assign) id baseClass;
@property(readonly) int successes;
@property(readonly) int failures;

-(void) runAllDescriptions;
@end