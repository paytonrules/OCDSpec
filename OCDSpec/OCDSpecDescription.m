#import "OCDSpec/OCDSpecDescription.h"
#import "OCDSpec/OCDSpecExample.h"
#import "OCDSpec/OCDSpecSharedResults.h"

@interface OCDSpecPostCondition : NSObject {
@private
    VOIDBLOCK condition;
}
@property(readwrite, copy) VOIDBLOCK condition;
@end

@implementation OCDSpecPostCondition

@synthesize condition;

@end

void describe(NSString *descriptionName, ...)
{
    va_list         variableArgumentList;
    id              example;
    NSMutableArray  *exampleList = [NSMutableArray arrayWithCapacity:20];
    VOIDBLOCK       precondition = ^{};
    VOIDBLOCK       postcondition = ^{};
    
    va_start(variableArgumentList, descriptionName);
    while ((example = va_arg(variableArgumentList, id) ) )
    {
        if([example isKindOfClass:[OCDSpecExample class]])
        {
            [exampleList addObject: example];    
        }
        else if([example isKindOfClass:[OCDSpecPostCondition class]])
        {
            postcondition = ((OCDSpecPostCondition *) example).condition;
        }
        else
        {
            precondition = example;
        }
        
    }
    va_end(variableArgumentList);
    
    OCDSpecDescription *description = [[[OCDSpecDescription alloc] initWithName:descriptionName examples:exampleList] autorelease];
    description.precondition = precondition;
    description.postcondition = postcondition;
    [description describe];
    
    OCDSpecSharedResults *results = [OCDSpecSharedResults sharedResults];
    results.successes = description.successes;
    results.failures = description.failures;
}

VOIDBLOCK beforeEach(VOIDBLOCK precondition)
{
    return precondition;
}

OCDSpecPostCondition *afterEach(VOIDBLOCK postcondition)
{
    OCDSpecPostCondition * cond = [[[OCDSpecPostCondition alloc] init] autorelease];
    cond.condition = postcondition;
    
    return cond;
}

@implementation OCDSpecDescription

@synthesize failures, successes, precondition, postcondition;

-(id) init
{
    if ((self = [super init]))
    {
        successes = [NSNumber numberWithInt:0];
        failures = [NSNumber numberWithInt:0];
        precondition = postcondition = ^{};
    }
    
    return self;
}

-(id) initWithName:(NSString *) name examples:(NSArray *)examples
{
    if ((self = [self init]))
    {
        itsExamples = examples;
        itsName = name;
    }
    return self;
}

-(void) describe:(NSString *)name onArrayOfExamples:(NSArray *)examples
{
    itsExamples = examples;
    itsName = name;
    [self describe];
}

-(void) describe
{
    // Write the name here
    [itsExamples enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop)
     {
         OCDSpecExample *example = (OCDSpecExample *) obj;
         
         precondition();
         [example run];
         if (example.failed)
         {
             self.failures = [NSNumber numberWithInt:[failures intValue] + 1];
         }
         else 
         {
             self.successes = [NSNumber numberWithInt:[successes intValue] + 1];
         }
         postcondition();
     }];
}

// TEST DEALLOC

@end
