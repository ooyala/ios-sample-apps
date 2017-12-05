/**
 * @class      ChangeVideoPlayerViewController ChangeVideoPlayerViewController.m "ChangeVideoPlayerViewController.m"
 * @brief      A Player that demonstrates how to create additional overlays on the player
 * @details    ChangeVideoPlayerViewController in Ooyala Sample Apps
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "CustomOverlayPlayerViewController.h"
#import "CustomControlsViewController.h"
#import "CustomOverlayView.h"
#import "AppDelegate.h"
#import <OoyalaSDK/OoyalaSDK.h>


/*
 * This player demonstrates adding an overlay which hides and shows alongside the Controls
 *
 * If you simply want to create an overlay that shows independently of the controls,
 * you can add insert your view on top of the player like any subview
 */
@interface CustomOverlayPlayerViewController ()

#pragma mark - Private properties

@property OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;

@end


@implementation CustomOverlayPlayerViewController
AppDelegate *appDel;

#pragma mark - Initialization

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled {
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
  self.nib = @"PlayerSimple";
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

#pragma mark - Life cycle

- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode
                                                          domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
  
  // Add our custom overlay to the ViewController
  [self.ooyalaPlayerViewController setInlineOverlay:[[CustomOverlayView alloc] initWithFrame:self.playerView.bounds]];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:_ooyalaPlayerViewController.player];
  
  // In QA Mode , making textView visible
  self.textView.hidden = !self.qaModeEnabled;
  
  // Attach it to current view
  [self addChildViewController:_ooyalaPlayerViewController];
  [self.playerView addSubview:_ooyalaPlayerViewController.view];
  [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];
  
  // Load the video
  [_ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [_ooyalaPlayerViewController.player play];
}

- (void) notificationHandler:(NSNotification*) notification {
  
  // Ignore TimeChangedNotificiations for shorter logs
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                       [notification name],
                       [OOOoyalaPlayer playerStateToString:[self.ooyalaPlayerViewController.player state]],
                       [self.ooyalaPlayerViewController.player playheadTime], appDel.count];
  
  NSLog(@"%@",message);
  
  // In QA Mode , adding notifications to the TextView
  if (self.qaModeEnabled == YES) {
    NSString *string = self.textView.text;
    NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@" ,string, message];
    [self.textView setText:appendString];
  }
  appDel.count++;
}

@end
