//
//  ChildPlayerViewController.m
//  TVOSSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "ChildPlayerViewController.h"
#import "PlayerSelectionOption.h"
#import <OoyalaTVSkinSDK/OOOoyalaTVPlayerViewController.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>

@interface ChildPlayerViewController ()

@property (nonatomic, weak) IBOutlet UIView *playerView;

@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;

@end

@implementation ChildPlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.pcode = self.option.pcode;
  self.playerDomain = self.option.domain;
  
  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.ooyalaPlayerViewController = [[OOOoyalaTVPlayerViewController alloc] initWithPlayer:player];
  self.ooyalaPlayerViewController.playbackControlsEnabled = NO;
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.ooyalaPlayerViewController.player];
  
  // Attach it to current view
  [self addChildViewController:self.ooyalaPlayerViewController];
  self.ooyalaPlayerViewController.view.frame = self.playerView.bounds;
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController didMoveToParentViewController:self];
  
  // Load the video
  [self.ooyalaPlayerViewController.player setEmbedCode:self.option.embedCode];
  [self.ooyalaPlayerViewController.player play];
}

@end
