//
//  PlayerViewController.m
//  DownloadToOwnSampleApp
//
//  Created on 8/30/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "PlayerViewController.h"
#import "PlayerSelectionOption.h"

#import <OoyalaSDK/OoyalaSDK.h>

@interface PlayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.option.pcode
                                                          domain:[OOPlayerDomain domainWithString:self.option.domain]];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  [self.ooyalaPlayerViewController willMoveToParentViewController:self];
  [self addChildViewController:self.ooyalaPlayerViewController];
  [self.playerView addSubview:self.ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];
  [self.ooyalaPlayerViewController didMoveToParentViewController:self];
  
  NSURL *location = [[NSUserDefaults standardUserDefaults] URLForKey:self.option.embedCode];
  if (location) {
    // offline mode
    NSLog(@"Playing an offline video");
    OOOfflineVideo *video = [[OOOfflineVideo alloc] initWithFileLocation:location];
    [self.ooyalaPlayerViewController.player setUnbundledVideo:video];
  } else {
    // online mode
    NSLog(@"Playing an online video");
    [self.ooyalaPlayerViewController.player setEmbedCode:self.option.embedCode];
  }
}

@end
