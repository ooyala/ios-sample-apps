/**
 * @class      ChangeVideoPlayerViewController ChangeVideoPlayerViewController.m "ChangeVideoPlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    ChangeVideoPlayerViewController in Ooyala Sample Apps
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */


#import "ChangeVideoPlayerViewController.h"

#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>

@interface ChangeVideoPlayerViewController ()
@property OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@end

@implementation ChangeVideoPlayerViewController

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];
  self.nib = @"PlayerDoubleButton";
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

- (IBAction)onLeftBtnClick:(UIButton *)sender
{
  [self.ooyalaPlayerViewController.player setEmbedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"];
  [self.ooyalaPlayerViewController.player play];
}

- (IBAction)onRightBtnClick:(UIButton *)sender
{
  [self.ooyalaPlayerViewController.player setEmbedCode:@"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx"];
  [self.ooyalaPlayerViewController.player play];
}


- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.button1 setTitle:@"Play Video 1" forState:UIControlStateNormal];
  [self.button2 setTitle:@"Play Video 2" forState:UIControlStateNormal];

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];

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
