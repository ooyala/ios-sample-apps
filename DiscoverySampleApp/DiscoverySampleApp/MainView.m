//
//  MainView.m
//  OoyalaSkinSampleApp
//
//  Created on 4/13/17.
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import "MainView.h"
#import <OoyalaSDK/OoyalaSDK.h>

#import "PlayerSelectionOption.h"
#import "PlayerViewController.h"
#import "DemoSettings.h"

@interface MainView ()

@property (nonatomic) IBOutlet UILabel *videoTitle;
@property (nonatomic) IBOutlet UILabel *descriptionLabel;

@property (nonatomic) IBOutlet UIView *playerview;
@property (nonatomic) IBOutlet NSLayoutConstraint *playerViewHeight;
@property (nonatomic) IBOutlet NSLayoutConstraint *playerViewFullHeight;
@property (nonatomic) IBOutlet NSLayoutConstraint *playerViewTop;

@property (nonatomic) DemoSettings *configuration; //read config.json
@property (nonatomic) NSString *actualembed; //embed
@property (nonatomic) NSString *actualVideoTitle;
@property (nonatomic) PlayerViewController *playerViewController;

@end

@implementation MainView

//layout init configuration
static float const landscapePercentage = .5f;//% cover player
static float const portscapePercentage = .4f;
static float const leftPadding         = 10;

#pragma mark - Init

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(updatetitleDiscovery:)
                                             name:@"NotificationMessageEvent"
                                           object:self.videoTitle];
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(updatetitleDiscovery:)
                                             name:OOOoyalaPlayerPlayStartedNotification
                                           object:self.playerViewController.ooyalaPlayer];

  // Init custom class
  self.configuration = [DemoSettings new]; //config object (config.json)

  self.playerViewController = [PlayerViewController alloc];
  [self renderPortrait];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
     UIInterfaceOrientation orientation = UIApplication.sharedApplication.statusBarOrientation;
    switch (orientation) {
      case UIDeviceOrientationPortrait:
      case UIDeviceOrientationPortraitUpsideDown:
        [self renderPortrait];
        break;

      default:
        [self renderLandscape];
        break;
    }
   } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {

   }];


  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)renderPortrait {
  NSLog(@"User render orientation: portrait");

  [self.navigationController setNavigationBarHidden:NO animated:YES]; //Show navigation controller / logo /
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarima"]
                                                forBarMetrics:UIBarMetricsDefault];
  UIImage *img = [UIImage imageNamed:@"logoheader"];
  UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
  imgView.image = img;
  imgView.contentMode = UIViewContentModeScaleAspectFit;
  self.navigationItem.titleView = imgView;

  // Title label
  self.actualVideoTitle = self.configuration.initasset[@"title"];
  self.videoTitle.text= [@"Article 123: " stringByAppendingString:self.actualVideoTitle];
  self.videoTitle.font= [UIFont fontWithName:@"Roboto-Bold" size:22.0];
  self.videoTitle.numberOfLines = 2;
  self.videoTitle.lineBreakMode = NSLineBreakByWordWrapping;
  self.videoTitle.textColor = [UIColor colorWithRed:0.29 green:0.31 blue:0.33 alpha:1.0];
  [self.view addSubview:self.videoTitle];

  self.videoTitle.hidden = NO;

  float playerTop = 150;
  int playerViewHeightCalculated = self.view.frame.size.height * portscapePercentage; //assignt to a variable to know where the player ends
  self.playerview.frame = CGRectMake(leftPadding, playerTop,
                                     self.view.frame.size.width * 0.95, playerViewHeightCalculated);

  self.descriptionLabel.font= [UIFont fontWithName:@"Roboto-Regular" size:20.0];
  //self.descriptionLabel.numberOfLines = 2;
  self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
  [self.view addSubview:self.descriptionLabel];
  self.descriptionLabel.hidden = NO;

  self.playerViewTop.constant = 80.0;
  self.playerViewHeight.active = YES;
  self.playerViewFullHeight.active = NO;
}

- (void)renderLandscape {
  NSLog(@"User render orientation: landscape");

  [self.navigationController setNavigationBarHidden:YES animated:YES]; //Hide navigationbar
  self.videoTitle.hidden = YES;   //remove title uilabel
  self.descriptionLabel.hidden = YES; //remove description label

  int playerViewHeightCalculated = self.view.frame.size.height * landscapePercentage; //assignt to a variable to know where the player ends
  self.playerview.frame = CGRectMake(1, 1 , self.view.frame.size.width, playerViewHeightCalculated);

  self.playerViewTop.constant = 0.0;
  self.playerViewHeight.active = NO;
  self.playerViewFullHeight.active = YES;
}

- (void)updatetitleDiscovery:(NSNotification *)notification {
  NSDictionary *dict = notification.userInfo;
  NSLog(@":::%@", dict[@"title"]);
  if (dict[@"title"]) {
    // do stuff here with your message data
    self.actualVideoTitle = dict[@"title"];
    self.videoTitle.text = dict[@"title"];
  }
  if (self.playerViewController.ooyalaPlayer.currentItem.title) {
    NSString *title = self.playerViewController.ooyalaPlayer.currentItem.title;
    self.videoTitle.text = title;
    self.actualVideoTitle = title;
  }
}


@end
