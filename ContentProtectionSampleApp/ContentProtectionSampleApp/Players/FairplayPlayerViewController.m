#import "FairplayPlayerViewController.h"
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSDK/OOooyalaError.h>
#import <OoyalaSDK/OOOptions.h>
#import <OoyalaSDK/OOEmbeddedSecureURLGenerator.h>
#import <OoyalaSDK/OODebugMode.h>

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
@interface FairplayPlayerViewController () <OOEmbedTokenGenerator>
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

@property(nonatomic, strong) UIAlertView *nicknameDialog;
@property(nonatomic) NSString *publicDeviceId;
@end

@implementation FairplayPlayerViewController

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];
  self.nib = @"PlayerSimple";
  self.pcode = @"x0b2cyOupu0FFK5hCr4zXg8KKcrm";
  self.playerDomain = @"http://www.ooyala.com";
  self.authorizeHost = @"http://player.ooyala.com";
  /*
   * The API Key and Secret should not be saved inside your applciation (even in git!).
   * However, for debugging you can use them to locally generate Ooyala Player Tokens.
   */
  self.apiKey = @"Fill me in";
  [OODebugMode setDebugMode:LogAndAbort];
  ASSERT( [self.apiKey containsString:self.pcode], @"self.pcode must be the long prefix of self.apiKey." );
  self.secret = @"Fill me in";
  self.accountId = @"Fill me in";

  if (self.playerSelectionOption) {
    self.embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
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

  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationReceived:)
                                               name:nil
                                             object:self.ooyalaPlayerViewController.player];

  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];

  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];
}

- (void) notificationReceived:(NSNotification*) notification {

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
