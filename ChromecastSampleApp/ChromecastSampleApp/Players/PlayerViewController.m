//
//  PlayerViewController.m
//  ChromecastSampleApp
//
//  Created by Liusha Huang on 9/18/14.
//  Copyright (c) 2014 Liusha Huang. All rights reserved.
//

#import "PlayerViewController.h"
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOEmbeddedSecureURLGenerator.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSDK/OOVideo.h>
#import <OoyalaSDK/OODebugMode.h>
#import <OoyalaCastSDK/OOCastPlayer.h>
#import "Utils.h"
#import "OOCastManagerFetcher.h"

@interface PlayerViewController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) IBOutlet UIView *mediaDetailView;
@property (strong, nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (strong, nonatomic) OOOoyalaPlayer *ooyalaPlayer;
@property (strong, nonatomic) OOCastManager *castManager;

@property NSString *embedCode;
@property NSString *embedCode2;
@property NSString *pcode;
@property NSString *playerDomain;

@property NSString *authorizeHost;
@property NSString *apiKey;
@property NSString *secret;
@property NSString *accountId;

@property UIImageView *castPlaybackView;
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
  
  UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc] initWithCustomView:[self.castManager getCastButton]];
  self.navigationBar.rightBarButtonItem = leftbutton;
  
  // Fetch content info and load ooyalaPlayerViewController and ooyalaPlayer
  self.pcode = self.mediaInfo.pcode;
  self.playerDomain = self.mediaInfo.domain;
  self.embedCode = self.mediaInfo.embedCode;
  self.embedCode2 = self.mediaInfo.embedCode2;

  self.ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] embedTokenGenerator:self];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:self.ooyalaPlayer];
  
  [self.ooyalaPlayerViewController.view setFrame:self.videoView.bounds];
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.videoView addSubview:self.ooyalaPlayerViewController.view];
  
  self.castPlaybackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.videoView.frame.size.width, self.videoView.frame.size.height)];
  [self.castManager setCastModeVideoView:self.castPlaybackView];
  
  // Init the castManager in the ooyalaPlayer
  [self.ooyalaPlayer initCastManager:self.castManager];
  
  [self play:self.embedCode];
}

-(void) play:(NSString*)embedCode {
  [self.ooyalaPlayer setEmbedCode:embedCode];
  if( self.castManager.castPlayer.state != OOOoyalaPlayerStatePaused ) {
    [self.ooyalaPlayer play];
  }
}

- (void) notificationHandler:(NSNotification*) notification {
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    [self configureCastPlaybackViewBasedOnItem:self.ooyalaPlayer.currentItem];
    // return here to avoid logging TimeChangedNotificiations for shorter logs
    return;
  }
  if ([notification.name isEqualToString:OOOoyalaPlayerStateChangedNotification]) {
    [self configureCastPlaybackViewBasedOnItem:self.ooyalaPlayer.currentItem];
  }
  if ([notification.name isEqualToString:OOOoyalaPlayerCurrentItemChangedNotification]) {
    [self configureCastPlaybackViewBasedOnItem:self.ooyalaPlayer.currentItem];
  }
  if ([notification.name isEqualToString:OOOoyalaPlayerPlayCompletedNotification] && self.embedCode2) {
    [self play:self.embedCode2];
    self.embedCode2 = nil;
  }

  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.ooyalaPlayerViewController.player state]],
        [self.ooyalaPlayerViewController.player playheadTime]);
}
- (void)onCastModeEnter {
  [self.ooyalaPlayerViewController setFullScreenButtonShowing:false];
}

- (void)onCastModeExit {
  [self.ooyalaPlayerViewController setFullScreenButtonShowing:true];
}

-(void) onCastManagerNotification:(NSNotification*)notification {
  LOG( @"onCastManagerNotification: %@", notification );
}

- (UIViewController *)currentTopUIViewController {
  return [Utils currentTopUIViewController];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(onCastManagerNotification:)
                                               name:nil
                                             object:self.castManager];
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:_ooyalaPlayerViewController.player];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(onCastModeEnter)
                                               name:OOCastEnterCastModeNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(onCastModeExit)
                                               name:OOCastExitCastModeNotification
                                             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 * Use the currentItem from OoyalaPlayer to create a CastPlayerView, to be shown during cast playback
 * Shows the title, description, and promo image url
 */
