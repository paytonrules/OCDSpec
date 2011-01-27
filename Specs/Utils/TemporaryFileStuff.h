/*
 *  TemporaryFileStuff.h
 *  CubicleWars
 *
 *  Created by Eric Smith on 1/3/11.
 *  Copyright 2011 8th Light. All rights reserved.
 *
 */
#import <Foundation/Foundation.h>

NSString *OutputterPath();
NSFileHandle *GetTemporaryFileHandle();
NSString *ReadTemporaryFile();
void DeleteTemporaryFile();