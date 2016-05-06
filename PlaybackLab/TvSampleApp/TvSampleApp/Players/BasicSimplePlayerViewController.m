/**
 * @class      BasicSimplePlayerViewController BasicSimplePlayerViewController.m "BasicSimplePlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    BasicSimplePlayerViewController in Ooyala Sample Apps
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */


#import "BasicSimplePlayerViewController.h"
#import "PlayerSelectionOption.h"
#import <OoyalaTVSDK/OOOoyalaTVPlayerViewController.h>
#import <OoyalaTVSDK/OOOoyalaPlayer.h>
#import <OoyalaTVSDK/OOPlayerDomain.h>
#import <UIKit/UIScreen.h>

@interface BasicSimplePlayerViewController ()
@property (strong, nonatomic) OOOoyalaTVPlayerViewController *ooyalaPlayerViewController;

@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@end

@implementation BasicSimplePlayerViewController

//- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
//  self = [super initWithPlayerSelectionOption: playerSelectionOption];
//  self.pcode =@"R2d3I6s06RyB712DN0_2GsQS-R-Y";
//  self.playerDomain = @"http://www.ooyala.com";
//  self.embedCode = @"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1";
//  
//  if (self.playerSelectionOption) {
//    self.embedCode = self.playerSelectionOption.embedCode;
//    self.title = self.playerSelectionOption.title;
//  }
//  return self;
//}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.pcode =@"R2d3I6s06RyB712DN0_2GsQS-R-Y";
  self.playerDomain = @"http://www.ooyala.com";
  self.embedCode = @"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1";

  if (self.playerSelectionOption) {
    self.embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
  }

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.ooyalaPlayerViewController = [[OOOoyalaTVPlayerViewController alloc] initWithPlayer:player];
  
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:self.ooyalaPlayerViewController.player];
  
  // Attach it to current view
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];
  self.playerView.frame = CGRectMake(0, 0, self.playerView.frame.size.width, [UIScreen mainScreen].bounds.size.height);
  
  // Load the video
  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];
  
}

- (void) notificationHandler:(NSNotification*) notification {
  
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.ooyalaPlayerViewController.player state]],
        [self.ooyalaPlayerViewController.player playheadTime]);
}
@end
