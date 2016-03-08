//
//  FullscreenPlayerViewController.h
//  SampleTVOSApp
//
//  Created by Eric Vargas on 2/11/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OoyalaTVSDK/OOOoyalaTVPlayerViewController.h>

@class PlayerSelectionOption;

@interface FullscreenPlayerViewController : OOOoyalaTVPlayerViewController

@property (nonatomic, strong) PlayerSelectionOption *option;

@end
