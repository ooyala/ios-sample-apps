/**
 * @class      SecurePlayerOPTPlayerViewController SecurePlayerOPTPlayerViewController.m "SecurePlayerOPTPlayerViewController.m"
 * @brief      A Player that demonstrates how to use Ooyala Player Token alongside SecurePlayer
 * @details    This PlayerViewController is not used by default by any option, and must be configured to use correctly
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "SecurePlayerOPTPlayerViewController.h"
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSDK/OOStreamPlayer.h>
#import <OoyalaSDK/OOooyalaError.h>
#import <OoyalaSDK/OOEmbeddedSecureURLGenerator.h>
#import <OoyalaSecurePlayerSDK/OOOoyalaSecurePlayerSDK.h>

/**
 * This activity illustrates how you use Ooyala Player Token.
 * Ooyala Player Token can also be used in conjunction with the following security mechanisms
 * 1) Device Management,
 * 2) Concurrent Streams,
 * 3) Entitlements, and
 * 4) Stream Takedown
 *
 * This activity will NOT Playback any video.  You will need to:
 *  1) provide your own embed code, restricted with Ooyala Player Token
 *  2) provide your own PCODE, which owns the embed code
 *  3) have your API Key and Secret, which correlate to a user from the provider
 *
 * To play OPT-enabled videos, you must implement the OOEmbedTokenGenerator interface
 */

@interface SecurePlayerOPTPlayerViewController () <OOEmbedTokenGenerator>

@property (strong, nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;

@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;

@property NSString *authorizeHost;
@property NSString *apiKey;
@property NSString *secret;
@property NSString *accountId;
@end

@implementation SecurePlayerOPTPlayerViewController

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super init];
  self.nib = @"PlayerSimple";

  if (playerSelectionOption) {
    self.embedCode = playerSelectionOption.embedCode;
    self.title = playerSelectionOption.title;
    self.pcode = playerSelectionOption.pcode;
    self.playerDomain= playerSelectionOption.domain;
  }

  self.apiKey = @"";
  self.secret = @"";
  self.accountId = @"";
  self.authorizeHost = @"http://player.ooyala.com";
  return self;
}

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] embedTokenGenerator:self];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];

  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:self.ooyalaPlayerViewController.player];


  [OOStreamPlayer setDefaultPlayerInfo: [OOSecurePlayerPlayerInfo new]];
  // choose the right Personaliztion url for your context.
  NSString *purl;
  purl = OO_HTTP_PRE_PRODUCTION_PERSONALIZATION_SERVER;
  // purl = OO_HTTP_PRODUCTION_PERSONALIZATION_SERVER;
  // purl = [OOOoyalaSecurePlayerSDK formatOoyalaPersonalizationServerUrl];
  [OOOoyalaSecurePlayerSDK
   registerSecurePlayerMapping:_ooyalaPlayerViewController.player.streamPlayerMapping
   appVersion:@"0.0.1"
   sessionId:@"sessionId"
   personalizationServerUrl:purl];



  // Attach it to current view
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];

  // Load the video
  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];

}

- (void) notificationHandler:(NSNotification*) notification {

  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }

  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.ooyalaPlayerViewController.player state]],
        [self.ooyalaPlayerViewController.player playheadTime]);
}

/*
 * Get the Ooyala Player Token to play the embed code.
 * This should contact your servers to generate the OPT server-side.
 * For debugging, you can use Ooyala's EmbeddedSecureURLGenerator to create local embed tokens
 */
- (void)tokenForEmbedCodes:(NSArray *)embedCodes callback:(OOEmbedTokenCallback)callback {
  NSMutableDictionary* params = [NSMutableDictionary dictionary];

  params[@"account_id"] = self.accountId;
  NSString* uri = [NSString stringWithFormat:@"/sas/embed_token/%@/%@", self.pcode, [embedCodes componentsJoinedByString:@","]];

  OOEmbeddedSecureURLGenerator* urlGen = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey secret:self.secret];
  NSURL* embedTokenUrl = [urlGen secureURL:self.authorizeHost uri:uri params:params];
  callback([embedTokenUrl absoluteString]);
}


@end
