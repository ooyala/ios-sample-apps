//
//  AbstractPlayerViewController.m
//  TVOSSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "AbstractPlayerViewController.h"
#import <OoyalaSDK/OOOoyalaPlayer.h>

@interface AbstractPlayerViewController ()

@end

@implementation AbstractPlayerViewController

- (void)notificationHandler:(NSNotification *)notification {
  if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
    return;
  }
  
  NSLog(@"Notification Received: %@. state: %@. playhead: %f",
        notification.name,
        [OOOoyalaPlayerStateConverter playerStateToString:self.player.state],
        self.player.playheadTime);
}

@end
