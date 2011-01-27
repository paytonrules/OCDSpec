/*
 *  TemporaryFileStuff.m
 *  CubicleWars
 *
 *  Created by Eric Smith on 1/3/11.
 *  Copyright 2011 8th Light. All rights reserved.
 *
 */

#include "TemporaryFileStuff.h"

NSString *OutputterPath()
{
  return [NSTemporaryDirectory() stringByAppendingPathComponent:@"test.txt"];
}

NSFileHandle *GetTemporaryFileHandle()
{
  NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
  [fileManager createFileAtPath:OutputterPath() contents:nil attributes:nil];
  NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:OutputterPath()]; 
  return fileHandle;
}

NSString *ReadTemporaryFile()
{
  NSFileHandle *inputFile = [NSFileHandle fileHandleForReadingAtPath:OutputterPath()];
  return [[[NSString alloc] initWithData:[inputFile readDataToEndOfFile] 
                                encoding:NSUTF8StringEncoding] autorelease];
}

void DeleteTemporaryFile()
{
  NSString *outputterPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"test.txt"];
  NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
  [fileManager removeItemAtPath:outputterPath error:NULL];
}
