//
//  PlayerViewController.m
//  OoyalaChromecastSampleApp
//
//  Created by Liusha Huang on 9/18/14.
//  Copyright (c) 2014 Liusha Huang. All rights reserved.
//

#import "PlayerViewController.h"
#import <OoyalaCastSDK/OOChromeCastPlugin.h>
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
@property (strong, nonatomic) OOChromecastPlugin *castPlugin;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Fetch castPlugin and castButton
  self.castPlugin = [OOChromecastPlugin getCastPluginWithAppID:@"4172C76F" namespace:@"urn:x-cast:ooyala"];
  self.castPlugin.delegate = self;
  
  UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc] initWithCustomView:[self.castPlugin getCastButton]];
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
                                               name:OOChromecastEnterCastModeNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(onCastModeExit)
                                               name:OOChromecastExitCastModeNotification
                                             object:nil];

  // Init the castPlugin in the ooyalaPlayer
  [self.ooyalaPlayer initCastManager:self.castPlugin];
  [self.ooyalaPlayer setEmbedCode:embedcode];
  [self.ooyalaPlayer play];
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
  [self.castPlugin setCastModeVideoView:videoView];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}
@end
