/**
 * @class      ChannelContentTreeDetailViewController ChannelContentTreeDetailViewController.m "ChannelContentTreeDetailViewController.m"
 * @brief      A view that plays video after selecting from the channel list
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "ChannelContentTreeDetailViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"


@interface ChannelContentTreeDetailViewController () {
  
#pragma mark - Private properties
  
  NSString *embedCode;
  NSString *nib;
  NSString *pcode;
  NSString *playerDomain;
  OOOoyalaPlayerViewController *ooyalaPlayerViewController;
}

@end


@implementation ChannelContentTreeDetailViewController{
    AppDelegate *appDel;
}

#pragma mark - Initialization

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled  {
  self.qaModeEnabled = qaModeEnabled;
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
  
  NSLog(@"value of qa mode  %@", self.qaModeEnabled ? @"YES" : @"NO");
  
  if (self = [super initWithPlayerSelectionOption:playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled]) {
    nib = @"PlayerSimple";
  
    if (self.playerSelectionOption) {
      embedCode = self.playerSelectionOption.embedCode;
      self.title = self.playerSelectionOption.title;
      pcode = self.playerSelectionOption.pcode;
      playerDomain = self.playerSelectionOption.domain;
    } else {
      NSLog(@"There was no PlayerSelectionOption!");
      return nil;
    }
  }
  return self;
}

#pragma mark - Life cycle

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:playerDomain]];
  ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:ooyalaPlayerViewController.player];
  
  // Configure QA text view for different targets
  [self configureQATextView];

  // Attach it to current view
  [self addPlayerViewController:ooyalaPlayerViewController onView:self.playerView];
  
  // Load the video
  [ooyalaPlayerViewController.player setEmbedCode:embedCode];
  [ooyalaPlayerViewController.player play];
}

#pragma mark - Private functions

- (void)configureQATextView {
  // In QA Mode , making textView visible
  if (self.qaModeEnabled == YES) {
    self.textView.hidden = NO;
    self.textViewHeightConstraint.constant = 200;
  } else {
    self.textView.hidden = YES;
    self.textViewHeightConstraint.constant = 0.0;
  }
   
  // Configure text view constraints for iOS 11+ targets
  
  if (@available(iOS 11.0, *)) {
    self.textViewLeadingConstraint.active = NO;
    self.textViewTrailingConstraint.active = NO;
    
    self.textViewLeadingConstraint = [self.textView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor];
    self.textViewTrailingConstraint = [self.textView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor];
    
    [NSLayoutConstraint activateConstraints:@[self.textViewLeadingConstraint, self.textViewTrailingConstraint]];
  }
}

- (void)addPlayerViewController:(UIViewController *)playerViewController onView:(UIView *)view {
  [self addChildViewController:playerViewController];
  [view addSubview:playerViewController.view];
  
  // Add constraints
  
  playerViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
  
  if (@available(iOS 11.0, *)) {
    [NSLayoutConstraint activateConstraints:@[
                                              [playerViewController.view.topAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.topAnchor],
                                              [playerViewController.view.trailingAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.trailingAnchor],
                                              [playerViewController.view.bottomAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.bottomAnchor],
                                              [playerViewController.view.leadingAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.leadingAnchor]
                                              ]];
  } else {
    [NSLayoutConstraint activateConstraints:@[
                                              [playerViewController.view.topAnchor constraintEqualToAnchor:view.topAnchor],
                                              [playerViewController.view.trailingAnchor constraintEqualToAnchor:view.trailingAnchor],
                                              [playerViewController.view.bottomAnchor constraintEqualToAnchor:view.bottomAnchor],
                                              [playerViewController.view.leadingAnchor constraintEqualToAnchor:view.leadingAnchor]
                                              ]];
  }
}

- (void)notificationHandler:(NSNotification*)notification {
  
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                       [notification name],
                       [OOOoyalaPlayerStateConverter playerStateToString:[self->ooyalaPlayerViewController.player state]],
                       [self->ooyalaPlayerViewController.player playheadTime], appDel.count];
  NSLog(@"%@",message);
  
  // In QA Mode , adding notifications to the TextView
  if (self.qaModeEnabled == YES) {
    NSString *string = self.textView.text;
    NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@", string, message];
    [self.textView setText:appendString];
  }
  
  appDel.count++;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
