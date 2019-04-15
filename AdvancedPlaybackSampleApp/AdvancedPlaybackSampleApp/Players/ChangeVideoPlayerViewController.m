/**
 * @class      ChangeVideoPlayerViewController ChangeVideoPlayerViewController.m "ChangeVideoPlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    ChangeVideoPlayerViewController in Ooyala Sample Apps
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "ChangeVideoPlayerViewController.h"
#import "AppDelegate.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "PlayerSelectionOption.h"

@interface ChangeVideoPlayerViewController ()

#pragma mark - Private properties

@property OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;

@end

@implementation ChangeVideoPlayerViewController {
  AppDelegate *appDel;
}

#pragma mark - Initialization

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption
                                qaModeEnabled:(BOOL)qaModeEnabled {
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
  
  [self.button1 setTitle:@"Play Video 1" forState:UIControlStateNormal];
  [self.button2 setTitle:@"Play Video 2" forState:UIControlStateNormal];
  
  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  _ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:_ooyalaPlayerViewController.player];
  // In QA Mode , making textView visible
  self.textView.hidden = !self.qaModeEnabled;
  
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
  [self.ooyalaPlayerViewController.player setEmbedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"];
  [self.ooyalaPlayerViewController.player play];
}

- (IBAction)onRightBtnClick:(UIButton *)sender {
  [self.ooyalaPlayerViewController.player setEmbedCode:@"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx"];
  [self.ooyalaPlayerViewController.player play];
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
