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
#import "BasicEmbedTokenGenerator.h"

#import <OoyalaSDK/OoyalaSDK.h>
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>

#define REFRESH_RATE 0.5

@interface PlayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *playerView;

/**
 Shows the current download state of the asset
 */
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *playOfflineButton;
@property (weak, nonatomic) IBOutlet UITextView *analyticsData;

@property (nonatomic) OOSkinViewController *ooyalaPlayerViewController;

// properties required for a Fairplay asset
@property (nonatomic) NSString *apiKey;
@property (nonatomic) NSString *apiSecret;

// for refresh the data from analytics offline
@property (nonatomic) NSTimer *refreshTimer;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  OOOoyalaPlayer *player = nil;
  // We assume we're dealing with a Fairplay asset because the Option instance has an embedTokenGenerator
  if (self.option.embedTokenGenerator) {
    if ([self.option.embedTokenGenerator isKindOfClass:[BasicEmbedTokenGenerator class]]) {
      // If you're using the BasicEmbedTokenGenerator we provided in this sample app, this block will be called.
      // check the OptionsDataSource class to see how we define the assets for the app and how we add a reference to a BasicEmbedTokenGenerator to a given asset.
      BasicEmbedTokenGenerator *basicEmbedTokenGen = (BasicEmbedTokenGenerator *) self.option.embedTokenGenerator;
      self.apiKey = basicEmbedTokenGen.apiKey;
      self.apiSecret = basicEmbedTokenGen.apiSecret;
    } else {
      // If you're not using the BasicEmbedTokenGenerator provided in the example, supply your own API_KEY and API_SECRET
      self.apiKey = @"API_KEY";
      self.apiSecret = @"API_SECRET";
    }
    
    OOOptions *options = [OOOptions new];
    // For this example, we use the OOEmbededSecureURLGenerator to create the signed URL on the client
    // This is not how this should be implemented in production - In production, you should implement your own OOSecureURLGenerator
    //   which contacts a server of your own, which will help sign the url with the appropriate API Key and Secret
    options.secureURLGenerator = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey secret:self.apiSecret];
    
    player = [[OOOoyalaPlayer alloc] initWithPcode:self.option.pcode
                                            domain:[OOPlayerDomain domainWithString:self.option.domain]
                               embedTokenGenerator:self.option.embedTokenGenerator
                                           options:options];
    
  } else { // This is a regular HLS asset with non DRM protection
    player = [[OOOoyalaPlayer alloc] initWithPcode:self.option.pcode
                                            domain:[OOPlayerDomain domainWithString:self.option.domain]];
  }
  
  NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  //  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:nil jsCodeLocation:jsCodeLocation configFileName:@"skin" overrideConfigs:nil];
  self.ooyalaPlayerViewController = [[OOSkinViewController alloc] initWithPlayer:player skinOptions:skinOptions parent:self.playerView launchOptions:nil];
  
  [self.ooyalaPlayerViewController willMoveToParentViewController:self];
  [self addChildViewController:self.ooyalaPlayerViewController];
  self.ooyalaPlayerViewController.view.frame = self.playerView.bounds;
  [self.ooyalaPlayerViewController didMoveToParentViewController:self];
  
  AssetPersistenceState state = [[AssetPersistenceManager sharedManager] downloadStateForEmbedCode:self.option.embedCode];
  [self updateUIUsingState:@(state)];
 
  // Become an observer for the AssetPersistenceStateChangedNotification notification.
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(handleAssetStateChanged:)
                                               name:AssetPersistenceStateChangedNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(handleProgressChanged:)
                                               name:AssetDownloadProgressNotification
                                             object:nil];
  
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:REFRESH_RATE
                                                       target:self
                                                     selector:@selector(onTimer:)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.refreshTimer invalidate];
  self.refreshTimer = nil;
}

- (void)dealloc {
  // Remove this class as an observer.
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/**
 Update the UI depending on the download state of the given asset.
 
 @param state download state to use to update the UI.
 */
- (void)updateUIUsingState:(NSNumber *)state {
  switch ([state intValue]) {
    case AssetNotDownloaded:
      self.stateLabel.text = @"State: Not Downloaded";
      self.playOfflineButton.enabled = NO;
      break;
    case AssetAuthorizing:
      self.stateLabel.text = @"State: Authorizing";
      self.playOfflineButton.enabled = NO;
      break;
    case AssetDownloading:
      self.stateLabel.text = @"State: Downloading";
      self.playOfflineButton.enabled = NO;
      break;
    case AssetPaused:
      self.stateLabel.text = @"State: Paused";
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
  
  // update the UI only if it is the correct embed code.
  if ([embedCode isEqualToString:self.option.embedCode]) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self updateUIUsingState:state];
    });
  }
}

- (void)handleProgressChanged:(NSNotification *)notification {
  NSString *embedCode = notification.userInfo[AssetNameKey];
  AssetPersistenceState state = [[AssetPersistenceManager sharedManager] downloadStateForEmbedCode:self.option.embedCode];
  if ([embedCode isEqualToString:self.option.embedCode] && state == AssetDownloading) {
    // Update progressView with the percentage progress of the notification. We assume it has a value between 0.0 and 1.0.
    dispatch_async(dispatch_get_main_queue(), ^{
      NSNumber *percentage = notification.userInfo[AssetProgressKey];
      self.stateLabel.text = [NSString stringWithFormat:@"State: Downloading (%.0f%%)", [percentage floatValue] * 100];
    });
  }
}

// action linked to the online video button
- (IBAction)playOnline {
  [self.ooyalaPlayerViewController.player setEmbedCode:self.option.embedCode];
}

// action linked to the offline video button
- (IBAction)playOffline {
  OOOfflineVideo *video = [[AssetPersistenceManager sharedManager] videoForEmbedCode:self.option.embedCode];
  if (video) {
    [self.ooyalaPlayerViewController.player setUnbundledVideo:video];
  }
}

#pragma mark - Timer

- (void)onTimer:(NSTimer *)timer {
  NSString *dataFromAnalytics = [self.ooyalaPlayerViewController.player dataFromFile:self.option.embedCode];
  self.analyticsData.text = dataFromAnalytics;
}

@end

