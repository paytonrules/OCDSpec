## OCDSpec

The Objective-C Unit Testing framework for the Obsessive Compulsive.  OCDSpec is a Unit Test framework that is meant to be easy to setup, easy to use, and a joy to work with.  Inspired by both RSpec and Jasmine it has a friendly syntax that should easy to pick up for any developer familiar with BDD frameworks and uses Objective-C features rather than simply porting another XUnit.  A sample spec looks as follows:

########  INSERT COOL STUFF HERE ####################### 

### Requirements

Objective-C 2.0 (for blocks)
XCode 4.0 (for debugging blocks)
A developer that cares

### Setup ###

For the latest release install the template here:

### Bleeding Edge Setup ###

This setup applies to iOS projects, that use git as a repository.  If you cannot use git (so sorry) you can download OCDSpec instead of installing it as a submodule, but then you will not get the latest updates unless you redownload, and if that's the case you might as well just use the provided release templates.

1.  Create your project using XCode.
    
    Or use an existing one. Do not check the "Use Unit Tests" button.
2.  Initialize it as a git repository.
3.  Use git to install OCDSpec as a submodule:

    <pre>
        git submodule add git://github.com/paytonrules/OCDSpec.git
    </pre>
    Alternatively you may want to fork OCDSpec so that you can contribute patches.
4.  Create a new iOS target - use the Window based app since we'll be deleting everything anyway.  Again do NOT click Add Unit Tests.  This is where our specs and OCDSpec will go, so call it something nice like "Specs".
5.  Remove the iPhone and iPad directories it created.  Remove the plist file, the strings, the main.m.  Anything that app generated - kill it.
6.  Assuming that OCDSpec was cloned into ${SOURCE_ROOT}/OCDSpec then add OCDSpec/OCDSpec to your project (in the Specs group), but do not include the subdirectories.  Make sure you only add the files to the Specs target. Do not copy items into the groups folder.
7.  Add UnitTestMain.m from OCDSpec/OCDSpec/Programs.
8.  In your Target's Build Settings change the Prefix Header to ${SDKROOT}/System/Library/Frameworks/UIKit.framework/Headers/UIKit.h
9.  Remove the plist file from the Info.plist entry
10. Set the Header Search Paths to ${SRCROOT}/OCDSpec 
11. Make sure your target is linked to UIKit and Foundation
12. Add a Run Script build phase to your target.  In the script window add:

./OCDSpec/OCDSpec/Programs/RunIPhoneUnitTest.sh

13. Build the project and look in the log nagivator.  You should see a message like: 

<img src="https://img.skitch.com/20110528-f6r1d914qe5a8s28du6ssqcsbb.jpg" alt="StringCalculator" />

### Debugging ###

Coming Soon.

### Contribution Guide ###

Ditto

### Issues ###

OCDSpec uses GitHub issues for issue tracking.  Use it!