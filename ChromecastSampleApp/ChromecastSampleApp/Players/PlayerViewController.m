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
#import "Utils.h"


@interface PlayerViewController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) IBOutlet UIView *mediaDetailView;
@property (strong, nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (strong, nonatomic) OOOoyalaPlayer *ooyalaPlayer;
@property (strong, nonatomic) OOCastManager *castManager;

@property NSString *embedCode;
@property NSString *pcode;
@property NSString *playerDomain;

@property NSString *authorizeHost;
@property NSString *apiKey;
@property NSString *secret;
@property NSString *accountId;
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
  self.castManager = [OOCastManager getCastManagerWithAppID:@"4172C76F" namespace:@"urn:x-cast:ooyala"];
  self.castManager.delegate = self;
  
  UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc] initWithCustomView:[self.castManager getCastButton]];
  self.navigationBar.rightBarButtonItem = leftbutton;

  // Fetch content info and load ooyalaPlayerViewController and ooyalaPlayer
  self.pcode = [self.mediaInfo valueForKey:@"pcode"];
  self.playerDomain = [self.mediaInfo valueForKey:@"domain"];
  self.embedCode = [self.mediaInfo valueForKey:@"embedcode"];


  self.ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] embedTokenGenerator:self];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:self.ooyalaPlayer];

  [self.ooyalaPlayerViewController.view setFrame:self.videoView.bounds];
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.videoView addSubview:self.ooyalaPlayerViewController.view];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(onCastModeEnter)
                                               name:OOCastEnterCastModeNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(onCastModeExit)
                                               name:OOCastExitCastModeNotification
                                             object:nil];

  // Init the castManager in the ooyalaPlayer
  [self.ooyalaPlayer initCastManager:self.castManager];
  [self.ooyalaPlayer setEmbedCode:self.embedCode];
  if (![self.castManager isInCastMode]){
    [self.ooyalaPlayer play];
  }
}

- (void)onCastModeEnter {
  [self.ooyalaPlayerViewController setFullScreenButtonShowing:false];
}

- (void)onCastModeExit {
  [self.ooyalaPlayerViewController setFullScreenButtonShowing:true];
}

- (UIViewController *)currentTopUIViewController {
  return [Utils currentTopUIViewController];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImage *image = [UIImage imageWithData:[Utils getDataFromImageURL:[self.mediaInfo objectForKey:@"imgurl"]]];
    dispatch_sync(dispatch_get_main_queue(), ^{
      UIImageView *mediaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.videoView.frame.size.width, self.videoView.frame.size.height)];
      mediaImageView.image = image;UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.videoView.frame.size.width, self.videoView.frame.size.height)];
      textView.userInteractionEnabled = NO;
      NSString *videoTitle = [self.mediaInfo objectForKey:@"title"];
      NSString *videoDescription = [self.mediaInfo objectForKey:@"description"];
      textView.text = [NSString stringWithFormat:@"\n\n Title: %@ \n\n Description: %@", videoTitle, videoDescription];
      [textView setFont:[UIFont boldSystemFontOfSize:30]];
      textView.textColor = [UIColor whiteColor];
      textView.backgroundColor = [UIColor clearColor];
      textView.textAlignment = NSTextAlignmentCenter;
      textView.center = self.videoView.center;

      [mediaImageView addSubview:textView];

      [textView setTranslatesAutoresizingMaskIntoConstraints:NO];

      NSLayoutConstraint *width =[NSLayoutConstraint
                                  constraintWithItem:textView
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:0
                                  toItem:mediaImageView
                                  attribute:NSLayoutAttributeWidth
                                  multiplier:1.0
                                  constant:0];

      NSLayoutConstraint *height =[NSLayoutConstraint
                                   constraintWithItem:textView
                                   attribute:NSLayoutAttributeHeight
                                   relatedBy:0
                                   toItem:mediaImageView
                                   attribute:NSLayoutAttributeHeight
                                   multiplier:1.0
                                   constant:0];
      [mediaImageView addConstraint:width];
      [mediaImageView addConstraint:height];


      [self.castManager setCastModeVideoView:mediaImageView];
    });
  });

}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}


/*
 * Get the Ooyala Player Token to play the embed code.
 * This should contact your servers to generate the OPT server-side.
 * For debugging, you can use Ooyala's EmbeddedSecureURLGenerator to create local embed tokens
 */
- (void)tokenForEmbedCodes:(NSArray *)embedCodes callback:(OOEmbedTokenCallback)callback {
  NSMutableDictionary* params = [NSMutableDictionary dictionary];

  params[@"account_id"] = self.accountId;
  params[@"override_syndication_group"] = @"override_all_synd_groups";
  NSString* uri = [NSString stringWithFormat:@"/sas/embed_token/%@/%@", self.pcode, [embedCodes componentsJoinedByString:@","]];

  OOEmbeddedSecureURLGenerator* urlGen = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey secret:self.secret];
  NSURL* embedTokenUrl = [urlGen secureURL:self.authorizeHost uri:uri params:params];
  callback([embedTokenUrl absoluteString]);
}


@end
