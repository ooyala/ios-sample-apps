/**
 * @class      BasicSimplePlayerViewController BasicSimplePlayerViewController.m "BasicSimplePlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    BasicSimplePlayerViewController in Ooyala Sample Apps
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */


#import "BasicSimplePlayerViewController.h"
#import "OOOoyalaPlayerViewController.h"
#import "OOOoyalaPlayer.h"
#import "OOPlayerDomain.h"

@interface BasicSimplePlayerViewController ()
@property (strong, nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;

@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@end

@implementation BasicSimplePlayerViewController

- (id)initWithPlayerSelectionOption:(BasicPlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];
  self.nib = @"PlayerAds";
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
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  
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
  
  // set up the ads picker
  self.adsList = [[NSMutableArray alloc] initWithObjects:
                  @"VAST Ad Pre-roll",
                  @"VAST Ad Mid-roll",
                  @"VAST Ad Post-roll",
                  @"VAST Ad Wrapper",
                  @"Ooyala Ad Pre-roll",
                  @"Ooyala Ad Mid-roll",
                  @"Ooyala Ad Post-roll",
                  @"Multi Ad combination", nil];
  
  self.adsEmbedcodeList = [[NSMutableArray alloc] initWithObjects:
                           @"Zlcmp0ZDrpHlAFWFsOBsgEXFepeSXY4c", // VAST Preroll
                           @"pncmp0ZDp7OKlwTPJlMZzrI59j8Imefa", // VAST Midroll
                           @"Zpcmp0ZDpaB-90xK8MIV9QF973r1ZdUf", // VAST Postroll
                           @"pqaWp0ZDqo17Z-Dn_5YiVhjcbQYs5lhq", // VAST Wrapper
                           @"M4cmp0ZDpYdy8kiL4UD910Rw_DWwaSnU", // OOYALA Preroll
                           @"xhcmp0ZDpnDB2-hXvH7TsYVQKEk_89di", // OOYALA Midroll
                           @"Rjcmp0ZDr5yFbZPEfLZKUveR_2JzZjMO", // OOYALA Postroll
                           @"Ftcmp0ZDoz8tALmhPcN2vMzCdg7YU9lc", // Multi Ad combination
                           nil];
  
  self.adsPicker.delegate =self;
  self.adsPicker.showsSelectionIndicator = YES;
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
