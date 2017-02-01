/**
 * @class      IQConfigurationPlayerViewController IQConfigurationPlayerViewController.m "IQConfigurationPlayerViewController.m"
 * @brief      A Player that can be used to demonstrate IQ Configuration
 * @details    A Player that can be used to demonstrate IQ Configuration
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "IQConfigurationPlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import <OoyalaSDK/OOIQConfiguration.h>  //TODO: This header should be part of the OoyalaSDK.h umbrella header.  This should not be reqiured by 4.21.0
#import "AppDelegate.h"

@interface IQConfigurationPlayerViewController ()
@property (strong, nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;

@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@end

@implementation IQConfigurationPlayerViewController {
    AppDelegate *appDel;
}

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];
  self.nib = @"PlayerSimple";
  
  if (self.playerSelectionOption) {
    self.embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
    self.pcode = self.playerSelectionOption.pcode;
    self.playerDomain = self.playerSelectionOption.domain;
  } else {
    NSLog(@"There was no PlayerSelectionOption!");
    return nil;
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  appDel = [[UIApplication sharedApplication] delegate];

  // Create an IQConfiguration class, and change all settings available
  OOIQConfiguration *iqConfig = [OOIQConfiguration new];

  iqConfig.playerID = @"App-configured Player ID";

  iqConfig.analyticsJSURL = @"https://analytics-staging.ooyala.com/static/v3/analytics.js";

  iqConfig.backendEndpointURL = @"https://l.ooyala.com/v3/analytics/events";

  iqConfig.domain = @"https://customDomain.com";

  iqConfig.backendEndpointTimeout = 20;

  iqConfig.analyticsJSRequestTimeout = 20;

  // Put the IQConfiguration class into the OOOptions
  OOOptions *options = [OOOptions new];
  options.iqConfiguration = iqConfig;

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] options:options];
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
  
  NSLog(@"Notification Received: %@. state: %@. playhead: %f count: %d",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.ooyalaPlayerViewController.player state]],
        [self.ooyalaPlayerViewController.player playheadTime], appDel.count);
  appDel.count++;
}
@end
