//
//  MasterViewController.m
//  OoyalaSkin
//
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "DefaultSkinPlayerViewController.h"
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>
#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"

@interface DefaultSkinPlayerViewController ()

#pragma mark - Private properties

@property (nonatomic, retain) OOSkinViewController *skinController;
@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@property (nonatomic) UIImageView *screenshotView;

@end


@implementation DefaultSkinPlayerViewController {
  AppDelegate *appDel;
  NSMutableArray *_sharePlugins;
}

#pragma mark - Initialization

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption
                                qaModeEnabled:(BOOL)qaModeEnabled {
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
  _sharePlugins = [NSMutableArray array];
  if (self.playerSelectionOption) {
    _nib          = self.playerSelectionOption.nib;
    _embedCode    = self.playerSelectionOption.embedCode;
    _playerDomain = self.playerSelectionOption.playerDomain;
    _pcode        = playerSelectionOption.pcode;
    self.title    = self.playerSelectionOption.title;

    NSLog(@"%@s", self.playerDomain);
  }
  return self;
}

#pragma mark - Life cycle

- (void) loadView {
  [super loadView];
  [NSBundle.mainBundle loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  appDel = (AppDelegate *)UIApplication.sharedApplication.delegate;
  OOOptions *options = [OOOptions new];
  OOOoyalaPlayer *ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                                domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]
                                                               options:options];
  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular
                                                                            limit:10
                                                                          timeout:60];
  NSURL *jsCodeLocation = [NSBundle.mainBundle URLForResource:@"main" withExtension:@"jsbundle"];
//  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
  NSDictionary *overrideConfigs = @{@"upNextScreen": @{@"timeToShow": @"8"}};

  ooyalaPlayer.actionAtEnd = OOOoyalaPlayerActionAtEndPause;  //This is recommended to make sure the endscreen shows up as expected
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions
                                                                jsCodeLocation:jsCodeLocation
                                                                configFileName:@"skin"
                                                               overrideConfigs:overrideConfigs];
  
  _skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaPlayer
                                                     skinOptions:skinOptions
                                                          parent:_videoView
                                                   launchOptions:nil];
  [self addChildViewController:_skinController];
  _skinController.view.frame = self.videoView.bounds;

  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.skinController];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:ooyalaPlayer];
  
  // In QA Mode , making textView visible
  self.textView.hidden = !self.qaModeEnabled;

  [ooyalaPlayer setEmbedCode:self.embedCode];
  
  [self configureScreenshot];
}

#pragma mark - Screenshot

- (void)configureScreenshot {
  self.screenshotView = [[UIImageView alloc] initWithFrame:self.videoView.frame];
  self.screenshotView.contentMode = UIViewContentModeScaleAspectFit;
  self.screenshotView.hidden = YES;
  self.screenshotView.layer.borderColor = UIColor.whiteColor.CGColor;
  self.screenshotView.layer.borderWidth = 2.0;
  
  [self.videoView addSubview:self.screenshotView];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Screenshot"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(showScreenshot)];
}

- (void)showScreenshot {
  self.screenshotView.image = self.skinController.player.screenshot;
  self.screenshotView.hidden = NO;
  self.screenshotView.alpha = 1.0f;
  [UIView animateWithDuration:0.5 delay:2.0 options:0 animations:^{
    self.screenshotView.alpha = 0.0f;
  } completion:^(BOOL finished) {
    self.screenshotView.hidden = YES;
  }];
}

#pragma mark - Private functions

- (void)notificationHandler:(NSNotification*)notification {
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                       notification.name,
                       [OOOoyalaPlayerStateConverter playerStateToString:self.skinController.player.state],
                       self.skinController.player.playheadTime,
                       appDel.count];
  NSLog(@"%@",message);
  
  // In QA Mode , adding notifications to the TextView
  if (self.qaModeEnabled) {
    NSString *string = self.textView.text;
    NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@",string,message];
    dispatch_async(dispatch_get_main_queue(), ^{
      self.textView.text = appendString;
    });
  }
  appDel.count++;
}

@end
