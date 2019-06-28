//
//  DRMPlayerViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "DRMPlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>
#import "AppDelegate.h"
#import "DRMPlayerSelectionOptions.h"

/**
 * This activity illustrates how you use Ooyala Player Token.
 * Ooyala Player Token can also be used in conjunction with the following security mechanisms
 * 1) Device Management,
 * 2) Concurrent Streams,
 * 3) Entitlements, and
 * 4) Stream Takedown
 *
 * This activity will NOT Playback any video.  You will need to:
 *  1) provide your own embed code, restricted with Ooyala Player Token
 *  2) provide your own PCODE, which owns the embed code
 *  3) have your API Key and Secret, which correlate to a user from the provider
 *
 * To play OPT-enabled videos, you must implement the OOEmbedTokenGenerator interface
 */
@interface DRMPlayerViewController () <OOEmbedTokenGenerator>

@property (nonatomic) OOSkinViewController *skinController;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;
@property (nonatomic) NSString *apiKey;
@property (nonatomic) NSString *secretKey;
@property (nonatomic) NSString *accountId;

@end

@implementation DRMPlayerViewController {
  AppDelegate *appDel;
}

#pragma mark - Initialization

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption
                                qaModeEnabled:(BOOL)qaModeEnabled {
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
  if (self.playerSelectionOption && [self.playerSelectionOption isKindOfClass:DRMPlayerSelectionOptions.class]) {
    _nib          = self.playerSelectionOption.nib;
    _embedCode    = self.playerSelectionOption.embedCode;
    _playerDomain = self.playerSelectionOption.playerDomain;
    _pcode        = playerSelectionOption.pcode;
    _apiKey       = ((DRMPlayerSelectionOptions *)self.playerSelectionOption).apiKey;
    _secretKey    = ((DRMPlayerSelectionOptions *)self.playerSelectionOption).secretKey;
    _accountId    = ((DRMPlayerSelectionOptions *)self.playerSelectionOption).accountId;
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
  
  // Create Options
  OOOptions *options = [OOOptions new];
  // Currently needed for Fairplay
  options.secureURLGenerator = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey
                                                                             secret:self.secretKey];
  // Create Ooyala player
  OOOoyalaPlayer *ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                                domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]
                                                   embedTokenGenerator:self
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
                                                          parent:_videoView];
  [self addChildViewController:_skinController];
  _skinController.view.frame = self.videoView.bounds;
  [ooyalaPlayer setEmbedCode:self.embedCode];
  
  // Notifications
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:ooyalaPlayer];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.skinController];
  
  // In QA Mode , making textView visible
  self.textView.hidden = !self.qaModeEnabled;
  // Load the video
  [ooyalaPlayer setEmbedCode:self.embedCode];
}

#pragma mark - Private functions

- (void)notificationHandler:(NSNotification *)notification {
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

#pragma mark - EmbedTokenGenerator protocol

/*
 * Get the Ooyala Player Token to play the embed code.
 * This should contact your servers to generate the OPT server-side.
 * For debugging, you can use Ooyala's EmbeddedSecureURLGenerator to create local embed tokens
 */
- (void)tokenForEmbedCodes:(NSArray<NSString *> *)embedCodes
                  callback:(OOEmbedTokenCallback)callback {
  NSMutableDictionary* params = [NSMutableDictionary dictionary];
//  params[@"account_id"] = self.accountId;  //Only used for concurrent streams
  NSString* uri = [NSString stringWithFormat:@"/sas/embed_token/%@/%@", self.pcode, [embedCodes componentsJoinedByString:@","]];
  OOEmbeddedSecureURLGenerator* urlGen = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey
                                                                                       secret:self.secretKey];
  NSURL* embedTokenUrl = [urlGen secureURLForHost:@"http://player.ooyala.com" uri:uri params:params];
  callback(embedTokenUrl.absoluteString);
}


@end
