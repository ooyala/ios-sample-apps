//
//  AbstractPlayerViewController.h
//  SampleTVOSApp
//
//  Created by Eric Vargas on 2/11/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerSelectionOption;
@class OOOoyalaTVPlayerViewController;
@class OOOoyalaPlayer;

@interface AbstractPlayerViewController : UIViewController

@property (nonatomic, strong) OOOoyalaTVPlayerViewController *ooyalaPlayerViewController;
@property (nonatomic, strong) PlayerSelectionOption *option;
@property (nonatomic, strong) OOOoyalaPlayer *player;

- (void)notificationHandler:(NSNotification *)notification;

@end
