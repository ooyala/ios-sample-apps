//
//  VideoItem.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "VideoItem.h"

@implementation VideoItem

#pragma mark - Initialization

- (instancetype)initWithEmbedCode:(NSString *)embedCode andTitle:(NSString *)title; {
  if (self = [super init]) {
    _embedCode = embedCode;
    _title = title;
    _videoAdType = UNKNOWN;
  }
  
  return self;
}


@end
