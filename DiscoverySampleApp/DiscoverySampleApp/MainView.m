//
//  MainView.m
//  OoyalaSkinSampleApp
//
//  Created on 4/13/17.
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import "MainView.h"

#import "PlayerSelectionOption.h"
#import "PlayerViewController.h"
#import "DemoSettings.h"

@interface MainView () <PlayerViewControllerDelegate>

@property (nonatomic) IBOutlet UILabel *videoTitle;
@property (nonatomic) IBOutlet UILabel *descriptionLabel;

@property (nonatomic) IBOutlet UIView *playerview;
@property (nonatomic) IBOutlet NSLayoutConstraint *playerViewHeight;
@property (nonatomic) IBOutlet NSLayoutConstraint *playerViewFullHeight;
@property (nonatomic) IBOutlet NSLayoutConstraint *playerViewTop;

@property (nonatomic) DemoSettings *configuration; //read config.json
@property (nonatomic) PlayerViewController *playerViewController;

@end

@implementation MainView

//layout init configuration
static float const landscapePercentage = .5f;//% cover player
static float const portscapePercentage = .4f;
static float const leftPadding         = 10;
static float const playerTop           = 150;

#pragma mark - Init

- (void)viewDidLoad {
  [super viewDidLoad];

  self.configuration = [DemoSettings new]; //config object (config.json)
  [self setupUI];
}

- (void)setupUI {
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarima"]
                                                forBarMetrics:UIBarMetricsDefault];
  UIImage *img = [UIImage imageNamed:@"logoheader"];
  UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
  imgView.image = img;
  imgView.contentMode = UIViewContentModeScaleAspectFit;
  self.navigationItem.titleView = imgView;

  // Title label
  self.videoTitle.text      = self.configuration.initasset[@"title"];
  self.videoTitle.textColor = [UIColor colorWithRed:0.29 green:0.31 blue:0.33 alpha:1.0];
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
  self.videoTitle.hidden = NO;
  self.descriptionLabel.hidden = NO;

  int playerViewHeightCalculated = self.view.frame.size.height * portscapePercentage; //assignt to a variable to know where the player ends
  self.playerview.frame = CGRectMake(leftPadding, playerTop,
                                     self.view.frame.size.width * 0.95, playerViewHeightCalculated);
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
  self.playerview.frame = CGRectMake(1, 1,
                                     self.view.frame.size.width, playerViewHeightCalculated);
  self.playerViewTop.constant = 0.0;
  self.playerViewHeight.active = NO;
  self.playerViewFullHeight.active = YES;
}

#pragma mark - PlayerViewControllerDelegate

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"embed"]) {
    self.playerViewController = segue.destinationViewController;
    self.playerViewController.delegate = self;
  }
}

- (void)didUpdateAssetTitle:(NSString *)title {
  dispatch_async(dispatch_get_main_queue(), ^{
    self.videoTitle.text = title;
  });
}

- (void)didStartPlaying {}

@end
