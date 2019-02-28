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
    self.title = self.playerSelectionOption.title;
  }
  return self;
}

- (void) loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

#pragma mark - View Controller Lifecycle
- (void)viewDidLoad {
  [super viewDidLoad];
  
  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular limit:10 timeout:60];
  NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  NSDictionary *overrideConfigs = @{@"upNextScreen": @{@"timeToShow": @"8"}};

  //Configure the button
  [self.button1 addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
  [self.button1 setTitle:@"Picture In Picture" forState:UIControlStateNormal];

  //Use the AppDelegate Player
  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  appDelegate.player.actionAtEnd = OOOoyalaPlayerActionAtEndPause;
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions jsCodeLocation:jsCodeLocation configFileName:@"skin" overrideConfigs:overrideConfigs];
  self.skinController = [[OOSkinViewController alloc] initWithPlayer:appDelegate.player skinOptions:skinOptions parent:self.playerView launchOptions:nil];
  [self addChildViewController:_skinController];
  [self.skinController.view setFrame:self.playerView.bounds];
  [appDelegate.player setEmbedCode:self.embedCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Selectors
- (void)buttonAction {
  [self.skinController.player togglePictureInPictureMode];
}

@end
