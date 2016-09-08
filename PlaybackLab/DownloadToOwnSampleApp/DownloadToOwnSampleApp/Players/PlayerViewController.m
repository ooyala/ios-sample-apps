//
//  PlayerViewController.m
//  DownloadToOwnSampleApp
//
//  Created on 8/30/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "PlayerViewController.h"
#import "PlayerSelectionOption.h"
#import "AssetPersistenceManager.h"

#import <OoyalaSDK/OoyalaSDK.h>

@interface PlayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *playOfflineButton;

@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.option.pcode
                                                          domain:[OOPlayerDomain domainWithString:self.option.domain]];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  [self.ooyalaPlayerViewController willMoveToParentViewController:self];
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];
  [self.ooyalaPlayerViewController didMoveToParentViewController:self];
  
  AssetPersistenceState state = [[AssetPersistenceManager sharedManager] downloadStateForEmbedCode:self.option.embedCode];
  [self updateUIUsingState:@(state)];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(handleAssetStateChanged:)
                                               name:AssetPersistenceStateChangedNotification
                                             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateUIUsingState:(NSNumber *)state {
  switch ([state intValue]) {
    case AssetNotDownloaded:
      self.stateLabel.text = @"State: Not Downloaded";
      self.playOfflineButton.enabled = NO;
      break;
    case AssetDownloading:
      self.stateLabel.text = @"State: Downloading";
      self.playOfflineButton.enabled = NO;
      break;
    case AssetDownloaded:
      self.stateLabel.text = @"State: Downloaded";
      self.playOfflineButton.enabled = YES;
      break;
  }
}

- (void)handleAssetStateChanged:(NSNotification *)notification {
  NSString *embedCode = notification.userInfo[AssetNameKey];
  NSNumber *state = notification.userInfo[AssetStateKey];
  
  if ([embedCode isEqualToString:self.option.embedCode]) {
    [self updateUIUsingState:state];
  }
}

- (IBAction)playOnline {
  NSLog(@"Playing an online video");
  [self.ooyalaPlayerViewController.player setEmbedCode:self.option.embedCode];
}

- (IBAction)playOffline {
  NSLog(@"Playing an offline video");
  NSURL *location = [[AssetPersistenceManager sharedManager] downloadLocationForEmbedCode:self.option.embedCode];
  OOOfflineVideo *video = [[OOOfflineVideo alloc] initWithFileLocation:location];
  [self.ooyalaPlayerViewController.player setUnbundledVideo:video];
}

@end
