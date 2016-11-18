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

@interface PlayerViewController ()


@property (weak, nonatomic) IBOutlet UIView *playerView;

/**
 Shows the current download state of the asset
 */
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *playOfflineButton;

@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;

// properties required for a Fairplay asset
@property (nonatomic) NSString *apiKey;
@property (nonatomic) NSString *apiSecret;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
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
    
    OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.option.pcode
                                                            domain:[OOPlayerDomain domainWithString:self.option.domain]
                                               embedTokenGenerator:self.option.embedTokenGenerator
                                                           options:options];
    self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  } else { // This is a regular HLS asset with non DRM protection
    OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.option.pcode
                                                            domain:[OOPlayerDomain domainWithString:self.option.domain]];
    self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  }
  
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
  
  // Become an observer for the AssetPersistenceStateChangedNotification notification.
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(handleAssetStateChanged:)
                                               name:AssetPersistenceStateChangedNotification
                                             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
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

@end
