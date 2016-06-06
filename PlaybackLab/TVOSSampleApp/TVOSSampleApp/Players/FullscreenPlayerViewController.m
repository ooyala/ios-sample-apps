//
//  FullscreenPlayerViewController.m
//  TVOSSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "FullscreenPlayerViewController.h"
#import <OoyalaTVSDK/OOOoyalaPlayer.h>
#import <OoyalaTVSDK/OOPlayerDomain.h>
#import "PlayerSelectionOption.h"

@interface FullscreenPlayerViewController ()

@property (nonatomic, strong) NSString *pcode;
@property (nonatomic, strong) NSString *playerDomain;

@end

@implementation FullscreenPlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.pcode =@"R2d3I6s06RyB712DN0_2GsQS-R-Y";
  self.playerDomain = @"http://www.ooyala.com";
  
  self.player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:nil object:self.player];
  
  // Explicity require playback controlls, which enables tap seek
  self.showsPlaybackControls = YES;
  
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

@end
