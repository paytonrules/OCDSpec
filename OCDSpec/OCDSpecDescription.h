#import <Foundation/Foundation.h>

@class OCDSpecExample; 

@interface OCDSpecDescription : NSObject 
{
  NSInteger     errors;
  NSInteger     successes;
  NSArray       *itsExamples;
  NSString      *itsName;
}

@property(assign) NSInteger errors;
@property(assign) NSInteger successes;

// NOTE - this describe is probably deletable!
-(void) describe:(NSString *)name onArrayOfExamples:(NSArray *) examples;

-(void) describe;
-(id) initWithName:(NSString *) name examples:(NSArray *)examples;

@end

// Test me (explicitly) and get me into an implementation file
void describe(NSString *description,  ...);