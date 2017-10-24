//
//  PulsePlayerViewController.m
//  TVOSSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaPulseIntegration/OoyalaPulseIntegration.h>
#import <Pulse_tvOS/Pulse.h>

#import "PulsePlayerViewController.h"
#import "PulseLibraryOption.h"

NSString *const PCODE = @"tlM2k6i2-WrXX1DE_b8zfhui_eQN";
NSString *const PLAYER_DOMAIN = @"http://www.ooyala.com";

@interface PulsePlayerViewController () <OOPulseManagerDelegate>

@property (strong, nonatomic) OOPulseManager *manager;

@end

@implementation PulsePlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.playbackControlsEnabled = YES;
  self.player = [[OOOoyalaPlayer alloc] initWithPcode:PCODE domain:[[OOPlayerDomain alloc] initWithString:PLAYER_DOMAIN]];
  
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
                   contentMetadata:(OOContentMetadata *)contentMetadata
                   requestSettings:(OORequestSettings *)requestSettings
{
  // Here we assume a landscape orientation for video playback
  requestSettings.width = (NSInteger)MAX(self.view.frame.size.width, self.view.frame.size.height);
  requestSettings.height = (NSInteger)MIN(self.view.frame.size.width, self.view.frame.size.height);
  
  // We can optionally pass some player-level custom parameters to the ad request
  if(self.option.category != nil) {
    contentMetadata.category = self.option.category;
  }
  
  if(self.option.tags != nil) {
    contentMetadata.tags = self.option.tags;
  }
  
  if(self.option.midrollPositions != nil) {
    requestSettings.linearPlaybackPositions = self.option.midrollPositions;
  }
  
  // You should probably implement some way of determining the max
  // bitrate of ads to request.
  // requestSettings.maxBitRate = [BandwidthChecker maxBitRate];

  // If the associated ad set has no Pulse host set, we'll return nil to prevent the ad request
  if(pulseHost == nil) {
    return nil;
  }

  [OOPulse setPulseHost:pulseHost
          deviceContainer:nil
             persistentId:nil];    
  
  return [OOPulse sessionWithContentMetadata:contentMetadata
                             requestSettings:requestSettings];
}

@end
