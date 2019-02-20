//
//  IMAVideoPlayerViewController.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "IMAVideoPlayerViewController.h"
#import <OoyalaIMASDK/OOIMAManager.h>
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>

@interface IMAVideoPlayerViewController ()

@property (nonatomic) OOIMAManager *adsManager;

@end


@implementation IMAVideoPlayerViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self configureIMAObjects];
}

#pragma mark - Private functions

- (void)configureIMAObjects {
  // Create ADS manager
  self.adsManager = [[OOIMAManager alloc] initWithOoyalaPlayer:self.skinController.player];
}

@end
