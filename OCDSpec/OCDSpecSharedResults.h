#import <Foundation/Foundation.h>

@interface OCDSpecSharedResults : NSObject 
{
  NSNumber *failures;
  NSNumber *successes;
}

@property(nonatomic, retain) NSNumber *failures;
@property(nonatomic, retain) NSNumber *successes;
+(OCDSpecSharedResults *)sharedResults;
-(BOOL) equalTo:(OCDSpecSharedResults *)otherResults;
@end
