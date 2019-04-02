//
//  ViewController.m
//  AdobePassDemoApp
//
//  Created on 5/15/12.
//  Copyright © 2012 Ooyala Inc. All rights reserved.
//

#import "AdobePassPlayerViewController.h"
#import "AdobePassViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>

@interface AdobePassPlayerViewController () <AdobePassViewControllerDelegate>

@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;

@end

@implementation AdobePassPlayerViewController

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption {
  self = [super initWithPlayerSelectionOption: playerSelectionOption];
  self.nib = @"PlayerDoubleButton";

  if (self.playerSelectionOption) {
    self.embedCode = self.playerSelectionOption.embedCode;
    self.title = self.playerSelectionOption.title;
    self.pcode = self.playerSelectionOption.pcode;
    self.playerDomain = self.playerSelectionOption.domain;
  } else {
    NSLog(@"There was no PlayerSelectionOption!");
    return nil;
  }
  return self;
}

- (void)authChanged:(int)status {
  if (status == PASS_SUCCESS) {
    [self.button1 setTitle:@"Logout" forState:UIControlStateNormal];
    [self.button1 removeTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.button1 addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    self.ooyalaPlayerViewController.view.hidden = NO;
  } else {
    [self.button1 setTitle:@"Login" forState:UIControlStateNormal];
    [self.button1 removeTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.button1 addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    self.ooyalaPlayerViewController.view.hidden = YES;
  }
}

- (void)loadView {
  [super loadView];
  [NSBundle.mainBundle loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.passController = [[AdobePassViewController alloc] initWithRequestor:@"AdobeBEAST"
                                                                  keystore:@"adobepass"
                                                                   keypass:@"adobepass"
                                                                  delegate:self];
  [self addChildViewController:self.passController];

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]
                                             embedTokenGenerator:self.passController];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];

  [NSNotificationCenter.defaultCenter addObserver: self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.ooyalaPlayerViewController.player];

  [self.playerView addSubview:_ooyalaPlayerViewController.view];
  self.ooyalaPlayerViewController.view.frame = self.playerView.bounds;
  [self.button1 removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
  [self addChildViewController:self.ooyalaPlayerViewController];
  self.ooyalaPlayerViewController.view.hidden = YES;

  [self.button2 setTitle:@"SetEmbedCode" forState:UIControlStateNormal];
  
  [self.passController checkAuth];
}

- (void)onRightBtnClick:(id)sender {
  //[ooController.player setEmbedCode:@"5icXRvNDrl9kxzF_58oV79ApUNRffoLR"];
  [self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [self.ooyalaPlayerViewController.player play];
}

- (void)login {
  [self.passController login];
}

- (void)logout {
  [self.passController logout];
}

- (void)notificationHandler:(NSNotification *) notification {
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }

  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayerStateConverter playerStateToString:[self.ooyalaPlayerViewController.player state]],
        [self.ooyalaPlayerViewController.player playheadTime]);
}

@end
