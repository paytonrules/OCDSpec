#import <UIKit/UIApplication.h>
#import "OCDSpecSuiteRunner.h"

@interface TestClass : NSObject
{
}

@end

@implementation TestClass

-(void) applicationDidFinishLaunching:(UIApplication *)app
{
  int failures;
  OCDSpecSuiteRunner *runner = [[OCDSpecSuiteRunner alloc] init];

  @autoreleasepool
  {
    [runner runAllDescriptions];
    failures = runner.failures;
    exit(failures);
  }
}

@end

int main(int argc, char *argv[]) {
  UIApplicationMain(argc, argv, nil, @"TestClass");
  return 0;
}
