//
//  ChildPlayerViewController.m
//  MultipleLayoutsTVSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "ChildPlayerViewController.h"
#import "PlayerSelectionOption.h"
#import <OoyalaTVSkinSDK/OOOoyalaTVPlayerViewController.h>
#import <OoyalaTVSDK/OOOoyalaPlayer.h>
#import <OoyalaTVSDK/OOPlayerDomain.h>

@interface ChildPlayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *playerView;

@property (nonatomic, strong) NSString *pcode;
@property (nonatomic, strong) NSString *playerDomain;

@end

@implementation ChildPlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.pcode =@"R2d3I6s06RyB712DN0_2GsQS-R-Y";
  self.playerDomain = @"http://www.ooyala.com";
  
  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.ooyalaPlayerViewController = [[OOOoyalaTVPlayerViewController alloc] initWithPlayer:player];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:self.ooyalaPlayerViewController.player];
  
  // Attach it to current view
  [self addChildViewController:self.ooyalaPlayerViewController];
  self.ooyalaPlayerViewController.view.frame = self.playerView.bounds;
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController didMoveToParentViewController:self];
  
  self.ooyalaPlayerViewController.showsPlaybackControls = NO;
  
  // Load the video
  [self.ooyalaPlayerViewController.player setEmbedCode:self.option.embedCode];
  [self.ooyalaPlayerViewController.player play];
}

@end
