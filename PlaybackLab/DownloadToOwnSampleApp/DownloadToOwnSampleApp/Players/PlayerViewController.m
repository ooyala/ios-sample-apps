//
//  PlayerViewController.m
//  DownloadToOwnSampleApp
//
//  Created on 8/30/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

@import OoyalaSDK;
@import OoyalaSkinSDK;

#import "PlayerViewController.h"
#import "BasicEmbedTokenGenerator.h"

typedef NS_ENUM(NSInteger, DownloadMode) {
  Offline,
  Online,
  Undefined
};

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

@property (nonatomic) DownloadMode currentMode;

- (void)restartVideo;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.currentMode = Undefined;
  OOOoyalaPlayer *player = nil;
  // We assume we're dealing with a Fairplay asset because the Option instance has an embedTokenGenerator
  if (self.dtoAsset.options.embedTokenGenerator) {
    if ([self.dtoAsset.options.embedTokenGenerator isKindOfClass:BasicEmbedTokenGenerator.class]) {
      // If you're using the BasicEmbedTokenGenerator we provided in this sample app, this block will be called.
      // check the OptionsDataSource class to see how we define the assets for the app and how we add a reference to a BasicEmbedTokenGenerator to a given asset.
      BasicEmbedTokenGenerator *basicEmbedTokenGen = (BasicEmbedTokenGenerator *) self.dtoAsset.options.embedTokenGenerator;
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
    options.secureURLGenerator = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey
                                                                               secret:self.apiSecret];
    
    player = [[OOOoyalaPlayer alloc] initWithPcode:self.dtoAsset.options.pcode
                                            domain:[OOPlayerDomain domainWithString:self.dtoAsset.options.domain.asString]
                               embedTokenGenerator:self.dtoAsset.options.embedTokenGenerator
                                           options:options];
    
  } else { // This is a regular HLS asset with non DRM protection
    player = [[OOOoyalaPlayer alloc] initWithPcode:self.dtoAsset.options.pcode
                                            domain:[OOPlayerDomain domainWithString:self.dtoAsset.options.domain.asString]];
  }
  
  NSURL *jsCodeLocation = [NSBundle.mainBundle URLForResource:@"main" withExtension:@"jsbundle"];
  //  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:nil
                                                                jsCodeLocation:jsCodeLocation
                                                                configFileName:@"skin"
                                                               overrideConfigs:nil];
  self.ooyalaPlayerViewController = [[OOSkinViewController alloc] initWithPlayer:player
                                                                     skinOptions:skinOptions
                                                                          parent:self.playerView
                                                                   launchOptions:nil];
  
  [self.ooyalaPlayerViewController willMoveToParentViewController:self];
  [self addChildViewController:self.ooyalaPlayerViewController];
  self.ooyalaPlayerViewController.view.frame = self.playerView.bounds;
  [self.ooyalaPlayerViewController didMoveToParentViewController:self];
  
  self.stateLabel.text = self.dtoAsset.stateText;
  self.playOfflineButton.enabled = self.dtoAsset.state == OODtoAssetStateDownloaded ? YES : NO;

  // We're setting progress and finish closures for the given OODtoAsset in order to represent state
  __weak PlayerViewController *weakSelf = self;
  [self.dtoAsset progressWithProgressClosure:^(double progress) {
    dispatch_async(dispatch_get_main_queue(), ^{
      weakSelf.stateLabel.text = [NSString stringWithFormat:@"%@ %.02f%%",
                                  weakSelf.dtoAsset.stateText, progress * 100];
    });
  }];
  [self.dtoAsset finishWithRelativePath:^(NSString * _Nonnull relativePath) {
    dispatch_async(dispatch_get_main_queue(), ^{
      weakSelf.stateLabel.text = weakSelf.dtoAsset.stateText;
      weakSelf.playOfflineButton.enabled = YES;
    });
  }];
  [self.dtoAsset onErrorWithErrorClosure:^(OOOoyalaError * _Nullable error) {
    dispatch_async(dispatch_get_main_queue(), ^{
      weakSelf.stateLabel.text = weakSelf.dtoAsset.stateText;
      weakSelf.playOfflineButton.enabled = NO;
    });
  }];
}

// action linked to the online video button
- (IBAction)playOnline {
  if (self.currentMode == Online) {
    [self restartVideo];
  } else {
    [self.ooyalaPlayerViewController.player setEmbedCode:self.dtoAsset.embedCode];
    self.currentMode = Online;
  }
}

// action linked to the offline video button
- (IBAction)playOffline {
  if (self.currentMode == Offline) {
    [self restartVideo];
  } else {
    OOOfflineVideo *video = self.dtoAsset.offlineVideo;
    if (video) {
      [self.ooyalaPlayerViewController.player setUnbundledVideo:video];
    }
    self.currentMode = Offline;
  }
}

- (void)restartVideo {
  [self.ooyalaPlayerViewController.player pause];
  [self.ooyalaPlayerViewController.player setPlayheadTime:0];
  [self.ooyalaPlayerViewController.player play];
}

@end

