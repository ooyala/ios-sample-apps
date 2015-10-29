//
//  FreewheelPlayerViewController.m
//  OoyalaSkinSampleApp
//
//  Created by Zhihui Chen on 7/27/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "FreewheelPlayerViewController.h"
#import <OoyalaFreewheelSDK/OOFreewheelManager.h>
#import <OoyalaSkinSDK/OOSkinViewController.h>
#import <OoyalaSkinSDK/OOSkinOptions.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSDK/OOOptions.h>
#import <OoyalaSDK/OODiscoveryOptions.h>


@interface FreewheelPlayerViewController ()

@property (nonatomic, retain) OOSkinViewController *skinController;
@property (nonatomic) OOFreewheelManager *adsManager;
@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;

@end


@implementation FreewheelPlayerViewController

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];

  if (self.playerSelectionOption) {
    self.nib = self.playerSelectionOption.nib;
    self.embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
    self.playerDomain = playerSelectionOption.playerDomain;
    self.pcode = playerSelectionOption.pcode;
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Create Ooyala ViewController
  // Create Ooyala ViewController
  OOOptions *options = [OOOptions new];
  OOOoyalaPlayer *ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] options:options];
  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular limit:10 timeout:60];
    NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
//  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle"];
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions jsCodeLocation:jsCodeLocation configFileName:@"skin" overrideConfigs:nil];

  self.skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaPlayer skinOptions:skinOptions parent:_videoView launchOptions:nil];
  [self addChildViewController:_skinController];
  [_skinController.view setFrame:self.videoView.bounds];
  [ooyalaPlayer setEmbedCode:self.embedCode];


  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:ooyalaPlayer];

  self.adsManager = [[OOFreewheelManager alloc] initWithOoyalaPlayer:ooyalaPlayer];

  NSMutableDictionary *fwParameters = [[NSMutableDictionary alloc] init];
  //[fwParameters setObject:@"90750" forKey:@"fw_ios_mrm_network_id"];
  [fwParameters setObject:@"http://g1.v.fwmrm.net/" forKey:@"fw_ios_ad_server"];
  [fwParameters setObject:@"90750:ooyala_ios" forKey:@"fw_ios_player_profile"];
  [fwParameters setObject:@"channel=TEST;subchannel=TEST;section=TEST;mode=online;player=ooyala;beta=n" forKey:@"FRMSegment"];
  //[fwParameters setObject:@"ooyala_test_site_section" forKey:@"fw_ios_site_section_id"];
  //[fwParameters setObject:@"ooyala_test_video_with_bvi_cuepoints" forKey:@"fw_ios_video_asset_id"];
  [self.adsManager overrideFreewheelParameters:fwParameters];

  // Load the video
  [ooyalaPlayer setEmbedCode:self.embedCode];
}

- (void) notificationHandler:(NSNotification*) notification {

  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }

  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.skinController.player state]],
        [self.skinController.player playheadTime]);
}


@end
