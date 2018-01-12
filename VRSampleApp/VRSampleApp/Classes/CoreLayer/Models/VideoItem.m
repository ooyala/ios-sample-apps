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
  self = [super init];
  
  if (self) {
    self.embedCode = embedCode;
    self.title = title;
    self.videoAdType = UNKNOWN;
  }
  
  return self;
}


@end
