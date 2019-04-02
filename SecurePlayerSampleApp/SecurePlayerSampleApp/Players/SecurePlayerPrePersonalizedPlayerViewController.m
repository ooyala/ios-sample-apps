/**
 * @class      SecurePlayerPrePersonalizedPlayerViewController SecurePlayerPrePersonalizedPlayerViewController.m "SecurePlayerPrePersonalizedPlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    SecurePlayerPrePersonalizedPlayerViewController in Ooyala Sample Apps
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */


#import "SecurePlayerPrePersonalizedPlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import <OoyalaSecurePlayerSDK/OOOoyalaSecurePlayerSDK.h>
#import <OoyalaSecurePlayerSDK/OOSecurePlayerDrmWorkflow.h>
#import "PlayerSelectionOption.h" 

@interface SecurePlayerPrePersonalizedPlayerViewController ()
@property (strong, nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;

@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@end

@implementation SecurePlayerPrePersonalizedPlayerViewController

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
  
  NSString *APP_VERISON = @"0.0.1";
  NSString *SESSION_ID = @"sessionId";
  [OOOoyalaSecurePlayerSDK
   registerSecurePlayerMapping:_ooyalaPlayerViewController.player.streamPlayerMapping
   appVersion:APP_VERISON
   sessionId:SESSION_ID
   personalizationServerUrl:purl
   engineType:VO_OSMP_VOME2_PLAYER];
  
  dispatch_queue_t preQ = dispatch_queue_create("OOSecurePlayerDrmWorkflowQueue",NULL);
  [OOSecurePlayerDrmWorkflow
   startPersonalizationWithDxDrmManager:[DxDrmManager sharedManager]
   onQueue:preQ
   appVersion:APP_VERISON
   sessionId:SESSION_ID
   personalizationServerUrl:[OOSecurePlayerDrmWorkflow calculatePersonalizationURLWithPcode:self.pcode]
   delegate:^(DxDrmManagerStatus status) {
     void (^myblock)(void) = ^{ NSLog( @"pre-personalization: %@", status==DX_MANAGER_SUCCESS?@"OK":@"ERROR" ); };
     if( [NSThread isMainThread] ) { myblock(); }
     else { dispatch_async(dispatch_get_main_queue(), myblock); }
   }];

  // Attach it to current view
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];
  
  // Load the video
  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];
  
}

- (void)notificationHandler:(NSNotification *) notification {
  
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayerStateConverter playerStateToString:[self.ooyalaPlayerViewController.player state]],
        [self.ooyalaPlayerViewController.player playheadTime]);
}
@end
