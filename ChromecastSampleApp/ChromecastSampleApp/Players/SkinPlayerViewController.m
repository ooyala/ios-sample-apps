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

@property (nonatomic) IBOutlet UIView *videoView;
@property (nonatomic) OOSkinViewController *skinController;

@end

@implementation SkinPlayerViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = self.mediaInfo.title;
  NSLog(@"%@s", self.mediaInfo.domain);

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
                                                          parent:self.videoView
                                                   launchOptions:nil];
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

//  _castManager = [OOCastManager castManagerWithAppID:@"4172C76F"
//                                           namespace:@"urn:x-cast:ooyala"];
//  [ooyalaPlayer initCastManager:self.castManager];
//  self.castManager.notifyDelegate = self.skinController.castNotifyHandler;
//  [self.skinController setCastManageableHandler:self.castManager];
}

#pragma mark - Private functions

- (void)notificationHandler:(NSNotification *)notification {
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }

  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f",
                       notification.name,
                       [OOOoyalaPlayerStateConverter playerStateToString:self.skinController.player.state],
                       self.skinController.player.playheadTime];
  NSLog(@"%@",message);
}

@end
