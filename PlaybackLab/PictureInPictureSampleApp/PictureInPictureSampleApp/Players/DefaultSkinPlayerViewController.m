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

  _sharePlugins = [[NSMutableArray alloc] init];

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
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  OOOptions *options = [OOOptions new];
  options.enablePictureInPictureSupport = YES;
  BOOL canUsePip = options.enablePictureInPictureSupport && AVPictureInPictureController.isPictureInPictureSupported && !self.isAudioOnlyAsset;
  if (canUsePip) {
    options.pipDelegate = self;
  }
  
  OOOoyalaPlayer *ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                                domain:[[OOPlayerDomain alloc]
                                                        initWithString:self.playerDomain]
                                                               options:options];
  
  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular limit:10 timeout:60];
  NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  NSDictionary *overrideConfigs = @{@"upNextScreen": @{@"timeToShow": @"8"}};

  //Configure the button
  [self.button1 setImage:[AVPictureInPictureController pictureInPictureButtonStartImageCompatibleWithTraitCollection:nil]
                forState:UIControlStateNormal];
  [self.button1 setTitle:@"" forState:UIControlStateNormal];
  if (canUsePip) {
    [self.button1 addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
  } else {
    [self.button1 setEnabled:false];
  }

  //Use the AppDelegate Player
  ooyalaPlayer.actionAtEnd = OOOoyalaPlayerActionAtEndPause;
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions jsCodeLocation:jsCodeLocation configFileName:@"skin" overrideConfigs:overrideConfigs];
  self.skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaPlayer skinOptions:skinOptions parent:self.playerView launchOptions:nil];
  [self addChildViewController:self.skinController];
  [self.skinController.view setFrame:self.playerView.bounds];
  
  //Start playback
  [ooyalaPlayer setEmbedCode:self.embedCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Custom Selectors
- (void)buttonAction {
  [self.skinController.player togglePictureInPictureMode];
  //[self updatePipButtonForStateIsActivated:!self.skinController.player.isPiPActivated];
}

#pragma mark - Private methods
- (void)updatePipButtonForStateIsActivated:(BOOL)isActivated {
  if (isActivated) {
    [self.button1 setImage:[AVPictureInPictureController pictureInPictureButtonStopImageCompatibleWithTraitCollection:nil]
                  forState:UIControlStateNormal];
  } else {
    [self.button1 setImage:[AVPictureInPictureController pictureInPictureButtonStartImageCompatibleWithTraitCollection:nil]
                  forState:UIControlStateNormal];
  }
}

@end
