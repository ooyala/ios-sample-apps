//
//  FullscreenPlayerViewController.m
//  TVOSSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "FullscreenPlayerViewController.h"
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import "PlayerSelectionOption.h"

@interface FullscreenPlayerViewController ()

@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;

@end

@implementation FullscreenPlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.pcode = self.option.pcode;
  self.playerDomain = self.option.domain;

  self.player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                               domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.player];
  
  [self.player setEmbedCode:self.option.embedCode];
  [self.player play];
}

- (void)notificationHandler:(NSNotification *)notification {
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        notification.name,
        [OOOoyalaPlayerStateConverter playerStateToString:self.player.state],
        self.player.playheadTime);
}

@end
