## OCDSpec
### The Objective-C Unit Testing framework for the Obsessive Compulsive.  

OCDSpec is meant to be easy to setup, easy to use, and a joy to work with.  Inspired by both RSpec and Jasmine it has a friendly syntax that should easy to pick up for any developer familiar with BDD frameworks and uses Objective-C features rather than simply porting another XUnit.  A sample spec looks as follows:

<pre>
#import "OCDSpec/OCDSpec.h"

CONTEXT(OCDSpecExpectation)
{
    __block MockObjectWithEquals *actualObject;

    describe(@"toBe", 
            
             it(@"does not fail if the two objects are the same",
                ^{
                    actualObject = [[[MockObjectWithEquals alloc] init] autorelease];
                    
                    [expect(actualObject) toBe: actualObject];
                }),
             
             nil);
}
</pre>

This is taken out of OCDSpecExpectation - OCDSpec is tested in itself - and demonstrates your basic test.  Let's walk through the commands:

1.  `#import "OCDSpec/OCDSpec.h"` - Every test imports OCDSpec.h.
2.  `CONTEXT(OCDSpecExpectation)` - Each specification requires a context - the name of the context (in this case OCDSpecExpectation) must be unique. 
3.  `__block MockObjectWithEquals` - A variable that will be avalilable to all the descriptions in this context.  OCDSpec uses Objective-C closures, so if you want to modify an object in the any it blocks you need to prefix it with the `__block` directive.
4.  `describe(@"toBe"` - This is a description of what you are testing - it takes a string and is followed by it blocks. For the time being it only descriptive.
5.  `it(@"does not fail if the two objects are the same", - the beginning of an it "block."  `it` is actually a function that takes a string naming the intent of the spec, and an Objective-C block, and are called it blocks for short.  The Objective-C block is started with the ^{
6.  `[expect(actualObject) toBe: actualObject];` This is the assertion.   toBe means that actualObject should be the same as the expected object.  Important Note: The parameter to expect() **must** be an object so to use integers, booleans and other primitives they should be wrapped in a number.
7.  `nil` describe takes nil terminated array of it blocks, and as such must end with nil.

Command line runners exist for iOS and Mac development.  Development is very active, including adding templates and GUI test runners.

### Matchers

* __toBeEqualTo:__ Check that two objects are equal, using the equalTo message.
* __toBe:__ Check that two objects are the same object in memory.
* __toBeTrue:__ Check that the value is "truthy" - TRUE, YES, true, non-zero, not nil.  You can also just use `expectTruth` such as `expectTruth([object initialized])`
* __toBeFalse:__ Check that the value is "falsy" - FALSE, NO, false and nil.  You can use `expectFalse`.  Both `expectTruth` and `expectFalse` can be used without turning the boolean into an object.
* __FAIL__ Pass the Fail macro a string to fail arbitrarily.  Handy for exception testing.

### Requirements

* Objective-C 2.0 (for blocks)
* XCode 4.0 (for debugging blocks)
* A developer that cares

### Setup

The templates for XCode are highly recommended, and will get you up and running with OCDSpec extremely quickly.  They can be downloaded here:

http://github.com/paytonrules/OCDSpec-Templates

### Bleeding Edge Setup 

If you want the latest and greatest version of OCDSpec you can use the bleeding edge setup, but I warn you, it's not easy.

http://github.com/paytonrules/OCDSpec/wiki/Bleeding-Edge-Setup-iOS

### Upcoming Features

In a rough order:
* More obvious successes.
* beforeEach and afterEach
* NOT for checking that something is not expected
* Automatic memory leak detection

### Debugging

Building the project runs the shell script for a command line runner, but if you need to debug the project it is a runnable executable and you can set breakpoints. 

### Contribution Guide ###

Clone the repo, make a pull request.  I will not accept features without tests.

### Contributors
* [skim] (http://github.com/sl4m)  Who has helped with directions.
* [Eric Meyer] (http://github.com/ericmeyer) Who wrote expectFalse.

### Issues

OCDSpec uses GitHub issues for issue tracking.  Use it!

### License

Copyright (C) 2012 Eric Smith All Rights Reserved.

Distributed under the The MIT License.
