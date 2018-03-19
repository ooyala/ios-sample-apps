//
//  IMAPlayerViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "IMAPlayerViewController.h"
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>
#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"


@interface IMAPlayerViewController ()

#pragma mark - Private properties

@property (nonatomic, retain) OOIMAManager *adsManager;
@property (nonatomic, retain) OOSkinViewController *skinController;
@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;

@end


@implementation IMAPlayerViewController

AppDelegate *appDel;

#pragma mark - Initialization

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled {
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
  if (self.playerSelectionOption) {
    self.nib = self.playerSelectionOption.nib;
    self.embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
    self.playerDomain = self.playerSelectionOption.playerDomain;
    self.pcode = playerSelectionOption.pcode;
  }
  return self;
}

#pragma mark - Life cycle

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
  // Create Ooyala ViewController
  OOOptions *options = [OOOptions new];
  OOOoyalaPlayer *ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                                domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] options:options];
  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular limit:10 timeout:60];
  NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  //  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
  ooyalaPlayer.actionAtEnd = OOOoyalaPlayerActionAtEndPause; //This is recommended to make sure the endscreen shows up as expected
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions
                                                                jsCodeLocation:jsCodeLocation
                                                                configFileName:@"skin"
                                                               overrideConfigs:nil];
  
  self.skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaPlayer skinOptions:skinOptions parent:_videoView launchOptions:nil];
  [self addChildViewController:_skinController];
  [_skinController.view setFrame:self.videoView.bounds];
  [ooyalaPlayer setEmbedCode:self.embedCode];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:ooyalaPlayer];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:self.skinController];
  // In QA Mode , making textView visible
  self.textView.hidden = !self.qaModeEnabled;

  self.adsManager = [[OOIMAManager alloc] initWithOoyalaPlayer:ooyalaPlayer];
  self.adsManager.imaAdsManagerDelegate = self;
  
  // Load the video
  [ooyalaPlayer setEmbedCode:self.embedCode];
}

#pragma mark - Private functions

- (void)notificationHandler:(NSNotification*)notification {
  
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                       [notification name],
                       [OOOoyalaPlayer playerStateToString:[self.skinController.player state]],
                       [self.skinController.player playheadTime], appDel.count];
  NSLog(@"%@",message);
  
  // In QA Mode , adding notifications to the TextView
  if (self.qaModeEnabled == YES) {
    NSString *string = self.textView.text;
    NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@", string, message];
    [self.textView setText:appendString];
  }
  
  appDel.count++;
}

#pragma mark - OOIMAAdsManagerDelegate

- (void)adsManager:(IMAAdsManager *)adsManager didReceiveAdEvent:(IMAAdEvent *)event {
  NSLog(@"IMA Ad Manager: event %@.",  [self IMAAdEventTypeName:event.type]);
}

- (void)adsManagerDidRequestContentResume:(IMAAdsManager *)adsManager {
  NSLog(@"IMA Ad Manager: Content Resume.");
}

- (void)adsManagerDidRequestContentPause:(IMAAdsManager *)adsManager {
  NSLog(@"IMA Ad Manager: Content Pause.");
}

- (void)adsLoader:(IMAAdsLoader *)loader adsLoadedWithData:(IMAAdsLoadedData *)adsLoadedData {
  NSLog(@"IMA Ads Loaded With Data.");
}

- (void)displayContainerUpdated:(IMAAdDisplayContainer *)adDisplayContainer {
  NSLog(@"IMA Display Container Updated");
}

- (NSString *)IMAAdEventTypeName:(IMAAdEventType)type{
  switch (type) {
    case kIMAAdEvent_AD_BREAK_READY:
      return @"AdBreakReady";
    case kIMAAdEvent_ALL_ADS_COMPLETED:
      return @"AllAdsCompleted";
    case kIMAAdEvent_CLICKED:
      return @"Clicked";
    case kIMAAdEvent_COMPLETE:
      return @"Complete";
    case kIMAAdEvent_FIRST_QUARTILE:
      return @"FirstQuartile";
    case kIMAAdEvent_LOADED:
      return @"Loaded";
    case kIMAAdEvent_MIDPOINT:
      return @"MidPoint";
    case kIMAAdEvent_PAUSE:
      return @"Pause";
    case kIMAAdEvent_RESUME:
      return @"Resume";
    case kIMAAdEvent_SKIPPED:
      return @"Skipped";
    case kIMAAdEvent_STARTED:
      return @"Started";
    case kIMAAdEvent_TAPPED:
      return @"Tapped";
    case kIMAAdEvent_THIRD_QUARTILE:
      return @"ThirdQuartile";
    default:
      return [NSString stringWithFormat:@"Unknown type %ld", (long)type];
  }
}


@end
