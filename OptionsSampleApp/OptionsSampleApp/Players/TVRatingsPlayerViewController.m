//
//  OptionsViewController.m
//  OptionsSampleApp
//
//  Created on 12/18/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import "TVRatingsPlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"
#import "PlayerSelectionOption.h"

@interface TVRatingsPlayerViewController () <UITextFieldDelegate>

#pragma mark - Private properties

@property (nonatomic) IBOutlet UIButton *button;
@property (nonatomic) IBOutlet UIView *playerView;

@property (nonatomic) OOOoyalaPlayerViewController *playerViewController;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;
@property (nonatomic) NSString *embedCode;
@property int tvRatingDuration;

@end

@implementation TVRatingsPlayerViewController {
  AppDelegate *appDel;
}

@dynamic playerView;

#pragma mark - Initialization

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption
                                qaModeEnabled:(BOOL)qaModeEnabled {
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
  _nib = @"PlayerDoubleSwitch";
  _tvRatingDuration = 5;
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
  
  // In QA Mode , making textView visible
  self.textView.hidden = !self.qaModeEnabled;
  
  if (self.switch1) {
    self.switchLabel1.text = @"On = Top, Off = Bottom";
    self.switch1.on = NO;
  }
  if (self.switch2) {
    self.switchLabel2.text = @"On = Left, Off = Right";
    self.switch2.on = NO;
  }
  
  [self.button1 setTitle:@"Set EC" forState:UIControlStateNormal];
}

- (IBAction)onButtonClick:(id)sender {
  OOOptions *options = [OOOptions new];
  
  if (self.playerViewController) {
    [self.playerViewController removeFromParentViewController];
    [self.playerViewController.view removeFromSuperview];
  }
  
  OOFCCTVRatingConfiguration *tvRatingConfig = [[OOFCCTVRatingConfiguration alloc] initWithDurationSeconds:_tvRatingDuration
                                                                                                  position:self.tvRatingPosition
                                                                                                     scale:0.2
                                                                                                   opacity:0.9];
  options.tvRatingConfiguration = tvRatingConfig;
  
  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] options:options];
  _playerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.playerViewController.player];
  
  // Setup video view
  CGRect rect = self.playerView.bounds;
  _playerViewController.view.frame = rect;
  [self addChildViewController:_playerViewController];
  [self.playerView addSubview:_playerViewController.view];
  
  [_playerViewController.player setEmbedCode:self.embedCode];
  
  if (_initialTime > 0) {
    [_playerViewController.player playWithInitialTime:_initialTime];
  }
}

#pragma mark - Private functions

- (OOFCCTvRatingsPosition)tvRatingPosition {
  if (self.switch1.on && self.switch2.on) {
    return OOFCCTvRatingsPositionTopLeft;
  }
  if (self.switch1.on && !self.switch2.on) {
    return OOFCCTvRatingsPositionTopRight;
  }
  if (!self.switch1.on && self.switch2.on) {
    return OOFCCTvRatingsPositionBottomLeft;
  }
  // if (!self.switch1.on && !self.switch2.on)
  return OOFCCTvRatingsPositionBottomRight;
}

- (void)notificationHandler:(NSNotification *)notification {
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                       notification.name,
                       [OOOoyalaPlayerStateConverter playerStateToString:self.playerViewController.player.state],
                       self.playerViewController.player.playheadTime, appDel.count];
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
