//
//  OCDSpecSharedResults.h
//  OCDSpec
//
//  Created by Eric Smith on 4/4/11.
//  Copyright 2011 8th Light. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OCDSpecSharedResults : NSObject 
{
  int failures;
  int successes;
}

@property(assign) int failures;
@property(assign) int successes;
+(OCDSpecSharedResults *)sharedResults;
-(BOOL) equalTo:(OCDSpecSharedResults *)otherResults;
@end
