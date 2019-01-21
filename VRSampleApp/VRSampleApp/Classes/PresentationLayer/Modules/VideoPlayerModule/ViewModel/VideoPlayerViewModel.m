//
//  VideoPlayerViewModel.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "VideoPlayerViewModel.h"
#import "VideoItem.h"

@interface VideoPlayerViewModel ()

extern NSString *kLogFileName;

@end


@implementation VideoPlayerViewModel

#pragma mark - Constants

NSString *kLogFileName = @"ooyalaDebugLog.log";

#pragma mark - Initialization

- (instancetype)initWithVideoItem:(VideoItem *)videoItem
                            pcode:(NSString *)pcode
                           domain:(NSString *)domain
                 andQAModeEnabled:(BOOL)QAModeEnabled {
  if (self = [super init]) {
    _videoItem = videoItem;
    _pcode = pcode;
    _domain = domain;
    _QAModeEnabled = QAModeEnabled;
  }
  
  [self removeLogFileWithName:kLogFileName];
  
  return self;
}

#pragma mark - Public functions

- (void)debugPrint:(NSString *)debugString {
  NSString *logFilePath = [self pathToLogFileWithName:kLogFileName];
  NSString *dump = @"";
  NSError *error;
  
  if ([NSFileManager.defaultManager fileExistsAtPath:logFilePath]) {
    dump = [NSString stringWithContentsOfFile:logFilePath encoding:NSUTF8StringEncoding error:&error];
  }
  
  dump = [NSString stringWithFormat:@"%@ :::::::::: %@", dump, debugString];
  // Write to the file
  [dump writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
  
  if (error) {
    NSLog(@"Failed writing to log file: %@, Error: ", error.localizedDescription);
  }
}

#pragma mark - Private functions

- (NSString *)pathToLogFileWithName:(NSString *)fileName {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths firstObject];
  
  return [documentsDirectory stringByAppendingPathComponent:fileName];
}

- (void)removeLogFileWithName:(NSString *)fileName {
  NSString *logFilePath = [self pathToLogFileWithName:fileName];
  NSFileManager *fileManager = NSFileManager.defaultManager;
  
  if ([fileManager fileExistsAtPath:logFilePath]) {
    [fileManager removeItemAtPath:logFilePath error:NULL];
  }
}

@end
