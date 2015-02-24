//
//  ChannelDetailViewController.m
//  ChannelBrowserSampleApp
//
//  Created by Zhihui Chen on 2/23/15.
//  Copyright (c) 2015 ooyala. All rights reserved.
//

#import "ChannelDetailViewController.h"
#import "OOOoyalaPlayerViewController.h"
#import "OOPlayerDomain.h"
#import "OODebugMode.h"

@interface ChannelDetailViewController () {
  NSString *embedCode;
  NSString *nib;
  NSString *pcode;
  NSString *playerDomain;

  OOOoyalaPlayerViewController *ooyalaPlayerViewController;
}

@end

@implementation ChannelDetailViewController

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  if (self = [super initWithPlayerSelectionOption:playerSelectionOption]) {
    nib = @"PlayerSimple";
    pcode =@"R2d3I6s06RyB712DN0_2GsQS-R-Y";
    playerDomain = @"http://www.ooyala.com";
    embedCode = playerSelectionOption.embedCode;
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

  // Create Ooyala ViewController
  ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPcode:pcode domain:[[OOPlayerDomain alloc] initWithString:playerDomain]];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:ooyalaPlayerViewController.player];

  // Attach it to current view
  [self addChildViewController:ooyalaPlayerViewController];
  [self.playerView addSubview:ooyalaPlayerViewController.view];
  [ooyalaPlayerViewController.view setFrame:self.playerView.bounds];

  // Load the video
  [ooyalaPlayerViewController.player setEmbedCode:embedCode];
  [ooyalaPlayerViewController.player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) notificationHandler:(NSNotification*) notification {

  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }

  LOG(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[ooyalaPlayerViewController.player state]],
        [ooyalaPlayerViewController.player playheadTime]);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
