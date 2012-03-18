#import <Foundation/Foundation.h>
#import "OCDSpec/Protocols/DescriptionRunner.h"
#import "OCDSpec/OCDSpecDescription.h"
#import "OCDSpec/OCDSpecSharedResults.h"
#import "OCDSpecDescriptionRunner.h"

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