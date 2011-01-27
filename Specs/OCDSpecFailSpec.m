#import "OCDSpec/OCDSpec.h"

DESCRIBE(OCDSpecFail,
         IT(@"Has a failure assertion", 
            ^{
              @try
              {
                [OCDSpecFail fail:@"Dude" atLine:1 inFile:@"file"];
                FAIL(@"Did not fail - in fail");
              }
              @catch (NSException *e) 
              {
                if ([e reason] != @"Dude")
                  [e raise];
              }
            }),
         
         IT(@"Has a failure maco",
            ^{
              @try 
              {
                FAIL(@"FAIL HERE");
                [OCDSpecFail fail:@"Should have failed, didn't" atLine:1 inFile:@"file"];
              }
              @catch (NSException * e) 
              {
                if ([e reason] != @"FAIL HERE")
                  [e raise];
              }
            })
         )