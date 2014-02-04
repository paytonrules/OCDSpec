#import <Foundation/Foundation.h>
#import "OCDSpecSuiteRunner.h"

int main(int argc, const char *argv[]) {
  OCDSpecSuiteRunner *runner = [[OCDSpecSuiteRunner alloc] init];

  int failures;

  @autoreleasepool
  {
    [runner runAllDescriptions];
    failures = [runner failures];
  }

  return failures;
}

