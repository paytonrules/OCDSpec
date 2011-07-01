## OCDSpec

The Objective-C Unit Testing framework for the Obsessive Compulsive.  OCDSpec is a Unit Test framework that is meant to be easy to setup, easy to use, and a joy to work with.  Inspired by both RSpec and Jasmine it has a friendly syntax that should easy to pick up for any developer familiar with BDD frameworks and uses Objective-C features rather than simply porting another XUnit.  A sample spec looks as follows:

########  INSERT COOL STUFF HERE #######################

### Requirements

* Objective-C 2.0 (for blocks)
* XCode 4.0 (for debugging blocks)
* A developer that cares

### Setup

Templates for XCode are in development that make this much much easier.  They are recommended when finished.

### Bleeding Edge Setup (not so friendly right now)

This setup applies to iOS projects, that use git as a repository.  If you cannot use git (so sorry) you can download OCDSpec instead of installing it as a submodule, but then you will not get the latest updates unless you redownload, and if that's the case you might as well just use the provided release templates (once they're available).

1.  Create your project in XCode.  Be sure to uncheck the `Include Unit Tests` checkbox.

    Or use an existing project (you may need to delete `<projectName>Test` directory in Project Navigator as well as `<projectName>Test` target in Project Editor).
2.  Initialize it as a git repository (if not already done).
3.  Use git to install OCDSpec as a submodule:

    `git submodule add git://github.com/paytonrules/OCDSpec.git`

    You will update OCDSpec in your project by running this command:

    `git submodule update`
4.  Create a new iOS target; use the Window-based application template since we'll be deleting everything anyway.  Again do NOT check `Include Unit Tests`.  This is where our specs and OCDSpec will go, so call it something nice like "Specs".
5.  This will have created a group directory called "Specs" (or however you named it).  Delete everything from this group directory (e.g., iPhone, iPad, delegate files) and everything in Supporting Files directory EXCEPT the "Specs-Prefix.pch" file.
6.  Assuming that OCDSpec was added as a submodule (or cloned into `${SOURCE_ROOT}/OCDSpec`), right-click the "Specs" group directory and select `Add Files to <projectName>...`.  Navigate to the submodule, and only select the files.  Do not select Protocols and Programs directories.  Do not check `Copy items into destination group's folder (if needed)`.  Make sure to check "Specs" under `Add to targets` and uncheck `<projectName>` target.
7.  Repeat Step 6, but add `unitTestMain.m` from OCDSpec/OCDSpec/Programs.
8.  In the "Specs" target Build Settings tab, change the `Info.plist File` exactly to an empty string.  Use the search field to find this setting.
9.  Do another search for `Header Search Paths` and change the value exactly to `${SRCROOT}/OCDSpec`
10. Go to the Build Phases tab and make sure UIKit.framework and Foundation.framework appear in the `Link Binary With Libraries` section.
11. In the same tab, click the `Add Build Phase` button and select `Add Run Script`.  Expand the Run Script section and add the following to the area where it says "Type a script or drag a script file from your workspace":

`./OCDSpec/OCDSpec/Programs/RunIPhoneUnitTest.sh`

12. Build the project by selecting Specs | iPhone 4.3 Simulator or Specs | iPad 4.3 Simulator in the Scheme drop-down and navigate to Product -> Build (or Command+B).  Now look in the log navigator (Command+7).  You should see a message like:

<img src="https://img.skitch.com/20110528-f6r1d914qe5a8s28du6ssqcsbb.jpg" alt="StringCalculator" />

### Debugging ###

Coming Soon.

### Contribution Guide ###

Ditto

### Contributors ###
* [skim] (http://github.com/sl4m)

### Issues ###

OCDSpec uses GitHub issues for issue tracking.  Use it!
