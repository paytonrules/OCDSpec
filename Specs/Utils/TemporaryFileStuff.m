/*
 *  TemporaryFileStuff.m
 *  CubicleWars
 *
 *  Created by Eric Smith on 1/3/11.
 *  Copyright 2011 8th Light. All rights reserved.
 *
 */

#import "OCDSpec/OCDSpecOutputter+RedirectOutput.h"
#include "TemporaryFileStuff.h"

NSFileHandle *GetTemporaryFileHandle()
{
  NSFileManager *fileManager = [[NSFileManager alloc] init];
  [fileManager createFileAtPath:[OCDSpecOutputter temporaryDirectory] contents:nil attributes:nil];
  [fileManager release];
  NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:[OCDSpecOutputter temporaryDirectory]]; 
  return fileHandle;
}
