#import <Foundation/Foundation.h>

@class OCDSpecExample; 

@interface OCDSpecDescription : NSObject 
{
  int         failures;
  int         successes;
  NSArray     *itsExamples;
  NSString    *itsName;
}

@property(assign) int failures;
@property(assign) int successes;

// NOTE - this describe is probably deletable!
-(void) describe:(NSString *)name onArrayOfExamples:(NSArray *) examples;

-(void) describe;
-(id) initWithName:(NSString *) name examples:(NSArray *)examples;

@end

// Test me (explicitly) and get me into an implementation file
void describe(NSString *description,  ...);