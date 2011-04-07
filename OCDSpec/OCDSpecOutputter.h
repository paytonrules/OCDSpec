#import <Foundation/Foundation.h>

@interface OCDSpecOutputter : NSObject 
{
  NSFileHandle *fileHandle;
}

+(OCDSpecOutputter*) sharedOutputter;
-(void) writeData:(NSString *)data;
@property(nonatomic, retain) NSFileHandle *fileHandle;

@end
