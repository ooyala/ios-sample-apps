//
//  ViewController.m
//  VRSampleApp
//
//  Created by Ivan Sakharovskii on 8/29/17.
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import <OoyalaSDK/OoyalaSDK.h>
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>
#import "ViewController.h"


@interface ViewController ()

@property(weak, nonatomic) IBOutlet UIView *skinContainerView;
@property(nonatomic, retain) OOSkinViewController *skinController;

@end


@implementation ViewController

#pragma mark - Constants

NSString *embedCode = @"cyY2E1YzE69lqpla_GFSgBXDOzrgJ9GG";
NSString *pcode = @"N3OGsyOvOM7AJke1SYl9_aSJzdp5";
NSString *playerDomain = @"http://www.ooyala.com";

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskAll;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];

  //  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
  NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  NSDictionary *overrideConfigs = @{@"upNextScreen": @{@"timeToShow": @"8"}};

  OOOptions *options = [OOOptions new];

  OOOoyalaPlayer *ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:pcode
                                                                domain:[[OOPlayerDomain alloc] initWithString:playerDomain]
                                                               options:options];

  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular
                                                                            limit:10
                                                                          timeout:60];

  ooyalaPlayer.actionAtEnd = OOOoyalaPlayerActionAtEndStop; // This is reccomended to make sure the endscreen shows up as expected

  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions
                                                                jsCodeLocation:jsCodeLocation
                                                                configFileName:@"skin"
                                                               overrideConfigs:overrideConfigs];

  _skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaPlayer
                                                     skinOptions:skinOptions
                                                          parent:_skinContainerView
                                                   launchOptions:nil];
    [self addChildViewController:_skinController];

  [ooyalaPlayer setEmbedCode:embedCode];
}

#pragma mark - Override

@end