- (void)configureCastPlaybackViewBasedOnItem:(OOVideo *)item {
  if( self.textView == nil ) {
    [self buildPlaybackView:item];
  }
  [self updateTextView:item];
}

-(NSString*) getReceiverDisplayName {
  NSString *name = @"Unknown";
  if( self.castManager.selectedDevice.friendlyName ) {
    name = self.castManager.selectedDevice.friendlyName;
  }
  else if( self.castManager.selectedDevice.modelName ) {
    name = self.castManager.selectedDevice.modelName;
  }
  return name;
}

-(NSString*) getReceiverDisplayStatus {
  NSString *status = @"Not connected";
  if( self.castManager.isInCastMode ) {
    switch( self.castManager.castPlayer.state ) {
      case OOOoyalaPlayerStatePlaying: { status = @"Playing"; break; }
      case OOOoyalaPlayerStatePaused: { status = @"Paused"; break; }
      case OOOoyalaPlayerStateLoading: { status = @"Buffering"; break; }
      default: { status = @"Connected"; break; }
    }
  }
  return status;
}

-(void) updateTextView:(OOVideo*)item {
  if( self.textView ) {
    dispatch_async( dispatch_get_main_queue(), ^{
      NSString *videoTitle = item.title;
      NSString *videoDescription = item.itemDescription;
      self.textView.text = [NSString stringWithFormat:@"\n\n Title: %@\n\n Description: %@\n\n Receiver: %@\n\n State: %@",
                            videoTitle,
                            videoDescription,
                            [self getReceiverDisplayName],
                            [self getReceiverDisplayStatus]];
    });
  }
}

-(void) buildPlaybackView:(OOVideo*)item {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImage *image = [UIImage imageWithData:[Utils getDataFromImageURL:item.promoImageURL]];

    dispatch_sync(dispatch_get_main_queue(), ^{
      [[self.castPlaybackView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
      self.castPlaybackView.image = image;
      [self.castPlaybackView.layer setBorderColor:[UIColor redColor].CGColor];
      [self.castPlaybackView.layer setBorderWidth:5.0];
      self.castPlaybackView.contentMode = UIViewContentModeScaleAspectFit;

      self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.videoView.frame.size.width, self.videoView.frame.size.height)];
      self.textView.userInteractionEnabled = NO;
      [self.textView setFont:[UIFont boldSystemFontOfSize:30]];
      self.textView.textColor = [UIColor whiteColor];
      self.textView.backgroundColor = [UIColor clearColor];
      self.textView.textAlignment = NSTextAlignmentCenter;
      self.textView.center = self.videoView.center;
      [self.textView setTranslatesAutoresizingMaskIntoConstraints:NO];
      [self.castPlaybackView addSubview:self.textView];

      NSLayoutConstraint *w =[NSLayoutConstraint
                              constraintWithItem:self.textView
                              attribute:NSLayoutAttributeWidth
                              relatedBy:0
                              toItem:self.castPlaybackView
                              attribute:NSLayoutAttributeWidth
                              multiplier:1.0
                              constant:0];
      NSLayoutConstraint *h =[NSLayoutConstraint
                              constraintWithItem:self.textView
                              attribute:NSLayoutAttributeHeight
                              relatedBy:0
                              toItem:self.castPlaybackView
                              attribute:NSLayoutAttributeHeight
                              multiplier:1.0
                              constant:0];
      NSLayoutConstraint *t = [NSLayoutConstraint
                               constraintWithItem:self.textView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.castPlaybackView
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:0.f];
      NSLayoutConstraint *l = [NSLayoutConstraint
                               constraintWithItem:self.textView
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.castPlaybackView
                               attribute:NSLayoutAttributeLeading
                               multiplier:1.0f
                               constant:0.f];
      [self.castPlaybackView addConstraint:w];
      [self.castPlaybackView addConstraint:h];
      [self.castPlaybackView addConstraint:t];
      [self.castPlaybackView addConstraint:l];
    });
  });
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
