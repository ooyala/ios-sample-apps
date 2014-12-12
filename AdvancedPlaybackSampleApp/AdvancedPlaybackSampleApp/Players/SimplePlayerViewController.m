//
//  DetailViewController.m
//  AdvancedPlaybackSampleApp
//
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import "SimplePlayerViewController.h"
#import "OOOoyalaPlayerViewController.h"
#import "OOOoyalaPlayer.h"
#import "OOPlayerDomain.h"

@interface SimplePlayerViewController ()
@property OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property NSString *embedCode;
@end

@implementation SimplePlayerViewController
NSString * PCODE = @"R2d3I6s06RyB712DN0_2GsQS-R-Y";
NSString * const PLAYERDOMAIN = @"http://www.ooyala.com";

#pragma mark - Managing the detail item

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:@"PlayerSingleButton" owner:self options:nil];
}

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption:playerSelectionOption];
  // Update the user interface for the detail item.
  if (self.playerSelectionOption) {
      self.embedCode = self.playerSelectionOption.embedCode;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Create Ooyala ViewController
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPcode:PCODE domain:[[OOPlayerDomain alloc] initWithString:PLAYERDOMAIN]];

  // Attach it to current view
  [self addChildViewController:_ooyalaPlayerViewController];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];
  [self addChildViewController:_ooyalaPlayerViewController];
  [self.playerView addSubview:_ooyalaPlayerViewController.view];

  // Load the video
  [_ooyalaPlayerViewController.player setEmbedCode:self.embedCode];

  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:_ooyalaPlayerViewController.player];
  [_ooyalaPlayerViewController.player play];
}

- (void) notificationHandler:(NSNotification*) notification {
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  NSLog(@"Notification Received: %@ - state: %@ -- playhead: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.ooyalaPlayerViewController.player state]],
        [self.ooyalaPlayerViewController.player playheadTime]);
}

@end
