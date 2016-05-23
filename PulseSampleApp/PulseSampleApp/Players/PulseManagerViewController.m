//
//  PulseManagerViewController.m
//  PulseSampleApp
//
//  Created by Jacques du Toit on 03/02/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#define PCODE @"tlM2k6i2-WrXX1DE_b8zfhui_eQN"
#define PLAYER_DOMAIN @"http://www.ooyala.com"

#import "PulseManagerViewController.h"

#import <OoyalaPulseIntegration/OOPulseManager.h>

#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSkinSDK/OOSkinOptions.h>
#import <OoyalaSkinSDK/OOSkinViewController.h>


@interface PulseManagerViewController () <OOPulseManagerDelegate>
@property (strong, nonatomic) OOOoyalaPlayer *player;
@property (strong, nonatomic) UIViewController *playerViewController;
@property (strong, nonatomic) OOPulseManager *manager;

@property (strong, nonatomic) VideoItem *videoItem;
@property (weak, nonatomic) id<OOPulseManagerDelegate> delegate;

@end


@implementation PulseManagerViewController

- (id)initWithVideoItem:(VideoItem *)video
{
  self = [super init];
  if (self) {
    _videoItem = video;
    self.title = video.title;
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:@"PlayerSimple" owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Create Ooyala ViewController
  self.player = [[OOOoyalaPlayer alloc] initWithPcode:PCODE
                                               domain:[[OOPlayerDomain alloc] initWithString:PLAYER_DOMAIN]];
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:self.player];
  [self prepareSkinned];
  //[self prepareUnskinned];
  
  // Create the Pulse manager object, and associate it with the Ooyala player
  self.manager = [[OOPulseManager alloc] initWithPlayer:self.player];
  self.manager.delegate = self;
  
  // Select the video
  [self.player setEmbedCode:self.videoItem.embedCode];
}

- (void)prepareSkinned
{
  NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main"
                                                  withExtension:@"jsbundle"];
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:nil
                                                                jsCodeLocation:jsCodeLocation
                                                                configFileName:@"skin"
                                                               overrideConfigs:nil];
  
  self.playerViewController = [[OOSkinViewController alloc] initWithPlayer:self.player
                                                               skinOptions:skinOptions
                                                                    parent:self.playerView
                                                             launchOptions:nil];
  // Attach it to current view
  [self addChildViewController:self.playerViewController];
  [self.playerViewController.view setFrame:self.playerView.bounds];

}

- (void)prepareUnskinned
{
  self.playerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:self.player];
  
  // Attach it to current view
  [self addChildViewController:self.playerViewController];
  [self.playerView addSubview:self.playerViewController.view];
  [self.playerViewController.view setFrame:self.playerView.bounds];
}

#pragma mark - OOPulseManagerDelegate

- (id<OOPulseSession>)pulseManager:(OOPulseManager *)manager
             createSessionForVideo:(OOVideo *)video
                     withPulseHost:(NSString *)pulseHost
                   contentMetadata:(VPContentMetadata *)contentMetadata
                   requestSettings:(VPRequestSettings *)requestSettings
{
  // Override the content metadata for the Pulse Ad Session request.
  contentMetadata.category = self.videoItem.category;
  contentMetadata.tags = self.videoItem.tags;
  contentMetadata.identifier = self.videoItem.identifier;
  
  // Override some request settings
  requestSettings.linearPlaybackPositions = self.videoItem.midrollPositions;

  // Here we assume a landscape orientation for video playback
  requestSettings.width = (NSInteger)MAX(self.view.frame.size.width, self.view.frame.size.height);
  requestSettings.height = (NSInteger)MIN(self.view.frame.size.width, self.view.frame.size.height);
  
  // You should probably implement some way of determining the max
  // bitrate of ads to request.
  //requestSettings.maxBitRate = [BandwidthChecker maxBitRate];
  
  // Set the correct pulse host set and options
  //   refer to: http://support.ooyala.com/developers/ad-documentation/oadtech/ad_serving/dg/integration_sdk_parameter.html
  [OOPulse setPulseHost:@"https://pulse-demo.videoplaza.tv"
        deviceContainer:nil
           persistentId:nil];
  
  return [OOPulse sessionWithContentMetadata:contentMetadata
                             requestSettings:requestSettings];
}

- (void) notificationHandler:(NSNotification*) notification {

  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }

  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.player state]],
        [self.player playheadTime]);
}
@end
