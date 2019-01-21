//
//  PulsePlayerViewController.h
//  TVOSSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <OoyalaTVSkinSDK/OOOoyalaTVPlayerViewController.h>

@class PulseLibraryOption;

@interface PulsePlayerViewController : OOOoyalaTVPlayerViewController

@property (nonatomic, strong) PulseLibraryOption *option;

@end
