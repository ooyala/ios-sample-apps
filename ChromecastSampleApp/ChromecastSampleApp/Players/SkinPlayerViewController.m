//
//  SkinPlayerViewController.m
//  ChromecastSampleApp
//
//  Created on 4/2/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#import "SkinPlayerViewController.h"

#import <OoyalaSkinSDK/OoyalaSkinSDK.h>
#import <OoyalaSDK/OoyalaSDK.h>

#import "ChromecastPlayerSelectionOption.h"

@interface SkinPlayerViewController ()

@property (nonatomic) OOSkinViewController *skinController;
@property (nonatomic) ChromecastPlayerSelectionOption *mediaInfo;

@end

@implementation SkinPlayerViewController

#pragma mark - Initialization

- (instancetype)initWithPlayerSelectionOption:(ChromecastPlayerSelectionOption *)playerSelectionOption {
  if (self = [super init]) {
    _mediaInfo = playerSelectionOption;
    self.title = playerSelectionOption.title;
    NSLog(@"%@s", playerSelectionOption.domain);
  }
  return self;
}

@end
