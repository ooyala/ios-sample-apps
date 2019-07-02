//
//  OptionsViewController.m
//  OptionsSampleApp
//
//  Created on 12/18/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

#import "OptionsViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"
#import "PlayerSelectionOption.h"

@interface OptionsViewController () <UITextFieldDelegate>

#pragma mark - Private properties

@property IBOutlet UIButton *button;
@property IBOutlet UIView *playerView;

@property (nonatomic) OOOoyalaPlayerViewController *playerViewController;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;
@property (nonatomic) NSString *embedCode;

@end

@implementation OptionsViewController{
  AppDelegate *appDel;
}

#pragma mark - Synthesize

@dynamic playerView;

#pragma mark - Initialization

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption
                                qaModeEnabled:(BOOL)qaModeEnabled {
  self = [super initWithPlayerSelectionOption:playerSelectionOption qaModeEnabled:qaModeEnabled];
  _nib = playerSelectionOption.nib ?: @"PlayerDoubleSwitch";

  if (self.playerSelectionOption) {
    _embedCode    = self.playerSelectionOption.embedCode;
    _pcode        = self.playerSelectionOption.pcode;
    _playerDomain = self.playerSelectionOption.domain;
    self.title    = self.playerSelectionOption.title;
  } else {
    NSLog(@"There was no PlayerSelectionOption!");
    return nil;
  }
  return self;
}

#pragma mark - Life cycle

- (void)loadView {
  [super loadView];
  [NSBundle.mainBundle loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  appDel = (AppDelegate *)UIApplication.sharedApplication.delegate;
  
  // In QA Mode , making textView visible
  self.textView.hidden = !self.qaModeEnabled;
  
  if (self.switch1) {
    self.switchLabel1.text = @"ShowPromoImage";
    self.switch1.on = NO;
  }
  
  if (self.switch2) {
    self.switchLabel2.text = @"Preload";
    self.switch2.on = YES;
  }
  
  if (self.text1) {
    self.switchLabel1.text = @"n/w timeout";
    self.text1.text = @"60.0";
    self.text1.delegate = self;
  }
  
  if (self.text2) {
    self.switchLabel2.text = @"";
    self.switchLabel2.enabled = NO;
    self.text2.enabled = NO;
  }
  
  [_button setTitle:@"Create" forState:UIControlStateNormal];
  
  self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

#pragma mark - Actions

- (IBAction)onButtonClick:(id)sender {
  OOOptions *options = [OOOptions new];
  
  if (self.switch1) {
    options.showPromoImage = self.switch1.on;
  }
  
  if (self.switch2) {
    options.preloadContent = self.switch2.on;
  }
  
  if (self.text1) {
    NSTimeInterval timeout = self.text1.text.floatValue;
    options.connectionTimeout = timeout;
  }
  
  if (self.playerViewController) {
    [self.playerViewController removeFromParentViewController];
    [self.playerViewController.view removeFromSuperview];
  }
  
  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] options:options];
  _playerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(notificationHandler:)
                                             name:nil
                                           object:self.playerViewController.player];
  
  // Setup video view
  CGRect rect = self.playerView.bounds;
  self.playerViewController.view.frame = rect;
  [self addChildViewController:self.playerViewController];
  [self.playerView addSubview:self.playerViewController.view];
  
  [self.playerViewController.player setEmbedCode:self.embedCode];
  
  if (self.initialTime > 0) {
    [self.playerViewController.player playWithInitialTime:self.initialTime];
  }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

#pragma mark - Private functions

- (void)notificationHandler:(NSNotification *)notification {
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                       notification.name,
                       [OOOoyalaPlayerStateConverter playerStateToString:self.playerViewController.player.state],
                       self.playerViewController.player.playheadTime, appDel.count];
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
