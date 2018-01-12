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
  self = [super init];
  
  if (self) {
    self.videoItems = videoItems;
    self.title = title;
  }
  
  return self;
}

@end
