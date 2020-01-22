//
//  OoyalaPlayerTokenPlayerViewController.m
//  ContentProtectionSampleApp
//
//  Created on 5/15/12.
//  Copyright © 2012 Ooyala Inc. All rights reserved.
//

#import "OoyalaPlayerTokenPlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "BasicEmbedTokenGenerator.h"

/**
 * This class illustrates how you use Ooyala Player Token.
 * Ooyala Player Token can also be used in conjunction with the following security mechanisms
 * 1) Device Management,
 * 2) Concurrent Streams,
 * 3) Entitlements, and
 * 4) Stream Takedown
 *
 * This class will NOT Playback any video.  You will need to:
 *  1) provide your own embed code, restricted with Ooyala Player Token
 *  2) provide your own PCODE, which owns the embed code
 *  3) have your API Key and Secret, which correlate to a user from the provider
 *
 * To play OPT-enabled videos, you must implement the OOEmbedTokenGenerator interface
 */
@interface OoyalaPlayerTokenPlayerViewController () <OOEmbedTokenGenerator>

@property OOOoyalaPlayerViewController *ooyalaPlayerViewController;

@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;

@property (nonatomic) NSString *authorizeHost;
@property (nonatomic) NSString *apiKey;
@property (nonatomic) NSString *secret;
@property (nonatomic) NSString *accountId;

@end

@implementation OoyalaPlayerTokenPlayerViewController

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];
  _nib = @"PlayerSimple";

  if (self.playerSelectionOption) {
    _embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
    _pcode = self.playerSelectionOption.pcode;
    _playerDomain = self.playerSelectionOption.domain;
  } else {
    NSLog(@"There was no PlayerSelectionOption!");
    return nil;
  }

  /*
   * The API Key and Secret should not be saved inside your application (even in git!).
   * However, for debugging you can use them to locally generate Ooyala Player Tokens.
   */
  if (self.playerSelectionOption.embedTokenGenerator &&
      [self.playerSelectionOption.embedTokenGenerator isKindOfClass:BasicEmbedTokenGenerator.class]) {
    BasicEmbedTokenGenerator *tokenGenerator = (BasicEmbedTokenGenerator *)self.playerSelectionOption.embedTokenGenerator;
    _apiKey        = tokenGenerator.apiKey;
    _secret        = tokenGenerator.apiSecret;
    _accountId     = tokenGenerator.accountId;
    _authorizeHost = tokenGenerator.authorizeHost;
  } else {
    _apiKey        = @"API_KEY";
    _secret        = @"API_SECRET";
    _accountId     = @"ACCOUNT_ID";
    _authorizeHost = @"AUTHORIZE_HOST";
  }
  [OODebugMode setDebugMode:LogAndAbort];
  ASSERT([self.apiKey containsString:self.pcode], @"self.pcode must be the long prefix of self.apiKey.");

  return self;
}

- (void)loadView {
  [super loadView];
  [NSBundle.mainBundle loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Create Ooyala ViewController, with self as the embed token generator
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]
                                             embedTokenGenerator:self];

  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];

  [NSNotificationCenter.defaultCenter addObserver: self
                                         selector:@selector(notificationReceived:)
                                             name:nil
                                           object:self.ooyalaPlayerViewController.player];

  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  self.ooyalaPlayerViewController.view.frame = self.playerView.bounds;
  
  // Add constraints
  [NSLayoutConstraint activateConstraints:@[
                                            [self.ooyalaPlayerViewController.view.topAnchor constraintEqualToAnchor:self.playerView.topAnchor],
                                            [self.ooyalaPlayerViewController.view.leadingAnchor constraintEqualToAnchor:self.playerView.leadingAnchor],
                                            [self.ooyalaPlayerViewController.view.bottomAnchor constraintEqualToAnchor:self.playerView.bottomAnchor],
                                            [self.ooyalaPlayerViewController.view.trailingAnchor constraintEqualToAnchor:self.playerView.trailingAnchor]
                                            ]];

  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];
}

- (void)notificationReceived:(NSNotification *)notification {
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }

  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayerStateConverter playerStateToString:[self.ooyalaPlayerViewController.player state]],
        [self.ooyalaPlayerViewController.player playheadTime]);
}

/*
 * Get the Ooyala Player Token to play the embed code.
 * This should contact your servers to generate the OPT server-side.
 * For debugging, you can use Ooyala's EmbeddedSecureURLGenerator to create local embed tokens
 */
- (void)tokenForEmbedCodes:(NSArray<NSString *> *)embedCodes
                  callback:(OOEmbedTokenCallback)callback {
  NSDictionary *params = @{@"account_id": self.accountId};

  NSString *uri = [NSString stringWithFormat:@"/sas/embed_token/%@/%@", self.pcode, [embedCodes componentsJoinedByString:@","]];

  OOEmbeddedSecureURLGenerator* urlGen = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey
                                                                                       secret:self.secret];
  NSURL* embedTokenUrl = [urlGen secureURLForHost:self.authorizeHost uri:uri params:params];
  callback(embedTokenUrl.absoluteString);
}

@end
