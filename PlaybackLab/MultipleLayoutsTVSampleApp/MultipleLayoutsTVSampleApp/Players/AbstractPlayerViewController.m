//
//  AbstractPlayerViewController.m
//  SampleTVOSApp
//
//  Created by Eric Vargas on 2/11/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "AbstractPlayerViewController.h"
#import <OoyalaTVSDK/OOOoyalaPlayer.h>

@interface AbstractPlayerViewController ()

@end

@implementation AbstractPlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)notificationHandler:(NSNotification *)notification
{
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        [notification name],
        [OOOoyalaPlayer playerStateToString:[self.player state]],
        [self.player playheadTime]);
}

@end
