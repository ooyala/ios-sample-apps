/**
 * @class      BasicSimplePlayerViewController BasicSimplePlayerViewController.m "BasicSimplePlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    BasicSimplePlayerViewController in Ooyala Sample Apps
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */


#import "BasicSimplePlayerViewController.h"
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>

@interface BasicSimplePlayerViewController ()
@property (strong, nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;

@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@end

@implementation BasicSimplePlayerViewController

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];
  self.nib = @"PlayerSimple";
  self.pcode =@"R2d3I6s06RyB712DN0_2GsQS-R-Y";
  self.playerDomain = @"http://www.ooyala.com";
  
  if (self.playerSelectionOption) {
    self.embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:self.ooyalaPlayerViewController.player];
  
  // Attach it to current view
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];
  
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
