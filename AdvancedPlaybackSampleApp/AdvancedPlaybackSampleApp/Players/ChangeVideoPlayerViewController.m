/**
 * @class      ChangeVideoPlayerViewController ChangeVideoPlayerViewController.m "ChangeVideoPlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    ChangeVideoPlayerViewController in Ooyala Sample Apps
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */


#import "ChangeVideoPlayerViewController.h"
#import "AppDelegate.h"
#import <OoyalaSDK/OoyalaSDK.h>

@interface ChangeVideoPlayerViewController ()
@property OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;
@end

@implementation ChangeVideoPlayerViewController
{
 AppDelegate *appDel;
}
- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled {
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
  self.nib = @"PlayerDoubleButton";
NSLog(@"value of qa mode in ChangeVideoProgrammaticallyViewController %@", self.qaModeEnabled ? @"YES" : @"NO");
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


- (void)loadView {
  [super loadView];
  [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (IBAction)onLeftBtnClick:(UIButton *)sender
{
  [self.ooyalaPlayerViewController.player setEmbedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"];
  [self.ooyalaPlayerViewController.player play];
}

- (IBAction)onRightBtnClick:(UIButton *)sender
{
  [self.ooyalaPlayerViewController.player setEmbedCode:@"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx"];
  [self.ooyalaPlayerViewController.player play];
}


- (void)viewDidLoad {
  [super viewDidLoad];
    
    appDel = [[UIApplication sharedApplication] delegate];
  
  [self.button1 setTitle:@"Play Video 1" forState:UIControlStateNormal];
  [self.button2 setTitle:@"Play Video 2" forState:UIControlStateNormal];

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];

  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:_ooyalaPlayerViewController.player];
    
    // In QA Mode , making textView visible
    if(self.qaModeEnabled==YES){
        self.textView.hidden = NO;
    }
    else{
        [self.textView removeFromSuperview];
    }

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
    
    //In QA Mode , adding notifications to the TextView
    if(self.qaModeEnabled==YES) {
        NSString *string = self.textView.text;
        NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@",string,message];
        [self.textView setText:appendString];
    
         appDel.count++;
        
    }
   appDel.count++;
   
}
@end
