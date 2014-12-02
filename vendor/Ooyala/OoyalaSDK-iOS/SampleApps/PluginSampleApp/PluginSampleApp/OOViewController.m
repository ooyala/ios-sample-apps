//
//  OOViewController.m
//  PluginSampleApp
//
//  Created by Zhihui Chen on 8/28/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import "OOViewController.h"
#import "OOOoyalaPlayerViewController.h"
#import "OOPlayerDomain.h"
#import "OOSamplePlugin.h"

@interface OOViewController ()

@end

@implementation OOViewController

NSString * const EMBED_CODE = @"xxbjk1YjpHm4-VkWfWfEKBbyEkh358su";
NSString * const PCODE = @"Z5Mm06XeZlcDlfU_1R9v_L2KwYG6";
NSString * const PLAYERDOMAIN = @"http://www.ooyala.com";


- (void)viewDidLoad
{
  [super viewDidLoad];
  // Create Ooyala ViewController
  OOOoyalaPlayerViewController *_ooyalaPlayerViewController =
    [[OOOoyalaPlayerViewController alloc] initWithPcode:PCODE domain:[[OOPlayerDomain alloc] initWithString:PLAYERDOMAIN]];

  OOSamplePlugin *plugin = [[OOSamplePlugin alloc] initWithPlayer:_ooyalaPlayerViewController.player];
  [_ooyalaPlayerViewController.player registerPlugin:plugin];

  // Attach it to current view
  [self addChildViewController:_ooyalaPlayerViewController];
  [_ooyalaPlayerViewController.view setFrame:_playerView.bounds];
  [self addChildViewController:_ooyalaPlayerViewController];
  [_playerView addSubview:_ooyalaPlayerViewController.view];

  // Load the video
  [_ooyalaPlayerViewController.player setEmbedCode:EMBED_CODE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
