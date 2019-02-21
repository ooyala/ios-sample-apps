//
//  FreewheelPlayerViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "FreewheelPlayerViewController.h"
#import <OoyalaFreewheelSDK/OOFreewheelManager.h>
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>
#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"

@interface FreewheelPlayerViewController ()

#pragma mark - Private properties

@property (nonatomic, retain) OOSkinViewController *skinController;
@property (nonatomic) OOFreewheelManager *adsManager;
@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;

@end

@implementation FreewheelPlayerViewController {
  AppDelegate *appDel;
}

#pragma mark - Initializaiton

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption
                                qaModeEnabled:(BOOL)qaModeEnabled {
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
  if (self.playerSelectionOption) {
    _nib          = self.playerSelectionOption.nib;
    _embedCode    = self.playerSelectionOption.embedCode;
    _playerDomain = self.playerSelectionOption.playerDomain;
    _pcode        = playerSelectionOption.pcode;
    self.title    = self.playerSelectionOption.title;
  }
  return self;
}

#pragma mark - Life cycle

- (void)loadView {
  [super loadView];
  [NSBundle.mainBundle loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  appDel = (AppDelegate *)UIApplication.sharedApplication.delegate;
  
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
  ooyalaPlayer.actionAtEnd = OOOoyalaPlayerActionAtEndPause; //This is recommended to make sure the endscreen shows up as expected
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions
                                                                jsCodeLocation:jsCodeLocation
                                                                configFileName:@"skin"
                                                               overrideConfigs:nil];
  
  _skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaPlayer
                                                     skinOptions:skinOptions
                                                          parent:_videoView
                                                   launchOptions:nil];
  [self addChildViewController:_skinController];
  _skinController.view.frame = self.videoView.bounds;
  [ooyalaPlayer setEmbedCode:self.embedCode];

  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:ooyalaPlayer];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.skinController];
  
  self.adsManager = [[OOFreewheelManager alloc] initWithOoyalaPlayer:ooyalaPlayer];
  
  // In QA Mode , making textView visible
  self.textView.hidden = !self.qaModeEnabled;
  
  NSMutableDictionary *fwParameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                         @"fw_ios_ad_server": @"https://g1.v.fwmrm.net/",
                                         @"fw_ios_player_profile": @"90750:ooyala_ios",
                                         @"FRMSegment": @"channel=TEST;subchannel=TEST;section=TEST;mode=online;player=ooyala;beta=n"
//                                         @"fw_ios_mrm_network_id": @"90750",
//                                         @"fw_ios_site_section_id": @"ooyala_test_site_section",
//                                         @"fw_ios_video_asset_id": @"ooyala_test_video_with_bvi_cuepoints"
                                         }];
  [self.adsManager overrideFreewheelParameters:fwParameters];
  
  // Load the video
  [ooyalaPlayer setEmbedCode:self.embedCode];
}

#pragma mark - Private functions

- (void)notificationHandler:(NSNotification*)notification {
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  // Check for FullScreenChanged notification
  if ([notification.name isEqualToString:OOSkinViewControllerFullscreenChangedNotification]) {
    NSString *message = [NSString stringWithFormat:@"Notification Received: %@. isfullscreen: %@. ",
                         notification.name,
                         [notification.userInfo[@"fullscreen"] boolValue] ? @"YES" : @"NO"];
    NSLog(@"%@", message);
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                       notification.name,
                       [OOOoyalaPlayerStateConverter playerStateToString:self.skinController.player.state],
                       self.skinController.player.playheadTime,
                       appDel.count];
  NSLog(@"%@",message);
  
  // In QA Mode , adding notifications to the TextView
  if (self.qaModeEnabled) {
    NSString *string = self.textView.text;
    NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@", string, message];
    dispatch_async(dispatch_get_main_queue(), ^{
      self.textView.text = appendString;
    });
  }
  appDel.count++;
}

@end
