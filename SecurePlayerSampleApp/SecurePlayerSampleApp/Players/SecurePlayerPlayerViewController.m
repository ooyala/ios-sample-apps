/**
 * @class      SecurePlayerPlayerViewController SecurePlayerPlayerViewController.m "SecurePlayerPlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    SecurePlayerPlayerViewController in Ooyala Sample Apps
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */


#import "SecurePlayerPlayerViewController.h"
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSDK/OOStreamPlayer.h>
#import <OoyalaSecurePlayerSDK/OOOoyalaSecurePlayerSDK.h>

#import "PlayerSelectionOption.h" 

@interface SecurePlayerPlayerViewController ()
@property (strong, nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;

@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@end

@implementation SecurePlayerPlayerViewController

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super init];
  self.nib = @"PlayerSimple";
  
  if (playerSelectionOption) {
    self.embedCode = playerSelectionOption.embedCode;
    self.title = playerSelectionOption.title;
    self.pcode = playerSelectionOption.pcode;
    self.playerDomain= playerSelectionOption.domain;
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
@end
