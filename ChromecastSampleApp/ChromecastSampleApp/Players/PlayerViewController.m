//
//  PlayerViewController.m
//  ChromecastSampleApp
//
//  Created on 9/18/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

#import "PlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "OOCastManagerFetcher.h"
#import "CastPlaybackView.h"
#import "ChromecastPlayerSelectionOption.h"

@interface PlayerViewController ()

@property (nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (nonatomic) IBOutlet UIView *videoView;
@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (nonatomic) OOOoyalaPlayer *ooyalaPlayer;
@property (nonatomic) OOCastManager *castManager;
@property (nonatomic) CastPlaybackView *castPlaybackView;

@property NSString *embedCode;
@property NSString *embedCode2;
@property NSString *pcode;
@property NSString *playerDomain;

@property NSString *authorizeHost;
@property NSString *apiKey;
@property NSString *secret;
@property NSString *accountId;

@property UITextView *textView;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  /*
   * The API Key and Secret should not be saved inside your applciation (even in git!).
   * However, for debugging you can use them to locally generate Ooyala Player Tokens.
   */
  self.authorizeHost = @"http://player.ooyala.com";
  self.apiKey = @"fill me in";
  self.secret = @"fill me in";
  self.accountId = @"accountId";
  
  // Fetch castManager and castButton
  self.castManager = [OOCastManagerFetcher fetchCastManager];
  self.castManager.delegate = self;
  
  // Add Chromecast button
  UIBarButtonItem *chromecastItem = [[UIBarButtonItem alloc] initWithCustomView:self.castManager.castButton];
  self.navigationBar.rightBarButtonItem = chromecastItem;
  
  // Add custom parameters
  NSDictionary *customParams = @{@"userName":      @"User",
                                 @"initialVolume": @"1",
                                 @"embedToken":    self.mediaInfo.embedCode,
                                 @"title":         self.mediaInfo.title,
                                 @"description":   @"New description"};
  self.castManager.additionalInitParams = customParams;
  
  // Fetch content info and load ooyalaPlayerViewController and ooyalaPlayer
  self.pcode = self.mediaInfo.pcode;
  self.playerDomain = self.mediaInfo.domain;
  self.embedCode = self.mediaInfo.embedCode;
  self.embedCode2 = self.mediaInfo.embedCode2;

  self.ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                     domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]
                                        embedTokenGenerator:self];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:self.ooyalaPlayer];
  
  self.ooyalaPlayerViewController.view.frame = self.videoView.bounds;
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.videoView addSubview:self.ooyalaPlayerViewController.view];
  
  self.castPlaybackView = [[CastPlaybackView alloc] initWithFrame:self.videoView.frame];
  [self.castManager setCastModeVideoView:self.castPlaybackView];

  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.ooyalaPlayerViewController.player];

  // Init the castManager in the ooyalaPlayer
  [self.ooyalaPlayer initCastManager:self.castManager];
  [self play:self.embedCode];
}

- (void)play:(NSString *)embedCode {
  [self.ooyalaPlayer setEmbedCode:embedCode];
  [self.ooyalaPlayer play];
}

- (void)notificationHandler:(NSNotification *)notification {
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    // return here to avoid logging TimeChangedNotificiations for shorter logs
    return;
  }
  if ([notification.name isEqualToString:OOOoyalaPlayerStateChangedNotification]) {
    [self.castPlaybackView updateTextView:self.ooyalaPlayer.currentItem
                              displayName:self.receiverDisplayName
                            displayStatus:self.receiverDisplayStatus];
  }
  if ([notification.name isEqualToString:OOOoyalaPlayerCurrentItemChangedNotification]) {
    [self.castPlaybackView configureCastPlaybackViewBasedOnItem:self.ooyalaPlayer.currentItem
                                                    displayName:self.receiverDisplayName
                                                  displayStatus:self.receiverDisplayStatus];
  }
  if ([notification.name isEqualToString:OOOoyalaPlayerPlayCompletedNotification]) {
    [self.castPlaybackView playCompleted:self.receiverDisplayName
                           displayStatus:self.receiverDisplayStatus];
    if (self.embedCode2) {
      [self play:self.embedCode2];
      self.embedCode2 = nil;
    }
  }

  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayerStateConverter playerStateToString:[self.ooyalaPlayerViewController.player state]],
        [self.ooyalaPlayerViewController.player playheadTime]);
}

#pragma mark - OOCastManagerDelegate

- (void)castManagerDidEnterCastMode:(OOCastManager *)manager {
  [self.ooyalaPlayerViewController setFullScreenButtonShowing:NO];
  [self.ooyalaPlayerViewController setVolumeButtonShowing:YES];
}

- (void)castManagerDidExitCastMode:(OOCastManager *)manager {
  [self.ooyalaPlayerViewController setVolumeButtonShowing:NO];
  [self.ooyalaPlayerViewController setFullScreenButtonShowing:YES];
}

- (void)castManagerDidDisconnect:(OOCastManager *)manager {
}

- (void)castManager:(nonnull OOCastManager *)manager
didFailToStartSessionWithError:(nonnull NSError *)error {
}

- (void)castManager:(nonnull OOCastManager *)manager
didEndSessionWithError:(nonnull NSError *)error {
}

- (void)castManager:(nonnull OOCastManager *)manager
 castRequestWithtId:(NSInteger)requestId
   didFailWithError:(nonnull GCKError *)error {
}

# pragma mark -

- (NSString *)receiverDisplayName {
  NSString *name = @"Unknown";
  if (self.castManager.selectedDevice.friendlyName) {
    name = self.castManager.selectedDevice.friendlyName;
  } else if (self.castManager.selectedDevice.modelName) {
    name = self.castManager.selectedDevice.modelName;
  }
  return name;
}

- (NSString *)receiverDisplayStatus {
  NSString *status = @"Not connected";
  if (self.castManager.isInCastMode) {
    switch (self.castManager.state) {
      case OOOoyalaPlayerStatePlaying: {
        status = @"Playing";
        break;
      }
      case OOOoyalaPlayerStatePaused: {
        status = @"Paused";
        break;
      }
      case OOOoyalaPlayerStateLoading: {
        status = @"Buffering";
        break;
      }
      default: {
        status = @"Connected";
        break;
      }
    }
  }
  return status;
}

/*
 * Get the Ooyala Player Token to play the embed code.
 * This should contact your servers to generate the OPT server-side.
 * For debugging, you can use Ooyala's EmbeddedSecureURLGenerator to create local embed tokens
 */
- (void)tokenForEmbedCodes:(NSArray<NSString *> *)embedCodes
                  callback:(OOEmbedTokenCallback)callback {
  NSDictionary *params = @{@"account_id": self.accountId};
  NSString *uri = [NSString stringWithFormat:@"/sas/embed_token/%@/%@",
                   self.pcode, [embedCodes componentsJoinedByString:@","]];

  OOEmbeddedSecureURLGenerator *urlGen = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey
                                                                                       secret:self.secret];
  NSURL *embedTokenUrl = [urlGen secureURLForHost:self.authorizeHost uri:uri params:params];
  callback(embedTokenUrl.absoluteString);
}

@end
