//
//  PulsePlayerViewController.h
//  TVOSSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OoyalaTVSkinSDK/OOOoyalaTVPlayerViewController.h>

@class PlayerSelectionOption;

@interface PulsePlayerViewController : OOOoyalaTVPlayerViewController

@property (nonatomic, strong) PlayerSelectionOption *option;

@end
