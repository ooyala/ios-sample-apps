//
//  ViewController.m
//  Freewheel Sample App
//
//  Created by Sumin Kang on 11/27/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//
//  This Sample App demonstrates how to integrate Freewheel Ad Manager with the Ooyala player
//

#import "ViewController.h"
#import "OOOoyalaPlayerViewController.h"
#import "OOOoyalaPlayer.h"
#import "OOOoyalaError.h"
#import "OOFreewheelManager.h"
#import "OOPlayerDomain.h"

#define Y_OFFSET 0

@interface ViewController ()

@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (nonatomic) OOFreewheelManager *fwAdManager;
@property(nonatomic) NSDateFormatter* formatter;

@end

@implementation ViewController

@synthesize ooyalaPlayerViewController;
@synthesize embedCode;

NSString *const PCODE        = @"BidTQxOqebpNk1rVsjs2sUJSTOZc";
NSString *const PLAYERDOMAIN = @"http://www.ooyala.com";

- (void)viewDidLoad {
  [super viewDidLoad];
	ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPcode:PCODE domain:[[OOPlayerDomain alloc] initWithString:PLAYERDOMAIN]];

  self.textView.editable = NO;
  [_textView setText: @"LOG:"];

  // Setup time format
  _formatter = [[NSDateFormatter alloc] init];
  NSTimeZone *zone = [NSTimeZone localTimeZone];
  [_formatter setTimeZone:zone];
  [_formatter setDateFormat:@"\nyyyy-MM-dd HH:mm:ss \n"];

  //Setup video view
  CGRect rect = self.playerView.bounds;
  [ooyalaPlayerViewController.view setFrame:rect];
  [self addChildViewController:ooyalaPlayerViewController];
  [self.playerView addSubview:ooyalaPlayerViewController.view];

  //Setup Freewheel
  self.fwAdManager = [[OOFreewheelManager alloc] initWithOoyalaPlayerViewController:ooyalaPlayerViewController];

  //Set Freewheel parameters. Note that these are optional, and override configurations set in Backlot or in Ooyala internals
  NSMutableDictionary *fwParameters = [[NSMutableDictionary alloc] init];
  //[fwParameters setObject:@"90750" forKey:@"fw_ios_mrm_network_id"];
  [fwParameters setObject:@"http://g1.v.fwmrm.net/" forKey:@"fw_ios_ad_server"];
  [fwParameters setObject:@"90750:ooyala_ios" forKey:@"fw_ios_player_profile"];
  [fwParameters setObject:@"channel=TEST;subchannel=TEST;section=TEST;mode=online;player=ooyala;beta=n" forKey:@"FRMSegment"];
  //[fwParameters setObject:@"ooyala_test_site_section" forKey:@"fw_ios_site_section_id"];
  //[fwParameters setObject:@"ooyala_test_video_with_bvi_cuepoints" forKey:@"fw_ios_video_asset_id"];

  [self.fwAdManager overrideFreewheelParameters:fwParameters];

  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector:@selector(notificationHandler:)
                                               name:nil
                                             object:ooyalaPlayerViewController.player];

  [ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
  [ooyalaPlayerViewController.player play];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  //Dispose of any resources that can be recreated
}
- (void) notificationHandler:(NSNotification*) notification {
  NSString* name = notification.name;
  if ([name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return; // do something when we do need the timeChanged notification
  }

  NSLog(@"Notification Received: %@ - state: %@ -- playhead: %f, duration: %f",
      [notification name],
      [OOOoyalaPlayer playerStateToString:[ooyalaPlayerViewController.player state]],
      [ooyalaPlayerViewController.player playheadTime],
      [ooyalaPlayerViewController.player duration]);

  NSDate* timer = [[NSDate alloc] init];
  NSString* timeStamp = [_formatter stringFromDate:timer];
  timeStamp = [timeStamp substringToIndex: [timeStamp length] - 2];
  if ([name isEqualToString:OOOoyalaPlayerErrorNotification]) {
    NSString* error = ooyalaPlayerViewController.player.error.description;
    [_textView insertText:[NSString stringWithFormat:@"%@,%@,%@", timeStamp, @" Error: ", error]];
  } else if ([name isEqualToString:OOOoyalaPlayerStateChangedNotification]) {
    OOOoyalaPlayerState state = ooyalaPlayerViewController.player.state;
    NSString* currentState = [OOOoyalaPlayer playerStateToString:state];
    [_textView insertText:[NSString stringWithFormat:@"%@,%@,%@", timeStamp, @" State: ", currentState]];
  } else {
    [_textView insertText:[NSString stringWithFormat:@"%@,%@,%@", timeStamp, @" ", name]];
  }
  [_textView insertText:@"\n"];
  [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 0)];
}

@end
