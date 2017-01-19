//
//  ProgrammaticVolumePlayerViewController.m
//  AdvancedPlaybackSampleApp
//

#import "ProgrammaticVolumePlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"

/**
 * on TimeChangedNotification, we will lower the volume by .025.  That means after ~10 seconds, the volume will be muted
 */

@interface ProgrammaticVolumePlayerViewController ()
@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;

@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;
@end

@implementation ProgrammaticVolumePlayerViewController

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
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
  return self;
}

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];


  // Add self as an observer for the OoyalaPlayer
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:self.ooyalaPlayerViewController.player];

  // Attach it to current view
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];

  // You can set the volume anytime after OOOoyalaPlayer is instantiated
  [player setVolume:1.f];

  // Load the video
  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];

}

- (void) notificationHandler:(NSNotification*) notification {

  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {

    // Slowly lower the volume every tick of playback.
    [self.ooyalaPlayerViewController.player setVolume: self.ooyalaPlayerViewController.player.volume - .025f];
    return;
  }

  NSLog(@"Notification Received: %@. state: %@. playhead: %f count: %d",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.ooyalaPlayerViewController.player state]],
        [self.ooyalaPlayerViewController.player playheadTime], ((AppDelegate *)[[UIApplication sharedApplication] delegate]).count);
  ((AppDelegate *)[[UIApplication sharedApplication] delegate]).count++;
}

@end
