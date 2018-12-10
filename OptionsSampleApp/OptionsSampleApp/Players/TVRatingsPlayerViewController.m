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

@interface TVRatingsPlayerViewController () <UITextFieldDelegate>

#pragma mark - Private properties

@property IBOutlet UIButton *button;
@property IBOutlet UIView *playerView;
@property OOOoyalaPlayerViewController *playerViewController;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@property NSString *embedCode;
@property int tvRatingDuration;

@end

@implementation TVRatingsPlayerViewController{
  AppDelegate *appDel;
}

#pragma mark - Synthesize

@synthesize switchLabel1 = _switchLabel1;
@synthesize switchLabel2 = _switchLabel2;
@synthesize switch1 = _switch1;
@synthesize switch2 = _switch2;
@synthesize button1 = _button1;
@dynamic playerView;

#pragma mark - Initialization

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption
                                qaModeEnabled:(BOOL)qaModeEnabled {
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
  _nib = @"PlayerDoubleSwitch";
  _tvRatingDuration = 5;
  if (self.playerSelectionOption) {
    _embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
    _pcode = self.playerSelectionOption.pcode;
    _playerDomain = self.playerSelectionOption.domain;
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
  
  if (_switch1) {
    _switchLabel1.text = @"On = Top, Off = Bottom";
    _switch1.on = NO;
  }
  if (_switch2) {
    _switchLabel2.text = @"On = Left, Off = Right";
    _switch2.on = NO;
  }
  
  [_button1 setTitle:@"Set EC" forState:UIControlStateNormal];
}

- (IBAction)onButtonClick:(id)sender {
  OOOptions *options = [OOOptions new];
  
  if (self.playerViewController) {
    [self.playerViewController removeFromParentViewController];
    [self.playerViewController.view removeFromSuperview];
  }
  
  OOFCCTVRatingConfiguration *tvRatingConfig = [[OOFCCTVRatingConfiguration alloc] initWithDurationSeconds:_tvRatingDuration
                                                                                                  position:[self getTVRatingPosition]
                                                                                                     scale:OOFCCTVRATINGCONFIGURATION_DEFAULT_SCALE
                                                                                                   opacity:OOFCCTVRATINGCONFIGURATION_DEFAULT_OPACITY];
  options.tvRatingConfiguration = tvRatingConfig;
  
  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] options:options];
  _playerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
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

- (OOFCCTvRatingsPosition)getTVRatingPosition {
  if (_switch1.on && _switch2.on) {
    return OOFCCTvRatingsPositionTopLeft;
  } else if (_switch1.on&& !_switch2.on) {
    return OOFCCTvRatingsPositionTopRight;
  } else if (!_switch1.on && _switch2.on) {
    return OOFCCTvRatingsPositionBottomLeft;
  } else { // if (_switch1.on == NO && _switch2.on == NO)
    return OOFCCTvRatingsPositionBottomRight;
  }
}

- (void)notificationHandler:(NSNotification*)notification {
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                       notification.name,
                       [OOOoyalaPlayer playerStateToString:[self.playerViewController.player state]],
                       [self.playerViewController.player playheadTime], appDel.count];
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
