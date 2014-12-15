//
//  UIView+PlayerSelectionOption.m
//  AdvancedPlaybackSampleApp
//
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import "PlayerSelectionOption.h"

@implementation PlayerSelectionOption

- (id)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode viewController:(Class) viewController {
  self = [super init];
  if (self) {
    self.title = title;
    self.embedCode = embedCode;
    self.viewController = viewController;
  }
  return self;
}
@end
