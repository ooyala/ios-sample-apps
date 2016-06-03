//
//  FairplayPlayerViewController.h
//  TVOSSampleApp
//
//  Created by Yi Gu on 6/1/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OoyalaTVSkinSDK/OOOoyalaTVPlayerViewController.h>

@class PlayerSelectionOption;

@interface FairplayPlayerViewController : OOOoyalaTVPlayerViewController

@property (nonatomic, strong) PlayerSelectionOption *option;

@end
