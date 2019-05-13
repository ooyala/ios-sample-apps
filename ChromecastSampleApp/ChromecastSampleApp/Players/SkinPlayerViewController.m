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
#import <OoyalaCastSDK/OOCastManager.h>

#import "ChromecastPlayerSelectionOption.h"
#import "OOCastManagerFetcher.h"
#import "SkinCastPlaybackView.h"

@interface SkinPlayerViewController ()

@property (nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (nonatomic) IBOutlet UIView *videoView;
@property (nonatomic) OOSkinViewController *skinController;
@property (nonatomic) SkinCastPlaybackView *castPlaybackView;
@property (nonatomic) OOCastManager *castManager;

@end

@implementation SkinPlayerViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];

  OOOptions *options = [OOOptions new];
  OOOoyalaPlayer *ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.mediaInfo.pcode
                                                                domain:[[OOPlayerDomain alloc] initWithString:self.mediaInfo.domain]
                                                               options:options];
  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular
                                                                            limit:10
                                                                          timeout:60];
  NSURL *jsCodeLocation = [NSBundle.mainBundle URLForResource:@"main" withExtension:@"jsbundle"];
  //  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
  NSDictionary *overrideConfigs = @{@"upNextScreen": @{@"timeToShow": @"8"}};

  ooyalaPlayer.actionAtEnd = OOOoyalaPlayerActionAtEndPause;  //This is recommended to make sure the endscreen shows up as expected
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions
                                                                jsCodeLocation:jsCodeLocation
                                                                configFileName:@"skin"
                                                               overrideConfigs:overrideConfigs];

  _skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaPlayer
                                                     skinOptions:skinOptions
                                                          parent:self.videoView];
  [self addChildViewController:_skinController];
  _skinController.view.frame = self.videoView.bounds;

  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.skinController];

  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:ooyalaPlayer];
  [ooyalaPlayer setEmbedCode:self.mediaInfo.embedCode];

  self.castManager = [OOCastManagerFetcher fetchCastManager];
  
  [ooyalaPlayer initCastManager:self.castManager];
  self.castManager.notifyDelegate = self.skinController.castNotifyHandler;
  [self.skinController setCastManageableHandler:self.castManager];
  
  self.castPlaybackView = [[SkinCastPlaybackView alloc] initWithFrame:UIScreen.mainScreen.bounds];
  [self.castManager setCastModeVideoView:self.castPlaybackView];

  // Add Chromecast button
  UIBarButtonItem *chromecastItem = [[UIBarButtonItem alloc] initWithCustomView:self.castManager.castButton];
  self.navigationBar.rightBarButtonItem = chromecastItem;
}

#pragma mark - Private functions

- (void)notificationHandler:(NSNotification *)notification {
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  if ([notification.name isEqualToString:OOOoyalaPlayerStateChangedNotification]) {
    [self.castPlaybackView configureCastPlaybackViewBasedOnItem:self.skinController.player.currentItem];
  }
  if ([notification.name isEqualToString:OOOoyalaPlayerCurrentItemChangedNotification]) {
    [self.castPlaybackView configureCastPlaybackViewBasedOnItem:self.skinController.player.currentItem];
  }

  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f",
                       notification.name,
                       [OOOoyalaPlayerStateConverter playerStateToString:self.skinController.player.state],
                       self.skinController.player.playheadTime];
  NSLog(@"%@",message);
}

@end
