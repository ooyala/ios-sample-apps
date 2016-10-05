//
//  PulsePlayerViewController.m
//  TVOSSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "PulsePlayerViewController.h"
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaPulseIntegration/OOPulseManager.h>
#import "PlayerSelectionOption.h"

@interface PulsePlayerViewController () <OOPulseManagerDelegate>

@property (nonatomic, strong) NSString *pcode;
@property (nonatomic, strong) NSString *playerDomain;
@property (strong, nonatomic) OOPulseManager *manager;

@end

@implementation PulsePlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.pcode = self.option.pcode;
  self.playerDomain = self.option.domain;

  self.playbackControlsEnabled = YES;
  self.player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:nil object:self.player];

  // Create the Pulse manager object, and associate it with the Ooyala player
  self.manager = [[OOPulseManager alloc] initWithPlayer:self.player];
  self.manager.delegate = self;
  
  [self.player setEmbedCode:self.option.embedCode];
  [self.player play];
}

- (void)notificationHandler:(NSNotification *)notification
{
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.player state]],
        [self.player playheadTime]);
}

#pragma mark - OOPulseManagerDelegate

- (id<OOPulseSession>)pulseManager:(OOPulseManager *)manager
             createSessionForVideo:(OOVideo *)video
                     withPulseHost:(NSString *)pulseHost
                   contentMetadata:(VPContentMetadata *)contentMetadata
                   requestSettings:(VPRequestSettings *)requestSettings
{
  // Here we assume a landscape orientation for video playback
  requestSettings.width = (NSInteger)MAX(self.view.frame.size.width, self.view.frame.size.height);
  requestSettings.height = (NSInteger)MIN(self.view.frame.size.width, self.view.frame.size.height);
  
  // You should probably implement some way of determining the max
  // bitrate of ads to request.
  //requestSettings.maxBitRate = [BandwidthChecker maxBitRate];

  // If the associated ad set has no Pulse host set, use this default one  
  if(pulseHost == nil) {
    pulseHost = @"https://pulse-demo.videoplaza.tv";
  }

  [OOPulse setPulseHost:pulseHost
          deviceContainer:nil
             persistentId:nil];    
  
  return [OOPulse sessionWithContentMetadata:contentMetadata
                             requestSettings:requestSettings];
}

@end
