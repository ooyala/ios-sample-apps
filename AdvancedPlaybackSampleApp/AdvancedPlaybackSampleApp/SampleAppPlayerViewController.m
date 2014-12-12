//
//  SampleAppPlayerViewController.m
//  AdvancedPlaybackSampleApp
//
//  Created by Michael Len on 12/11/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SampleAppPlayerViewController.h"

@implementation SampleAppPlayerViewController
- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super init];
  if (self) {
    self.playerSelectionOption = playerSelectionOption;
  }
  return self;
}
@end
