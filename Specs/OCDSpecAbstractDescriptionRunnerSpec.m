#import "OCDSpec/OCDSpec.h"
#import "OCDSpecDescriptionRunner.h"

static BOOL descriptionWasRun = false;

void testDescription(void)
{
  descriptionWasRun = true;
}

CONTEXT(OCDSpecDescriptionRunner)
{
  describe(@"AbstractDescriptionRunner",
          it(@"runs the passed in C function", ^{
            OCDSpecDescriptionRunner *runner = [[[OCDSpecDescriptionRunner alloc] init] autorelease];

            [runner runDescription:testDescription];

            expectTruth(descriptionWasRun);
          }),

          nil
  );
}