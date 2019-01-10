//
//  GeoblockingSkinViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "GeoblockingSkinViewController.h"
#import "GeoblockingPlayerSelectionOptions.h"
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>
#import "AppDelegate.h"


@interface GeoblockingSkinViewController ()

#pragma mark - Private properties

@property (nonatomic, retain) OOSkinViewController *skinController;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;
@property (nonatomic) NSString *apiKey;
@property (nonatomic) NSString *secretKey;
@property (nonatomic) NSString *accountId;


@end


@implementation GeoblockingSkinViewController {
  AppDelegate *appDel;
}
#pragma mark - Initializaiton

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled {
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
  if (self.playerSelectionOption && [self.playerSelectionOption isKindOfClass:[GeoblockingPlayerSelectionOptions class]]) {
    self.nib = self.playerSelectionOption.nib;
    self.embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
    self.playerDomain = self.playerSelectionOption.playerDomain;
    self.pcode = playerSelectionOption.pcode;
    self.apiKey = ((GeoblockingPlayerSelectionOptions *)self.playerSelectionOption).apiKey;
    self.secretKey = ((GeoblockingPlayerSelectionOptions *)self.playerSelectionOption).secretKey;
    self.accountId = ((GeoblockingPlayerSelectionOptions *)self.playerSelectionOption).accountId;
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
  [OOOoyalaPlayer setEnvironment:OOOoyalaPlayerEnvironmentStaging];
  
  appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
  // Create Ooyala ViewController
  OOOptions *options = [OOOptions new];
  // Currently needed for Fairplay
  options.secureURLGenerator = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey secret:self.secretKey];
  OOOoyalaPlayer *ooyalaPlayer = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                                domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] embedTokenGenerator:self
                                                               options:options];
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
  
  // Load the video
  [ooyalaPlayer setEmbedCode:self.embedCode];
}

- (void)viewWillDisappear:(BOOL)animated {
  [OOOoyalaPlayer setEnvironment:OOOoyalaPlayerEnvironmentProduction];
}

#pragma mark - EmbedTokenGenerator protocol

- (void)tokenForEmbedCodes:(NSArray *)embedCodes callback:(OOEmbedTokenCallback)callback {
  NSMutableDictionary* params = [NSMutableDictionary dictionary];
  params[@"account_id"] = self.accountId;  //Only used for concurrent streams
  NSString* uri = [NSString stringWithFormat:@"/sas/embed_token/%@/%@", self.pcode, [embedCodes componentsJoinedByString:@","]];
  OOEmbeddedSecureURLGenerator* urlGen = [[OOEmbeddedSecureURLGenerator alloc] initWithAPIKey:self.apiKey secret:self.secretKey];
  NSURL* embedTokenUrl = [urlGen secureURL:@"http://player.ooyala.com" uri:uri params:params];
  callback([embedTokenUrl absoluteString]);
}

#pragma mark - Private functions

- (void)notificationHandler:(NSNotification*)notification {
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  // Check for FullScreenChanged notification
  if ([notification.name isEqualToString:OOSkinViewControllerFullscreenChangedNotification]) {
    NSString *message = [NSString stringWithFormat:@"Notification Received: %@. isfullscreen: %@. ",
                         notification.name,
                         [notification.userInfo[@"fullscreen"] boolValue] ? @"YES" : @"NO"];
    NSLog(@"%@", message);
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                       [notification name],
                       [OOOoyalaPlayerStateConverter playerStateToString:[self.skinController.player state]],
                       [self.skinController.player playheadTime], appDel.count];
  
  NSLog(@"%@",message);
  
  // In QA Mode , adding notifications to the TextView
  if (self.qaModeEnabled) {
    NSString *string = self.textView.text;
    NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@", string, message];
    dispatch_async(dispatch_get_main_queue(), ^{
      self.textView.text = appendString;
    });
  }
  appDel.count++;
}

@end
