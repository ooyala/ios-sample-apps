//
//  SSAIPlayerViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "SSAIPlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import <OoyalaSSAISDK/OoyalaSSAISDK.h>
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>
#import "AppDelegate.h"

@interface SSAIPlayerViewController ()

#pragma mark - Private properties

@property (nonatomic) OOSsaiPlugin *ssaiPlugin;
@property (nonatomic) OOSkinViewController *skinController;
@property (nonatomic) OOOoyalaPlayer *ooyalaPlayer;
@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;

@end

@implementation SSAIPlayerViewController {
  AppDelegate *appDel;
}

#pragma mark - Initialization

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

- (void)viewDidLoad {
  [super viewDidLoad];
  
  appDel = (AppDelegate *)UIApplication.sharedApplication.delegate;

  // Create Ooyala ViewController
  OOOptions *options = [OOOptions new];
  self.ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                     domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]
                                                    options:options];
  
  // Bundle from OoyalaSkinSDK-iOS
  NSURL *jsCodeLocation = [NSBundle.mainBundle URLForResource:@"main" withExtension:@"jsbundle"];
  
  // Uncomment for local debugging
  //  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
  
  //This is recommended to make sure the endscreen shows up as expected
  self.ooyalaPlayer.actionAtEnd = OOOoyalaPlayerActionAtEndPause;
  
  NSDictionary *overrideConfig = @{@"adScreen": @{@"showControlBar": @true}};
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:nil
                                                                jsCodeLocation:jsCodeLocation
                                                                configFileName:@"skin"
                                                               overrideConfigs:overrideConfig];
  
  _skinController = [[OOSkinViewController alloc] initWithPlayer:self.ooyalaPlayer
                                                     skinOptions:skinOptions
                                                          parent:self.videoView];
  [self addChildViewController:self.skinController];
  _skinController.view.frame = self.videoView.bounds;

  // Load the video
  [self.ooyalaPlayer setEmbedCode:self.embedCode withCallback:nil];
  
  // Ooyala SSAI Plugin initialization
  self.ssaiPlugin = [OOSsaiPlugin new];
  [self.ssaiPlugin registerPlayer:self.ooyalaPlayer];
  
  // In QA Mode , making textView visible
  self.qaView.hidden = !self.qaModeEnabled;
  NSString *path = [NSBundle.mainBundle pathForResource:self.playerSelectionOption.adSetProvider
                                                 ofType:@"json"];
  NSString *content = [NSString stringWithContentsOfFile:path
                                                encoding:NSUTF8StringEncoding
                                                   error:NULL];
  self.playerParams.text = content;

  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.ooyalaPlayer];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.ssaiPlugin];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.skinController];
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
  NSLog(@"%@",message);
  
  // In QA Mode , adding notifications to the TextView
  if (self.qaModeEnabled) {
    NSString *string = self.qaLogTextView.text;
    NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@", string, message];
    dispatch_async(dispatch_get_main_queue(), ^{
      self.qaLogTextView.text = appendString;
    });
  }  
  appDel.count++;
}

#pragma mark - Actions

- (IBAction)setParams:(UIButton *)sender {
  NSString *params = self.playerParams.text;
  if ([self.ssaiPlugin setParams:params] &&
      self.ssaiPlugin.player.ooPlayerState != OOOoyalaPlayerStatePlaying) {
    [self.ooyalaPlayer setEmbedCode:self.playerSelectionOption.embedCode withCallback:nil];
  }
}

- (void)dealloc{
  [self.ssaiPlugin deregisterPlayer:self.ooyalaPlayer];
}

@end
