//
//  AudioOnlySkinPlayerViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import <OoyalaSDK/OoyalaSDK.h>
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>

#import "AudioOnlySkinPlayerViewController.h"
#import "AppDelegate.h"

@interface AudioOnlySkinPlayerViewController ()

@property (nonatomic) OOSkinViewController *skinController;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;
@property (nonatomic) UIImageView *screenshotView;

@end

@implementation AudioOnlySkinPlayerViewController

AppDelegate *appDel;

#pragma mark - Initialization

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption
                                qaModeEnabled:(BOOL)qaModeEnabled {
  if (self = [super initWithPlayerSelectionOption:playerSelectionOption
                                    qaModeEnabled:qaModeEnabled]) {
    _nib          = playerSelectionOption.nib;
    _embedCode    = playerSelectionOption.embedCode;
    _playerDomain = playerSelectionOption.playerDomain;
    _pcode        = playerSelectionOption.pcode;
    self.title    = playerSelectionOption.title;
  }
  return self;
}

#pragma mark - Life cycle

- (void) loadView {
  [super loadView];
  [NSBundle.mainBundle loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = self.playerSelectionOption.title;
  appDel = (AppDelegate *)UIApplication.sharedApplication.delegate;
  
  OOOptions *options = [OOOptions new];
  OOOoyalaPlayer *ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                                domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]
                                                               options:options];
  
  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular
                                                                            limit:10
                                                                          timeout:60];
  
  NSURL *jsCodeLocation = [NSBundle.mainBundle URLForResource:@"main" withExtension:@"jsbundle"];

  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions
                                                                jsCodeLocation:jsCodeLocation
                                                                configFileName:@"skin"
                                                               overrideConfigs:nil];
  
  _skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaPlayer
                                                     skinOptions:skinOptions
                                                          parent:self.audioPlayerContainerView];
  [self addChildViewController:self.skinController];
  [OOStreamPlayer setDefaultPlayerInfo:[OODefaultAudioOnlyPlayerInfo new]];

  _skinController.view.frame = self.audioPlayerContainerView.bounds;
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.skinController];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:ooyalaPlayer];
  
  // In QA Mode , making textView visible
  self.logTextView.hidden = !self.qaModeEnabled;
  
  [ooyalaPlayer setEmbedCode:self.embedCode];
}

- (void)dealloc {
  [OOStreamPlayer setDefaultPlayerInfo:[OODefaultPlayerInfo new]];
}

#pragma mark - Private functions

- (void)notificationHandler:(NSNotification *)notification {
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                       notification.name,
                       [OOOoyalaPlayerStateConverter playerStateToString:self.skinController.player.state],
                       self.skinController.player.playheadTime,
                       appDel.count];
  NSLog(@"%@", message);
  
  // In QA Mode , adding notifications to the TextView
  if (self.qaModeEnabled) {
    NSString *string = self.logTextView.text;
    NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@", string,message];
    dispatch_async(dispatch_get_main_queue(), ^{
      self.logTextView.text = appendString;
    });
  }
  
  appDel.count++;
}

@end
