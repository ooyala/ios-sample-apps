/**
 * @class      InsertAdPlayerViewController InsertAdPlayerViewController.m "InsertAdPlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    InsertAdPlayerViewController in Ooyala Sample Apps
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */


#import "InsertAdPlayerViewController.h"

#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"

@interface InsertAdPlayerViewController ()
@property OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property OOManagedAdsPlugin *plugin;
@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@end

@implementation InsertAdPlayerViewController
 AppDelegate *appDel;
- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled{
  self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
  self.nib = @"PlayerDoubleButton";
     NSLog(@"value of qa mode in InsertAdPlayerViewController %@", self.qaModeEnabled ? @"YES" : @"NO");

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
  OOVASTAdSpot *vastAd = [[OOVASTAdSpot alloc] initWithTime:[NSNumber numberWithFloat:[self.ooyalaPlayerViewController.player playheadTime]] duration:self.ooyalaPlayerViewController.player.duration clickURL:nil trackingURLs:nil vastURL:[NSURL URLWithString:@"http://player.ooyala.com/static/v4/testAssets/vast2/VastAd_Preroll.xml"]];
  [self.plugin insertAd:vastAd];
}

- (IBAction)onRightBtnClick:(UIButton *)sender
{
  OOOoyalaAdSpot *ooyalaAd = [[OOOoyalaAdSpot alloc] initWithTime:[NSNumber numberWithFloat:[self.ooyalaPlayerViewController.player playheadTime]] clickURL:nil trackingURLs:nil embedCode:@"Zvcmp0ZDqD6xnQVH8ZhWlxH9L9bMGDDg" api:[self.ooyalaPlayerViewController.player api]];
  [self.plugin insertAd:ooyalaAd];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  appDel = [[UIApplication sharedApplication] delegate];
  [self.button1 setTitle:@"INSERT VAST AD" forState:UIControlStateNormal];
  [self.button2 setTitle:@"INSERT OOYALA AD" forState:UIControlStateNormal];

  // Create Ooyala ViewController
  OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
  self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
    // In QA Mode , making textView visible
    if(self.qaModeEnabled==YES){
        self.textView.hidden = NO;
        
    }

  
  // Create Ooyala Ads Plugin
  self.plugin = [self.ooyalaPlayerViewController.player managedAdsPlugin];
  
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:_ooyalaPlayerViewController.player];

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
        
    }
    
    appDel.count++;
}


@end
