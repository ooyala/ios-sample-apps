/**
 * @class      BasicSimplePlayerViewController BasicSimplePlayerViewController.m "BasicSimplePlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    BasicSimplePlayerViewController in Ooyala Sample Apps
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "BasicSimplePlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"
#import "AudioOnlyPlayerInfo.h"

@interface BasicSimplePlayerViewController ()

#pragma mark - Private properties

@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;

@end


@implementation BasicSimplePlayerViewController {
    AppDelegate *appDel;
}

#pragma mark - Initialization

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption
                                qaModeEnabled:(BOOL)qaModeEnabled {
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
  _nib = @"PlayerSimple";
  NSLog(@"value of qa mode in BasicSimplePlayerviewController %@", self.qaModeEnabled ? @"YES" : @"NO");
  if (self.playerSelectionOption) {
    _embedCode = self.playerSelectionOption.embedCode;
    _pcode = self.playerSelectionOption.pcode;
    _playerDomain = self.playerSelectionOption.domain;
    self.title = self.playerSelectionOption.title;
    if (self.playerSelectionOption.isAudioOnly) {
      [OOStreamPlayer setDefaultPlayerInfo:[AudioOnlyPlayerInfo new]];
    }
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
  
  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:self.ooyalaPlayerViewController.player];
  
  // In QA Mode , making textView visible
  if (self.qaModeEnabled) {
    self.textView.hidden = NO;
  }
  
  // Attach it to current view
  [self addPlayerViewController:self.ooyalaPlayerViewController];
  
  // Load the video
  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];

  
}

#pragma mark - Private functions

- (void)addPlayerViewController:(UIViewController *)playerViewController {
  playerViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
  
  [self addChildViewController:playerViewController];
  [self.playerView addSubview:playerViewController.view];

  // Add constraints
  [NSLayoutConstraint activateConstraints:@[
                                            [playerViewController.view.topAnchor constraintEqualToAnchor:self.playerView.topAnchor],
                                            [playerViewController.view.leadingAnchor constraintEqualToAnchor:self.playerView.leadingAnchor],
                                            [playerViewController.view.bottomAnchor constraintEqualToAnchor:self.playerView.bottomAnchor],
                                            [playerViewController.view.trailingAnchor constraintEqualToAnchor:self.playerView.trailingAnchor]
                                            ]];
}

#pragma mark - Actions

- (void)notificationHandler:(NSNotification *)notification {
  
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                       notification.name,
                       [OOOoyalaPlayer playerStateToString:[self.ooyalaPlayerViewController.player state]],
                       [self.ooyalaPlayerViewController.player playheadTime], appDel.count];
  
  NSLog(@"%@",message);
  
  // In QA Mode , adding notifications to the TextView
  if (self.qaModeEnabled) {
    NSString *string = self.textView.text;
    NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@", string, message];
    [self.textView setText:appendString];
  }
  
  appDel.count++;
}


@end
