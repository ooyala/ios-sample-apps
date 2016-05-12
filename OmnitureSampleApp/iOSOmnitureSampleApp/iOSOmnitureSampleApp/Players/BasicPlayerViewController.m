//
//  BasicPlayerViewController.m
//  iOSOmnitureSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "BasicPlayerViewController.h"
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaAdobeAnalyticsSDK/OoyalaAdobeAnalyticsSDK.h>

@interface BasicPlayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *playerView;

@property (nonatomic) OOOoyalaPlayerViewController *playerVC;
@property (nonatomic) OOAdobeAnalyticsManager *adobeAnalyticsManager;

@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *hbTrackingServer;
@property (nonatomic) NSString *hbProvider;

@end

@implementation BasicPlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.pcode = @"c0cTkxOqALQviQIGAHWY5hP0q9gU";
  self.embedCode = @"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx";
  self.playerDomain = @"http://www.ooyala.com";
  self.hbTrackingServer = @"ovppartners.hb.omtrdc.net";
  self.hbProvider = @"ooyalatester";
  
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.playerVC = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  // Start adobe analytics
  OOAdobeHeartbeatConfiguration *hbConfig = [[OOAdobeHeartbeatConfiguration alloc]
                                             initWithHeartbeatTrackingServer:self.hbTrackingServer
                                             heartbeatPublisher:self.hbProvider];
  self.adobeAnalyticsManager = [[OOAdobeAnalyticsManager alloc] initWithPlayer:player config:hbConfig];
  [self.adobeAnalyticsManager startCapture];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:self.playerVC.player];
  
  [self addChildViewController:self.playerVC];
  [self.playerView addSubview:self.playerVC.view];
  self.playerVC.view.frame = self.playerView.bounds;
  [self.playerVC didMoveToParentViewController:self];
  
  if ([self.playerVC.player setEmbedCode:self.embedCode]) {
    [self.playerVC.player play];
  }
}

- (void)notificationHandler:(NSNotification *)notification {
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.playerVC.player state]],
        [self.playerVC.player playheadTime]);
}

@end
