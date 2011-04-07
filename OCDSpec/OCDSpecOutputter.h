#import <Foundation/Foundation.h>

@interface OCDSpecOutputter : NSObject 
{
  NSFileHandle *fileHandle;
}

+(OCDSpecOutputter*) sharedOutputter;
-(void) writeMessage:(NSString *)message;
@property(nonatomic, retain) NSFileHandle *fileHandle;

@end
