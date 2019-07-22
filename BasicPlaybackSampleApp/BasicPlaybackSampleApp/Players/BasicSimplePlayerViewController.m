/**
 * @class      BasicSimplePlayerViewController BasicSimplePlayerViewController.m "BasicSimplePlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    BasicSimplePlayerViewController in Ooyala Sample Apps
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "BasicSimplePlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import <OoyalaSDK/OOOptions.h>
#import <OoyalaSDK/OODebugMode.h>

#import "AppDelegate.h"

@interface BasicSimplePlayerViewController ()

#pragma mark - Private properties

@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;
@property (nonatomic) BOOL isAudioOnlyAsset;

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
    _isAudioOnlyAsset = playerSelectionOption.isAudioOnlyAsset;
    self.title = self.playerSelectionOption.title;
    if (playerSelectionOption.isAudioOnlyAsset) {
      [OOStreamPlayer setDefaultPlayerInfo:[OODefaultAudioOnlyPlayerInfo new]];
    } else {
      [OOStreamPlayer setDefaultPlayerInfo:[OODefaultPlayerInfo new]];
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

  OOOptions *options = [OOOptions new];
  options.enablePictureInPictureSupport = YES;
  options.backgroundMode = OOBackgroundPlaybackModeDisabled;
  if (self.isAudioOnlyAsset) {
    options.playerInfo = [OODefaultAudioOnlyPlayerInfo new];
  } else {
    options.playerInfo = [OODefaultPlayerInfo new];
  }

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]
                                                         options:options];
  
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  [NSNotificationCenter.defaultCenter addObserver:self
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
  //[self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  //Deprecated API. Remove this call when SDK version become more then 4.46.0_GA. Uncomment code with Asynchronous method instead.
  //[self.ooyalaPlayerViewController.player play];
  
  //new API. Uncomment when SDK version become more then 4.46.0_GA
  __weak typeof(self) weakSelf = self;
  
  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode withCallback:^(OOOoyalaError *error) {
    LOG(@"✅ got callback. embed: %@, is success: %@. But it doesn't mean that status is 'AVPlayerItemStatusReadyToPlay'", weakSelf.ooyalaPlayerViewController.player.currentItem.embedCode, (error == nil) ? @"YES" : @"NO");
    if (error) {
      LOG(@"❌ error: %@", error.debugDescription);
    }
  }];
  
  //OS: to avoid calling '[weakSelf.player play]' until player really ready to play
  void (^expectedBlock) (OOVideo *currentItem);
  expectedBlock = ^(OOVideo *currentItem) {
    LOG(@"✅ got expectedBlock");
    if ([currentItem.embedCode isEqualToString:weakSelf.embedCode]) {
      NSLog(@"✅ aseet with embed code %@", currentItem.embedCode);
      [weakSelf.ooyalaPlayerViewController.player play];
      //OS: block must be removed after '[weakSelf.player play]', to prevent ignition from OOBaseStreamPlayer's KVO 'AVPlayerItemStatusReadyToPlay'
      weakSelf.ooyalaPlayerViewController.player.currentItemChangedCallback = nil;
    } else {
      NSLog(@"❌ Error: got player with embed code [%@] that is not expected", currentItem.embedCode);
    }
  };
  self.ooyalaPlayerViewController.player.currentItemChangedCallback = expectedBlock; //OOCurrentItemChangedCallback
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
                       [OOOoyalaPlayerStateConverter playerStateToString:[self.ooyalaPlayerViewController.player state]],
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


- (void)callbackListener {
  
}

@end
