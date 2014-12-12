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
  [[NSBundle mainBundle] loadNibNamed:@"PlayerSimple" owner:self options:nil];
}

- (void)setDetailItem:(id)newDetailItem {
  if (_detailItem != newDetailItem) {
      _detailItem = newDetailItem;
          
      // Update the view.
      [self configureView];
  }
}

- (void)configureView {
  // Update the user interface for the detail item.
  if (self.detailItem) {
      self.embedCode = self.detailItem;
  }
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Create Ooyala ViewController
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPcode:PCODE domain:[[OOPlayerDomain alloc] initWithString:PLAYERDOMAIN]];

  // Attach it to current view
  [self addChildViewController:_ooyalaPlayerViewController];
  [self.ooyalaPlayerViewController.view setFrame:self.view.bounds];
  [self addChildViewController:_ooyalaPlayerViewController];
  [self.view addSubview:_ooyalaPlayerViewController.view];

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
