/**
 * @class      InsertAdPlayerViewController InsertAdPlayerViewController.m "InsertAdPlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    InsertAdPlayerViewController in Ooyala Sample Apps
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */


#import "InsertAdPlayerViewController.h"

#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSDK/OOManagedAdSpot.h>
#import <OoyalaSDK/OOManagedAdsPlugin.h>
#import <OoyalaSDK/OOVASTAdSpot.h>
#import <OoyalaSDK/OOOoyalaAdSpot.h>

@interface InsertAdPlayerViewController ()
@property OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property OOManagedAdsPlugin *plugin;
@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@end

@implementation InsertAdPlayerViewController

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
  OOVASTAdSpot *vastAd = [[OOVASTAdSpot alloc] initWithTime:[NSNumber numberWithFloat:[self.ooyalaPlayerViewController.player playheadTime]] clickURL:nil trackingURLs:nil vastURL:[NSURL URLWithString:@"http://xd-team.ooyala.com.s3.amazonaws.com/ads/VastAd_Preroll.xml"]];
  [self.plugin insertAd:vastAd];
}

- (IBAction)onRightBtnClick:(UIButton *)sender
{
  OOOoyalaAdSpot *ooyalaAd = [[OOOoyalaAdSpot alloc] initWithTime:[NSNumber numberWithFloat:[self.ooyalaPlayerViewController.player playheadTime]] clickURL:nil trackingURLs:nil embedCode:@"Zvcmp0ZDqD6xnQVH8ZhWlxH9L9bMGDDg" api:[self.ooyalaPlayerViewController.player api]];
  [self.plugin insertAd:ooyalaAd];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.button1 setTitle:@"INSERT VAST AD" forState:UIControlStateNormal];
  [self.button2 setTitle:@"INSERT OOYALA AD" forState:UIControlStateNormal];

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  // Create Ooyala Ads Plugin
  self.plugin = [self.ooyalaPlayerViewController.player managedAdsPlugin];
  
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
