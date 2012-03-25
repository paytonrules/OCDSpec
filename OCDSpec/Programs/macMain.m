#import <Foundation/Foundation.h>
#import "OCDSpecSuiteRunner.h"

int main(int argc, const char *argv[]) {
  OCDSpecSuiteRunner *runner = [[OCDSpecSuiteRunner alloc] init];

  @autoreleasepool
  {
    [runner runAllDescriptions];
  }

  return 0;
}

