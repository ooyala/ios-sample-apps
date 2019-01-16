//
//  DefaultVideoPlayerViewController.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "DefaultVideoPlayerViewController.h"


@interface DefaultVideoPlayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *skinContainerView;
@property (weak, nonatomic) IBOutlet UITextView *qaInfoTextView;

@end


@implementation DefaultVideoPlayerViewController

#pragma mark - Init/deinit

- (void)dealloc {
  [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self configureObjects];
  [self configureUI];
}

#pragma mark - Private functions

- (void)configureObjects {
  
  // App delegate
  
  self.appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
  
  // VR player
  
  NSURL *jsCodeLocation = [NSBundle.mainBundle URLForResource:@"main" withExtension:@"jsbundle"];
  NSDictionary *overrideConfigs = @{@"upNextScreen" : @{@"timeToShow" : @"8"}};
  OOOptions *options = [OOOptions new];
  
  options.showPromoImage = YES;
  options.bypassPCodeMatching = NO;
  
  OOPlayerDomain *domain = [OOPlayerDomain domainWithString:self.viewModel.domain];
  OOOoyalaVRPlayer *ooyalaVRPlayer = [[OOOoyalaVRPlayer alloc] initWithPcode:self.viewModel.pcode domain:domain options:options];
  
  // SKin
  
  OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular
                                                                            limit:10
                                                                          timeout:60];
  
  OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:discoveryOptions
                                                                jsCodeLocation:jsCodeLocation
                                                                configFileName:@"skin"
                                                               overrideConfigs:overrideConfigs];
  
  self.skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaVRPlayer
                                                     skinOptions:skinOptions
                                                          parent:_skinContainerView
                                                   launchOptions:nil];
  
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
  
  // Set video embed code
  
  [ooyalaVRPlayer setEmbedCode:self.viewModel.videoItem.embedCode];
}

- (void)configureUI {
  
  // Title
  
  self.navigationItem.title = self.viewModel.videoItem.title;
  
  // Add skin controlle what childer view controller

  [self addChildViewController:self.skinController];
  
  // Update container view Y position
  if (!self.viewModel.QAModeEnabled) {
    self.skinContainerView.frame = CGRectMake(self.skinContainerView.frame.origin.x,
                                              self.view.bounds.size.height / 2 - self.skinContainerView.bounds.size.height / 2,
                                              self.skinContainerView.bounds.size.width,
                                              self.skinContainerView.bounds.size.height);
  }
  
  // Set hidden text view with QA mode enabled
  
  [self.qaInfoTextView setHidden:!self.viewModel.QAModeEnabled];
}

- (void)printLogInTextView:(NSString *)logMessage {
  dispatch_async(dispatch_get_main_queue(), ^ {
    NSString *string = _qaInfoTextView.text;
    NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@", string, logMessage];
    [_qaInfoTextView setText:appendString];
  });
}

#pragma mark - Actions

- (void)notificationHandler:(NSNotification*)notification {
  
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %ld",
                       [notification name],
                       [OOOoyalaPlayerStateConverter playerStateToString:[_skinController.player state]],
                       [_skinController.player playheadTime], (long)_appDelegate.count];
  
  if ([notification.name isEqualToString:OOOoyalaPlayerVideoHasVRContent]) {
    NSDictionary *vrContentUserInfo = notification.userInfo;
    BOOL isVrContent = [[vrContentUserInfo objectForKey:@"vrContent"] boolValue];
    
    message = [message stringByAppendingString:[NSString stringWithFormat:@" vrContentEvent: %@", isVrContent ? @"true" : @"false"]];
  }
  
  NSLog(@"%@",message);
  
  // In QA Mode , adding notifications to the TextView and file
  
  if (self.viewModel.QAModeEnabled) {
    [self printLogInTextView:message];
    [self.viewModel debugPrint:message];
  }
  
  _appDelegate.count++;
}

- (void)switchFullScreenNotificationHandler:(NSNotification*)notification {
  Float64 playhead = [_skinController.player playheadTime];
  long notificationsCount = (long)_appDelegate.count;
  
  NSString *message = [NSString stringWithFormat: @"Notification Received: %@. playhead: %f count: %ld",
                       @"vrModeChanged",
                       playhead,
                       notificationsCount];
  
  NSLog(@"%@", message);
  
  // In QA Mode , adding notifications to the TextView and file
  
  if (self.viewModel.QAModeEnabled) {
    [self printLogInTextView:message];
    [self.viewModel debugPrint:message];
  }

  _appDelegate.count++;
}

- (void)touchesNotificationHandler:(NSNotification*)notification {
  NSDictionary *notificationObject = notification.object;
  Float64 playhead = [_skinController.player playheadTime];
  long notificationsCount = (long)_appDelegate.count;
  
  NSString *message = [NSString stringWithFormat: @"Notification Received: %@. touchesEventName: %@. playhead: %f count: %ld",
                       @"gvrViewRotated",
                       notificationObject[@"eventName"],
                       playhead,
                       notificationsCount];
  
  NSLog(@"%@", message);
  
  // In QA Mode , adding notifications to the TextView and file
  
  if (self.viewModel.QAModeEnabled) {
    [self printLogInTextView:message];
    [self.viewModel debugPrint:message];
  }

  _appDelegate.count++;
}


@end
