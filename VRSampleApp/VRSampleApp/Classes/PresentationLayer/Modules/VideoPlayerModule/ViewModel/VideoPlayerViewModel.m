//
//  VideoPlayerViewModel.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "VideoPlayerViewModel.h"


@implementation VideoPlayerViewModel

#pragma mark - Initialization

- (instancetype)initWithVideoItem:(VideoItem *)videoItem
                            pcode:(NSString *)pcode
                           domain:(NSString *)domain
                 andQAModeEnabled:(BOOL)QAModeEnabled {
  self = [super init];
  
  if (self) {
    self.videoItem = videoItem;
    self.pcode = pcode;
    self.domain = domain;
    self.QAModeEnabled = QAModeEnabled;
  }
  
  return self;
}


@end
