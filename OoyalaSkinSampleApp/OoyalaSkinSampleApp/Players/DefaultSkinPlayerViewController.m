//
//  MasterViewController.m
//  OoyalaSkin
//
//  Created by Zhihui Chen on 6/3/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "DefaultSkinPlayerViewController.h"
#import <OoyalaSkinSDK/OOSkinViewController.h>
#import <OoyalaSkinSDK/OOSkinOptions.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaSkinSDK/OOFacebookSharePlugin.h>
#import <OoyalaSkinSDK/OOTwitterSharePlugin.h>
#import <OoyalaSDK/OOPlayerDomain.h>
#import <OoyalaSDK/OOOptions.h>
#import <OoyalaSDK/OODiscoveryOptions.h>

@interface DefaultSkinPlayerViewController ()

@property (nonatomic, retain) OOSkinViewController *skinController;

@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@end

@implementation DefaultSkinPlayerViewController

NSMutableArray *_sharePlugins;

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];

  _sharePlugins = [[NSMutableArray alloc] init];
  [_sharePlugins addObject: [[OOFacebookSharePlugin alloc] init]];
  [_sharePlugins addObject: [[OOTwitterSharePlugin alloc] init]];

  if (self.playerSelectionOption) {
    self.nib = self.playerSelectionOption.nib;
    self.embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
    self.playerDomain = playerSelectionOption.playerDomain;
    self.pcode = playerSelectionOption.pcode;
  }
  return self;
}

- (void) loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  OOOptions *options = [OOOptions new];
  OOOoyalaPlayer *ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] options:options];
  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular limit:10 timeout:60];
  NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
//  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle"];
  NSDictionary *overrideConfigs = @{@"upNextScreen": @{@"timeToShow": @"8"}};

  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions jsCodeLocation:jsCodeLocation configFileName:@"skin" overrideConfigs:overrideConfigs];
  self.skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaPlayer skinOptions:skinOptions parent:_videoView launchOptions:nil];
  [self addChildViewController:_skinController];
  [_skinController.view setFrame:self.videoView.bounds];
  [ooyalaPlayer setEmbedCode:self.embedCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
