//
//  VideoItemSection.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "VideoItemSection.h"

@implementation VideoItemSection

#pragma mark - Initialization

- (instancetype)initWithVideoItems:(NSArray *)videoItems andTitle:(NSString *)title {
  if (self = [super init]) {
    _videoItems = videoItems;
    _title = title;
  }
  
  return self;
}

@end
