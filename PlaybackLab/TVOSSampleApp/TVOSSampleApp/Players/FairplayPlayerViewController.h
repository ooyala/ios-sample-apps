//
//  FairplayPlayerViewController.h
//  TVOSSampleApp
//
//  Created on 6/1/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <OoyalaTVSkinSDK/OOOoyalaTVPlayerViewController.h>

@class PlayerSelectionOption;

@interface FairplayPlayerViewController : OOOoyalaTVPlayerViewController

@property (nonatomic) PlayerSelectionOption *option;

@end
