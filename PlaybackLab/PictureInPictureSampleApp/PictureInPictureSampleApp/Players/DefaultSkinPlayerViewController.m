//
//  MasterViewController.m
//  OoyalaSkin
//
//  Created by Zhihui Chen on 6/3/15.
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

@import AVKit.AVPictureInPictureController;
#import "DefaultSkinPlayerViewController.h"
#import "AppDelegate.h"
#import <OoyalaSkinSDK/OOSkinViewController.h>
#import <OoyalaSkinSDK/OOSkinOptions.h>
#import <OoyalaSDK/OoyalaSDK.h>

@interface DefaultSkinPlayerViewController ()

@property (nonatomic, retain) OOSkinViewController *skinController;

@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;
@property (nonatomic) BOOL isAudioOnlyAsset;

@end

@implementation DefaultSkinPlayerViewController  {
  NSMutableArray *_sharePlugins;
}

#pragma mark - Initialization
- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled {
  
  self = [super initWithPlayerSelectionOption:playerSelectionOption qaModeEnabled:self.qaModeEnabled];

  _sharePlugins = [NSMutableArray array];

  if (self.playerSelectionOption) {
    _nib = self.playerSelectionOption.nib;
    _embedCode = self.playerSelectionOption.embedCode;
    _playerDomain = playerSelectionOption.playerDomain;
    _pcode = playerSelectionOption.pcode;
    _isAudioOnlyAsset = playerSelectionOption.isAudioOnlyAsset;
    self.title = self.playerSelectionOption.title;
  }
  return self;
}

#pragma mark - View Controller Lifecycle
- (void) loadView {
  [super loadView];
  [NSBundle.mainBundle loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  OOOptions *options = [OOOptions new];
  options.enablePictureInPictureSupport = YES;
  BOOL canUsePip = options.enablePictureInPictureSupport &&
                   AVPictureInPictureController.isPictureInPictureSupported &&
                   !self.isAudioOnlyAsset;
  if (canUsePip) {
    options.pipDelegate = self;
  }
  
  OOOoyalaPlayer *ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                                domain:[[OOPlayerDomain alloc]
                                                        initWithString:self.playerDomain]
                                                               options:options];
  
  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular
                                                                            limit:10
                                                                          timeout:60];
  // TODO: Don't forget about switching between URLs
  NSURL *jsCodeLocation = [NSBundle.mainBundle URLForResource:@"main" withExtension:@"jsbundle"];
  //NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];

  NSDictionary *overrideConfigs = @{@"upNextScreen": @{@"timeToShow": @"8"}};

  //Configure the button
  // OS: Now configured in OOSkinPlayerObserver when OOOoyalaPlayerPlayStartedNotification is handled

  //Use the AppDelegate Player
  ooyalaPlayer.actionAtEnd = OOOoyalaPlayerActionAtEndPause;
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions
                                                                jsCodeLocation:jsCodeLocation
                                                                configFileName:@"skin"
                                                               overrideConfigs:overrideConfigs];
  self.skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaPlayer
                                                         skinOptions:skinOptions
                                                              parent:self.playerView];
  [self addChildViewController:self.skinController];
  self.skinController.view.frame = self.playerView.bounds;
  
  //Start playback
  [ooyalaPlayer setEmbedCode:self.embedCode];
}

#pragma mark - Private methods
// TODO: OS: it's better to change icon on pip-button (via notifying JS about apropriate event) from this place that is triggered by AVPipControllerDelegate.
// But problem is to get access from this VC to *ooReactSkinModel 'OOReactSkinModel (is private property *skinModel in OOSkinViewController, it has APi for interacting with *skinEventsEmitter 'OOReactSkinEventsEmitter' and with *bridge 'RCTBridge' (OOReactSkinBridge))' (path 1) or create new notification in OOyalaSDK, post in here in 'DefaultSkinPlayerViewController (AVPipControllerDelegate)' and listen it in the 'OOSkinPlayerObserver' (path 2, what is too sophisticated solution as for me)

- (void)updatePipButtonForStateIsActivated:(BOOL)isActivated {
  //id params = @{isPipActivatedKey:@(isActivated), isPipButtonVisibleKey:@(true)};
  //[self.skinController.player.bridge.skinEventsEmitter sendDeviceEventWithName:pipEventKey body:params];
}

@end
