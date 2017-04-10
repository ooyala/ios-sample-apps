#import "DoublePlayerPlayerViewController.h"
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>
#import <OoyalaSDK/OoyalaSDK.h>

@interface DoublePlayerPlayerViewController ()

@property (nonatomic, retain) OOSkinViewController *skinController;

@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@end

@implementation DoublePlayerPlayerViewController

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];

  if (self.playerSelectionOption) {
    self.nib = self.playerSelectionOption.nib;
    self.embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
    self.playerDomain = playerSelectionOption.playerDomain;
    self.pcode = playerSelectionOption.pcode;
  }
  return self;
}

- (void) loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void) createPlayer: (NSString *)embedCode view: (UIView *)videoView {

  OOOptions *options = [OOOptions new];
  OOOoyalaPlayer *ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] options:options];
  ooyalaPlayer.actionAtEnd = OOOoyalaPlayerActionAtEndPause;  //This is recommended to make sure the endscreen shows up as expected
  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular limit:10 timeout:60];
  NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  //  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
  NSDictionary *overrideConfigs = @{@"upNextScreen": @{@"timeToShow": @"8"}};

  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions jsCodeLocation:jsCodeLocation configFileName:@"skin" overrideConfigs:overrideConfigs];
  OOSkinViewController *skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaPlayer skinOptions:skinOptions parent:videoView launchOptions:nil];
  [self addChildViewController:skinController];
  [skinController.view setFrame:videoView.bounds];

  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:skinController];

  [ooyalaPlayer setEmbedCode:embedCode];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self createPlayer:self.embedCode view:self.videoView];
  [self createPlayer:@"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx" view:self.videoView2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) notificationHandler:(NSNotification*) notification {

  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }

  // Check for FullScreenChanged notification
  if ([notification.name isEqualToString:OOSkinViewControllerFullscreenChangedNotification]) {
    NSString *message = [NSString stringWithFormat:@"Notification Received: %@. isfullscreen: %@. ",
                         [notification name],
                         [[notification.userInfo objectForKey:@"fullScreen"] boolValue] ? @"YES" : @"NO"];
    NSLog(@"%@", message);
  }
}

@end
