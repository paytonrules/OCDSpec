#import <UIKit/UIKit.h>


@protocol Example
@property(readonly) BOOL failed;
@property(nonatomic, retain) NSFileHandle *outputter;

-(void) run;

@end
