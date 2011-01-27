#import <Foundation/Foundation.h>

@interface OCSpecDescription : NSObject 
{
  NSInteger     errors;
  NSInteger     successes;
  NSFileHandle  *outputter;
  NSArray       *itsExamples;
  NSString      *itsName;
}

@property(assign) NSInteger errors;
@property(assign) NSInteger successes;
@property(nonatomic, retain) NSFileHandle *outputter;
// NOTE - this describe is probably deletable!
-(void) describe:(NSString *)name onArrayOfExamples:(NSArray *) examples;
-(void) describe;
-(id) initWithName:(NSString *) name examples:(NSArray *)examples;

@end

                                      
