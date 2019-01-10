//
//  ProgrammaticVolumePlayerViewController.m
//  AdvancedPlaybackSampleApp
//

#import "ProgrammaticVolumePlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"


/**
 * This ViewController illustrates how you can change the volume of the OOOoyalaPlayer programmatically.
 * Here you can see the volume being set onCreate, and changed every tick of TIME_CHANGED
 *
 * Over 10 seconds, volume should slowly increase from muted to full volume
 *
 * Please read the APIDocs for [OoyalaPlayer setVolume] for more information
 *
 */
@interface ProgrammaticVolumePlayerViewController ()

#pragma mark - Private properties

@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;

@end


@implementation ProgrammaticVolumePlayerViewController {
  AppDelegate *appDel;
}

#pragma mark - Initialization

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled{
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
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

#pragma mark - Life cycle

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  // Add self as an observer for the OoyalaPlayer
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:self.ooyalaPlayerViewController.player];
  // In QA Mode , making textView visible
  self.textView.hidden = !self.qaModeEnabled;
  
  // Attach it to current view
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];
  
  // You can set the volume anytime after OOOoyalaPlayer is instantiated
  [player setVolume:0.0f];
  
  // Load the video
  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];
}

- (void) notificationHandler:(NSNotification*) notification {
  
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
  
    // Slowly increase the volume every tick of playback.
    [self.ooyalaPlayerViewController.player setVolume: self.ooyalaPlayerViewController.player.volume + .025f];
    return;
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                       [notification name],
                       [OOOoyalaPlayerStateConverter playerStateToString:[self.ooyalaPlayerViewController.player state]],
                       [self.ooyalaPlayerViewController.player playheadTime], appDel.count];
  
  NSLog(@"%@",message);
  
  // In QA Mode , adding notifications to the TextView
  if (self.qaModeEnabled) {
    NSString *string = self.textView.text;
    NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@" ,string, message];
    dispatch_async(dispatch_get_main_queue(), ^{
      self.textView.text = appendString;
    });
  }
  appDel.count++;
}


@end
