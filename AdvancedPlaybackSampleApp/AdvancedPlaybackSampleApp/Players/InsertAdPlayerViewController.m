/**
 * @class      InsertAdPlayerViewController InsertAdPlayerViewController.m "InsertAdPlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    InsertAdPlayerViewController in Ooyala Sample Apps
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "InsertAdPlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"
#import "PlayerSelectionOption.h"

@interface InsertAdPlayerViewController ()

#pragma mark - Private properties

@property OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property OOManagedAdsPlugin *plugin;
@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;

@end

@implementation InsertAdPlayerViewController {
  AppDelegate *appDel;
}

#pragma mark - Initialization

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption
                                qaModeEnabled:(BOOL)qaModeEnabled{
  self = [super initWithPlayerSelectionOption:playerSelectionOption
                                qaModeEnabled:qaModeEnabled];
  _nib = @"PlayerDoubleButton";
  if (self.playerSelectionOption) {
    _embedCode    = self.playerSelectionOption.embedCode;
    _pcode        = self.playerSelectionOption.pcode;
    _playerDomain = self.playerSelectionOption.domain;
    self.title    = self.playerSelectionOption.title;
  } else {
    NSLog(@"There was no PlayerSelectionOption!");
    return nil;
  }
  return self;
}

#pragma mark - Life cycle

- (void)loadView {
  [super loadView];
  [NSBundle.mainBundle loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  appDel = (AppDelegate *)UIApplication.sharedApplication.delegate;

  [self.button1 setTitle:@"INSERT VAST AD" forState:UIControlStateNormal];
  [self.button2 setTitle:@"INSERT OOYALA AD" forState:UIControlStateNormal];
  
  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];

  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];

  // In QA Mode , making textView visible
  self.textView.hidden = !self.qaModeEnabled;

  // Create Ooyala Ads Plugin
  self.plugin = [self.ooyalaPlayerViewController.player managedAdsPlugin];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:_ooyalaPlayerViewController.player];
  
  // Attach it to current view
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  self.ooyalaPlayerViewController.view.frame = self.playerView.bounds;
  
  // Load the video
  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];
}

#pragma mark - Actions

- (IBAction)onLeftBtnClick:(UIButton *)sender {
  NSNumber *playheadTime = @(self.ooyalaPlayerViewController.player.playheadTime);
  NSURL *vastURL = [NSURL URLWithString:@"http://player.ooyala.com/static/v4/testAssets/vast2/VastAd_Preroll.xml"];
  
  OOVASTAdSpot *vastAd = [[OOVASTAdSpot alloc] initWithTime:playheadTime
                                                   duration:self.ooyalaPlayerViewController.player.duration
                                                   clickURL:nil
                                               trackingURLs:nil
                                                    vastURL:vastURL];
  [self.plugin insertAd:vastAd];
}

- (IBAction)onRightBtnClick:(UIButton *)sender {
  NSNumber *playheadTime = @(self.ooyalaPlayerViewController.player.playheadTime);

  OOOoyalaAdSpot *ooyalaAd = [[OOOoyalaAdSpot alloc] initWithTime:playheadTime
                                                         clickURL:nil
                                                     trackingURLs:nil
                                                        embedCode:@"Zvcmp0ZDqD6xnQVH8ZhWlxH9L9bMGDDg"
                                                              api:[self.ooyalaPlayerViewController.player api]];
  [self.plugin insertAd:ooyalaAd];
}

- (void)notificationHandler:(NSNotification *)notification {
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                       notification.name,
                       [OOOoyalaPlayerStateConverter playerStateToString:self.ooyalaPlayerViewController.player.state],
                       self.ooyalaPlayerViewController.player.playheadTime,
                       appDel.count];
  NSLog(@"%@",message);
  
  // In QA Mode , adding notifications to the TextView
  if (self.qaModeEnabled) {
    NSString *string = self.textView.text;
    NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@", string, message];
    dispatch_async(dispatch_get_main_queue(), ^{
      self.textView.text = appendString;
    });
  }
  appDel.count++;
}

@end
