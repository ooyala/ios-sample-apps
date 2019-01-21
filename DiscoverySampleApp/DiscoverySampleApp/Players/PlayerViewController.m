//
//  MasterViewController.m
//  OoyalaSkin
//
//  Created on 6/3/15.
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

#import "PlayerViewController.h"

#import <OoyalaSkinSDK/OoyalaSkinSDK.h>
#import <OoyalaSDK/OoyalaSDK.h>
#import "DemoSettings.h"

@implementation PlayerViewController

NSMutableArray *_sharePlugins;
OOOoyalaPlayer *ooyalaPlayer;

- (void)loadView {
  [super loadView];
  
  self.nib = @"OOplayer";
  self.configuration = [[DemoSettings alloc] initReadJSONFile];
  self.pcode         = [(NSDictionary *)self.configuration.playerParameters objectForKey:@"pcode"];
  self.playerDomain  = [(NSDictionary *)self.configuration.playerParameters objectForKey:@"domain"];
  self.embedCode     = [(NSDictionary *)self.configuration.initasset objectForKey:@"embedCode"];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)setCustomSkin {
  // Setting Discovery on player
  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular
                                                                            limit:10
                                                                          timeout:60];
  
  // Modifying PlayerViewController to use Ooyala Skin
  NSURL *jsCodeLocation = [NSBundle.mainBundle URLForResource:@"main" withExtension:@"jsbundle"];
//  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
  // Creating custom configs dictionary for the skin
  NSDictionary *overrideConfigs = @{@"upNextScreen": @{@"timeToShow": @"8"},
                                    @"controlBar": @{@"height":@"20"}};
  
  // Pointing to "assets/skin-config/skin.json" file to load skin options
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions
                                                                jsCodeLocation:jsCodeLocation
                                                                configFileName:@"skin"
                                                               overrideConfigs:overrideConfigs];
  self.skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaPlayer
                                                         skinOptions:skinOptions
                                                              parent:_videoView
                                                       launchOptions:nil];
  [self addChildViewController:_skinController];
  _skinController.view.frame = self.videoView.bounds;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  OOOptions *options = [OOOptions new];
  ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]
                                               options:options];
  
  ooyalaPlayer.actionAtEnd = OOOoyalaPlayerActionAtEndPause;  //This is reccomended to make sure the endscreen shows up as expected
  
  [self setCustomSkin];

  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:ooyalaPlayer];

  [ooyalaPlayer setEmbedCode:self.embedCode];
  [ooyalaPlayer play];  //Autoplay
}

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  if (self = [super initWithPlayerSelectionOption:playerSelectionOption]) {
    _sharePlugins = [NSMutableArray array];
    _nib          = self.playerSelectionOption.nib;
    _embedCode    = self.playerSelectionOption.embedCode;
    _playerDomain = playerSelectionOption.playerDomain;
    _pcode        = playerSelectionOption.pcode;
    self.title    = self.playerSelectionOption.title;
  }
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:ooyalaPlayer];
  /*
  if (self.ooyalaPlayer == nil){
    OOOptions *options = [OOOptions new];
    self.ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] options:options];
  }*/
  [ooyalaPlayer setEmbedCode:self.embedCode]; //Update Embedcode
  [ooyalaPlayer play]; //Autoplay
  
  return self;
}

- (void)replayCurrentVideo {
  [ooyalaPlayer setPlayheadTime:0];
  [ooyalaPlayer play];
}


- (void)notificationHandler:(NSNotification *)notification {
//  NSLog(@"::::%@", notification.name);
//  OOUtils.m discovery upnext
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  if ([notification.name isEqualToString:OOOoyalaPlayerCurrentItemChangedNotification]) {
    NSDictionary *dict = @{@"title": ooyalaPlayer.currentItem.title};
    [NSNotificationCenter.defaultCenter postNotificationName:@"NotificationMessageEvent"
                                                      object:nil
                                                    userInfo:dict];
  }

  // Check for FullScreenChanged notification
  if ([notification.name isEqualToString:OOSkinViewControllerFullscreenChangedNotification]) {
    NSString *message = [NSString stringWithFormat:@"Notification Received: %@. isfullscreen: %@. ",
                         notification.name,
                         [notification.userInfo[@"fullScreen"] boolValue] ? @"YES" : @"NO"];
    NSLog(@"%@", message);
  }
  
  if ([notification.name isEqualToString:OOOoyalaPlayerPlayCompletedNotification]) {
    NSLog(@"%@", @"Playback completed!");
  }
  
  if ([notification.name isEqualToString:OOOoyalaPlayerPlayStartedNotification]) {
    NSLog(@"%@", @"Playback started");
  }
  if ([notification.name isEqualToString:OOOoyalaPlayerEmbedCodeSetNotification]) {
    NSLog(@"%@", @"Playback started");
  }
}

@end
