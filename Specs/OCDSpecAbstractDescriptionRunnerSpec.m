#import "OCDSpec/OCDSpec.h"
#import "OCDSpec/Abstract/OCDSpecAbstractDescriptionRunner.h"

static BOOL descriptionWasRun = false;

void testDescription(void)
{
  descriptionWasRun = true;
}

CONTEXT(OCDSpecAbstractDescriptionRunner)
{
  describe(@"AbstractDescriptionRunner",
          it(@"runs the passed in C function", ^{
            OCDSpecAbstractDescriptionRunner *runner = [[[OCDSpecAbstractDescriptionRunner alloc] init] autorelease];

            [runner runDescription:testDescription];

            expectTruth(descriptionWasRun);
          }),

          nil
  );
}