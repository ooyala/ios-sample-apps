//
//  DetailViewController.m
//  AdvancedPlaybackSampleApp
//
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import "SimplePlayerViewController.h"
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>

@interface SimplePlayerViewController ()
@property OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property NSString *embedCode;
@end

@implementation SimplePlayerViewController
NSString * const PCODE = @"R2d3I6s06RyB712DN0_2GsQS-R-Y";
NSString * const PLAYERDOMAIN = @"http://www.ooyala.com";
NSString * const NIB_NAME = @"PlayerSingleButton";

#pragma mark - Managing the detail item

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:NIB_NAME owner:self options:nil];
}

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption:playerSelectionOption];
  if (self.playerSelectionOption) {
      self.embedCode = self.playerSelectionOption.embedCode;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Create Ooyala ViewController
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPcode:PCODE domain:[[OOPlayerDomain alloc] initWithString:PLAYERDOMAIN]];

  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:_ooyalaPlayerViewController.player];

  // Attach it to current view
  [self addChildViewController:_ooyalaPlayerViewController];
  [self.playerView addSubview:_ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];

  // Load the video
  [_ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [_ooyalaPlayerViewController.player play];
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
