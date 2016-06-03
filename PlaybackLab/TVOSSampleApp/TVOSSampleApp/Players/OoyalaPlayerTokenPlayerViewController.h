//
//  OoyalaPlayerTokenPlayerViewController.h
//  TVOSSampleApp
//
//  Created by Yi Gu on 6/2/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <OoyalaTVSkinSDK/OOOoyalaTVPlayerViewController.h>

@class PlayerSelectionOption;
@interface OoyalaPlayerTokenPlayerViewController : OOOoyalaTVPlayerViewController

@property (nonatomic, strong) PlayerSelectionOption *option;

@end
