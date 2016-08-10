/**
 * @class      UnbundledPlayerViewController UnbundledPlayerViewController.m "UnbundledPlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    UnbundledPlayerViewController in Ooyala Sample Apps
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */


#import "UnbundledPlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>

@interface UnbundledPlayerViewController ()
@property (strong, nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;

@property NSString *assetUrl;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@end

@implementation UnbundledPlayerViewController

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];
  self.nib = @"PlayerSimple";
  self.pcode =@"R2d3I6s06RyB712DN0_2GsQS-R-Y";
  self.playerDomain = @"http://www.ooyala.com";
  if (self.playerSelectionOption) {
    self.assetUrl = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
    self.pcode = self.playerSelectionOption.pcode;
    self.playerDomain = self.playerSelectionOption.domain;
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
  OOStream *s = [[OOStream alloc]
                 initWithUrl:[NSURL URLWithString:self.assetUrl]
                 deliveryType:OO_DELIVERY_TYPE_HLS];
  OOUnbundledVideo *v = [[OOUnbundledVideo alloc] initWithUnbundledStreams:@[s]];
  [self.ooyalaPlayerViewController.player setUnbundledVideo:v];
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
