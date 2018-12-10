/**
 * @class      IQConfigurationPlayerViewController IQConfigurationPlayerViewController.m "IQConfigurationPlayerViewController.m"
 * @brief      A Player that can be used to demonstrate IQ Configuration
 * @details    A Player that can be used to demonstrate IQ Configuration
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "IQConfigurationPlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"

@interface IQConfigurationPlayerViewController ()

#pragma mark - Public properties

@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;

@end

@implementation IQConfigurationPlayerViewController {
  AppDelegate *appDel;
}

#pragma mark - Initialization

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption
                                qaModeEnabled:(BOOL)qaModeEnabled {
  self = [super initWithPlayerSelectionOption:playerSelectionOption qaModeEnabled:qaModeEnabled];
  self.nib = @"PlayerSimple";
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
  
  // Create an IQConfiguration class
  OOIQConfiguration *iqConfig = [OOIQConfiguration new];
  iqConfig.playerID = @"App-configured Player ID";
  
  // Put the IQConfiguration class into the OOOptions
  OOOptions *options = [OOOptions new];
  options.iqConfiguration = iqConfig;
  
  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] options:options];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.ooyalaPlayerViewController.player];
  
  // Attach it to current view
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  self.ooyalaPlayerViewController.view.frame = self.playerView.bounds;
  
  // Load the video
  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];
}

- (void)notificationHandler:(NSNotification*)notification {
  
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
    dispatch_async(dispatch_get_main_queue(), ^{
      self.textView.text = appendString;
    });
  }
  
  appDel.count++;
}

@end
