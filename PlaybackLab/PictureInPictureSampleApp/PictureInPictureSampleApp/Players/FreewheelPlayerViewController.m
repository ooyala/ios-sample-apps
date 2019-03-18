//
//  FreewheelPlayerViewController.m
//  PictureInPictureSampleApp
//
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "FreewheelPlayerViewController.h"
#import <OoyalaFreewheelSDK/OOFreewheelManager.h>
#import <OoyalaSkinSDK/OOSkinViewController.h>
#import <OoyalaSkinSDK/OOSkinOptions.h>
#import <OoyalaSDK/OoyalaSDK.h>


@interface FreewheelPlayerViewController ()

@property (nonatomic, retain) OOSkinViewController *skinController;
@property (nonatomic) OOFreewheelManager *adsManager;
@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;

@end


@implementation FreewheelPlayerViewController

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption:playerSelectionOption qaModeEnabled:self.qaModeEnabled];

  if (self.playerSelectionOption) {
    _nib          = self.playerSelectionOption.nib;
    _embedCode    = self.playerSelectionOption.embedCode;
    _playerDomain = playerSelectionOption.playerDomain;
    _pcode        = playerSelectionOption.pcode;
    self.title    = self.playerSelectionOption.title;
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [NSBundle.mainBundle loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Create Ooyala ViewController
  // Create Ooyala ViewController
  OOOptions *options = [OOOptions new];
  OOOoyalaPlayer *ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                                domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]
                                                               options:options];
  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular
                                                                            limit:10
                                                                          timeout:60];
  NSURL *jsCodeLocation = [NSBundle.mainBundle URLForResource:@"main" withExtension:@"jsbundle"];
//  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions
                                                                jsCodeLocation:jsCodeLocation
                                                                configFileName:@"skin"
                                                               overrideConfigs:nil];

  _skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaPlayer
                                                     skinOptions:skinOptions
                                                          parent:_videoView
                                                   launchOptions:nil];
  [self addChildViewController:_skinController];
  self.skinController.view.frame = self.videoView.bounds;
  [ooyalaPlayer setEmbedCode:self.embedCode];

  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:ooyalaPlayer];

  self.adsManager = [[OOFreewheelManager alloc] initWithOoyalaPlayer:ooyalaPlayer];

  NSMutableDictionary *fwParameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                        @"fw_ios_ad_server": @"http://g1.v.fwmrm.net/",
                                        @"fw_ios_player_profile": @"90750:ooyala_ios",
                                        @"FRMSegment": @"channel=TEST;subchannel=TEST;section=TEST;mode=online;player=ooyala;beta=n"
//                                        @"fw_ios_mrm_network_id": @"90750",
//                                        @"fw_ios_site_section_id": @"ooyala_test_site_section",
//                                        @"fw_ios_video_asset_id": @"ooyala_test_video_with_bvi_cuepoints"
                                        }
                                       ];
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
        [OOOoyalaPlayerStateConverter playerStateToString:self.skinController.player.state],
        self.skinController.player.playheadTime);
}

@end
