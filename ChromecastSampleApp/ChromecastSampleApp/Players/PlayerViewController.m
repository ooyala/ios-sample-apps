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
#import <OoyalaSDK/OOPlayerDomain.h>
#import "Utils.h"


@interface PlayerViewController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) IBOutlet UIView *mediaDetailView;
@property (strong, nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (strong, nonatomic) OOOoyalaPlayer *ooyalaPlayer;
@property (strong, nonatomic) OOCastManager *castManager;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Fetch castManager and castButton
  self.castManager = [OOCastManager getCastManagerWithAppID:@"4172C76F" namespace:@"urn:x-cast:ooyala"];
  self.castManager.delegate = self;
  
  UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc] initWithCustomView:[self.castManager getCastButton]];
  self.navigationBar.rightBarButtonItem = leftbutton;

  // Fetch content info and load ooyalaPlayerViewController and ooyalaPlayer
  NSString *pcode = [self.mediaInfo valueForKey:@"pcode"];
  NSString *domain = [self.mediaInfo valueForKey:@"domain"];
  NSString *embedcode = [self.mediaInfo valueForKey:@"embedcode"];


  self.ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:pcode domain:[[OOPlayerDomain alloc] initWithString:domain]];
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
  [self.ooyalaPlayer setEmbedCode:embedcode];
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

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  UIView *videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.videoView.frame.size.width, self.videoView.frame.size.height)];
  videoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
  videoView.backgroundColor = [UIColor redColor];
  UITextView *textView = [[UITextView alloc] initWithFrame:videoView.frame];
  textView.userInteractionEnabled = NO;
  textView.backgroundColor = [UIColor clearColor];
  textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  NSString *videoTitle = [self.mediaInfo objectForKey:@"title"];
  NSString *videoDescription = [self.mediaInfo objectForKey:@"description"];
  textView.text = [NSString stringWithFormat:@"\n\n Title: %@ \n\n Description: %@", videoTitle, videoDescription];
  [textView setFont:[UIFont boldSystemFontOfSize:30]];
  textView.textColor = [UIColor whiteColor];
  textView.textAlignment = NSTextAlignmentCenter;
  [videoView addSubview:textView];
  textView.center = self.videoView.center;
  [self.castManager setCastModeVideoView:videoView];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}
@end
