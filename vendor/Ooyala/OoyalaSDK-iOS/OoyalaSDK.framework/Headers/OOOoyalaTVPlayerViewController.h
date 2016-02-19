//
//  OOOoyalaTVPlayerViewController.h
//  OoyalaSDK
//
//  Created by Eric Vargas on 1/28/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OOOoyalaPlayer;

@interface OOOoyalaTVPlayerViewController : UIViewController

@property (strong, nonatomic) OOOoyalaPlayer *player;

- (instancetype)initWithPlayer:(OOOoyalaPlayer *)player;

@end
