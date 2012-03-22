#import <Foundation/Foundation.h>

@interface OCDSpecSuiteRunner : NSObject
{
  Class         *classes;
  int           classCount;
  id            baseClass;
  int           successes;
  int           failures;
}

@property(nonatomic, assign) id baseClass;
@property(readonly) int successes;
@property(readonly) int failures;

-(void) runAllDescriptions;
@end