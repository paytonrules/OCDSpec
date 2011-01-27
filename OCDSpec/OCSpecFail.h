//
//  OCSpecFail.h
//  CubicleWars
//
//  Created by Eric Smith on 10/24/10.
//  Copyright 2010 8th Light. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OCSpecFail : NSObject
{

}

+(void) fail:(NSString*)reason atLine:(NSInteger) line inFile: (NSString *)file;

@end

#define FAIL(reason) [OCSpecFail fail:reason atLine: __LINE__ inFile: [NSString stringWithUTF8String: __FILE__]]
