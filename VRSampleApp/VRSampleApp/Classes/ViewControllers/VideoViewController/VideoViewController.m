//
//  ViewController.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "VideoViewController.h"
#import <OoyalaVRSDK/OoyalaVRSDK.h>
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>
#import "AppDelegate.h"


@interface VideoViewController ()

@property (weak, nonatomic) IBOutlet UIView *skinContainerView;
@property (weak, nonatomic) IBOutlet UITextView *qaInfoTextView;
@property (nonatomic) AppDelegate *appDelegate;
@property (nonatomic) OOSkinViewController *skinController;
@property (nonatomic) PlayerSelectionOption *playerSelectionOption;
@property (nonatomic) BOOL qaModeEnabled;

@end


@implementation VideoViewController

#pragma mark - Initialization

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public functions

- (void)configureWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled {
  _playerSelectionOption = playerSelectionOption;
  _qaModeEnabled = qaModeEnabled;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Title
  self.title = _playerSelectionOption.title;

  //  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
  NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  NSDictionary *overrideConfigs = @{@"upNextScreen": @{@"timeToShow": @"8"}};
  
  OOOptions *options = [OOOptions new];
  
  options.showPromoImage = YES;
  options.bypassPCodeMatching = NO;

  OOOoyalaVRPlayer *ooyalaVRPlayer = [[OOOoyalaVRPlayer alloc] initWithPcode:_playerSelectionOption.pcode
                                                                domain:[[OOPlayerDomain alloc] initWithString:_playerSelectionOption.domain]
                                                               options:options];
                  
  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular
                                                                            limit:10
                                                                          timeout:60];

  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions
                                                                jsCodeLocation:jsCodeLocation
                                                                configFileName:@"skin"
                                                               overrideConfigs:overrideConfigs];

  _skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaVRPlayer
                                                     skinOptions:skinOptions
                                                          parent:_skinContainerView
                                                   launchOptions:nil];
  [self addChildViewController:_skinController];

  // Load video
  [ooyalaVRPlayer setEmbedCode:_playerSelectionOption.embedCode];
  
  // Configure objects
  [self configureObjects];
}

#pragma mark - Private functions

- (void)configureObjects {
  
  // App delegate
  _appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
  
  // Update container view Y position
  if (!_qaModeEnabled) {
    CGPoint p = CGPointMake(_skinContainerView.center.x,
                            self.view.bounds.size.height / 2 - _skinContainerView.bounds.size.height / 2);
    
    NSLog(@" %f", p.x);
    NSLog(@" %f", p.y);
    
    _skinContainerView.frame = CGRectMake(_skinContainerView.frame.origin.x,
                                          self.view.bounds.size.height / 2 - _skinContainerView.bounds.size.height / 2, _skinContainerView.bounds.size.width, _skinContainerView.bounds.size.height);
  }

  // Set hidden text view with QA mode enabled
  [_qaInfoTextView setHidden:!_qaModeEnabled];
  
  // Subscribe for notifications with QA mode enabled
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:_skinController.player];
  
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(switchFullScreenNotificationHandler:)
                                               name:OOOoyalaPlayerSwitchSceneNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(touchesNotificationHandler:)
                                               name:OOOoyalaPlayerHandleTouchNotification
                                             object:nil];
  
}

- (void)printLogInTextViewIfNeeded:(NSString *)logMessage {
  // In QA Mode , adding notifications to the TextView
  if (_qaModeEnabled) {
    NSString *string = _qaInfoTextView.text;
    NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@", string, logMessage];
    [_qaInfoTextView setText:appendString];
  }
}

#pragma mark - Actions

- (void)notificationHandler:(NSNotification*)notification {
  
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %ld",
                       [notification name],
                       [OOOoyalaPlayer playerStateToString:[_skinController.player state]],
                       [_skinController.player playheadTime], (long)_appDelegate.count];
  
  if ([notification.name isEqualToString:OOOoyalaPlayerVideoHasVRContent]) {
    NSDictionary *vrContentUserInfo = notification.userInfo;
    BOOL isVrContent = [[vrContentUserInfo objectForKey:@"vrContent"] boolValue];
    
    message = [message stringByAppendingString:[NSString stringWithFormat:@" vrContentEvent: %@", isVrContent ? @"true" : @"false"]];
  }
  
  NSLog(@"%@",message);
  
  [self printLogInTextViewIfNeeded:message];
  
  _appDelegate.count++;
}

- (void)switchFullScreenNotificationHandler:(NSNotification*)notification {
  NSString *message = [NSString stringWithFormat:@"Notification Received: vrModeChanged."];
  
  NSLog(@"%@",message);
  
  [self printLogInTextViewIfNeeded:message];
}

- (void)touchesNotificationHandler:(NSNotification*)notification {
  NSDictionary *notificationObject = notification.object;
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. touchesEventName: %@.",
                       @"gvrViewRotated",
                       notificationObject[@"eventName"]];
  
  NSLog(@"%@",message);
  
  [self printLogInTextViewIfNeeded:message];
}

@end
