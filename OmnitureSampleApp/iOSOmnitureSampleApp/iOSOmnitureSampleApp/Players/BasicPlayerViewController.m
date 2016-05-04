//
//  BasicPlayerViewController.m
//  iOSOmnitureSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "BasicPlayerViewController.h"
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSDK/OOPlayerDomain.h>

@interface BasicPlayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *playerView;

@property (nonatomic, strong) OOOoyalaPlayerViewController *playerVC;

@property (nonatomic, strong) NSString *pcode;
@property (nonatomic, strong) NSString *playerDomain;
@property (nonatomic, strong) NSString *embedCode;

@end

@implementation BasicPlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.pcode = @"c0cTkxOqALQviQIGAHWY5hP0q9gU";
  self.embedCode = @"JiOTdrdzqAujYa5qvnOxszbrTEuU5HMt";
  self.playerDomain = @"http://www.ooyala.com";
  
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.playerVC = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:self.playerVC.player];
  
  [self addChildViewController:self.playerVC];
  [self.playerView addSubview:self.playerVC.view];
  self.playerVC.view.frame = self.playerView.bounds;
  [self.playerVC didMoveToParentViewController:self];
  
  if ([self.playerVC.player setEmbedCode:self.embedCode]) {
    [self.playerVC.player play];
  }
}

- (void)notificationHandler:(NSNotification *)notification {
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.playerVC.player state]],
        [self.playerVC.player playheadTime]);
}

@end
