/**
 * This activity illustrates how you configure your application to run Fairplay assets
 *
 * This activity will NOT Playback any video.  You will need to:
 *  1) provide your own embed code, which has Fairplay protection
 *  2) provide your own PCODE, which owns the embed code
 *  3) have your API Key and Secret, which correlate to a user from the provider
 *
 * To play OPT-enabled videos, you must implement the OOEmbedTokenGenerator interface
 */

#import "FairplayPlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>

@interface FairplayPlayerViewController () <OOEmbedTokenGenerator>

#pragma mark - Private properties

@property OOOoyalaPlayerViewController *ooyalaPlayerViewController;

@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;

// required for FairPlay.
@property NSString *apiKey;
@property NSString *secret;
// additionaly required if using OPT.
@property NSString *authorizeHost;
@property NSString *accountId;

@end


@implementation FairplayPlayerViewController

#pragma mark - Initializaiton

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];
  self.nib = @"PlayerSimple";

  if (self.playerSelectionOption) {
    self.embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
    self.pcode = self.playerSelectionOption.pcode;
    self.playerDomain = self.playerSelectionOption.domain;
  } else {
    NSLog(@"There was no PlayerSelectionOption!");
    return nil;
  }

  /*
   * The API Key and Secret should not be saved inside your applciation (even in git!).
   * However, for debugging you can use them to locally generate Ooyala Player Tokens.
   */
  self.apiKey = @"Fill me in";
  self.secret = @"Fill me in";
  self.accountId = @"Fill me in";
  self.authorizeHost = @"http://player.ooyala.com";
  [OODebugMode setDebugMode:LogAndAbort];
  ASSERT([self.apiKey containsString:self.pcode], @"self.pcode must be the long prefix of self.apiKey.");

  return self;
}

#pragma mark - Life cycle

- (void)loadView {
  [super loadView];
  [NSBundle.mainBundle loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  OOOptions *options = [OOOptions new];

  // For this example, we use the OOEmbededSecureURLGenerator to create the signed URL on the client
  // This is not how this should be implemented in production - In production, you should implement your own OOSecureURLGenerator
  //   which contacts a server of your own, which will help sign the url with the appropriate API Key and Secret
  options.secureURLGenerator = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey secret:self.secret];

  // Create Ooyala ViewController, with self as the embed token generator
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc]initWithString:self.playerDomain]
                                             embedTokenGenerator:self
                                                         options:options];

  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];

  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationReceived:)
                                             name:nil
                                           object:self.ooyalaPlayerViewController.player];
  
  [self addPlayerViewController:self.ooyalaPlayerViewController onView:self.playerView];

  // Begin play
  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];
}

#pragma mark - Private functions

- (void)addPlayerViewController:(UIViewController *)playerViewController onView:(UIView *)view {
  [self addChildViewController:playerViewController];
  [view addSubview:playerViewController.view];
  
  // Add constraints
  playerViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
  
  if (@available(iOS 11.0, *)) {
    [NSLayoutConstraint activateConstraints:@[
      [playerViewController.view.topAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.topAnchor],
      [playerViewController.view.trailingAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.trailingAnchor],
      [playerViewController.view.bottomAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.bottomAnchor],
      [playerViewController.view.leadingAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.leadingAnchor]
    ]];
  } else {
    [NSLayoutConstraint activateConstraints:@[
      [playerViewController.view.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor],
      [playerViewController.view.trailingAnchor constraintEqualToAnchor:view.trailingAnchor],
      [playerViewController.view.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor],
      [playerViewController.view.leadingAnchor constraintEqualToAnchor:view.leadingAnchor]
    ]];
  }
}

- (void)notificationReceived:(NSNotification*) notification {
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
- (void)tokenForEmbedCodes:(NSArray *)embedCodes callback:(OOEmbedTokenCallback)callback {
  NSDictionary *params = @{@"account_id": self.accountId};
  NSString* uri = [NSString stringWithFormat:@"/sas/embed_token/%@/%@", self.pcode, [embedCodes componentsJoinedByString:@","]];
  
  OOEmbeddedSecureURLGenerator* urlGen = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey secret:self.secret];
  NSURL* embedTokenUrl = [urlGen secureURL:self.authorizeHost uri:uri params:params];
  callback(embedTokenUrl.absoluteString);
}


@end
