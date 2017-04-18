//
//  AppDelegate.h
//  ChannelBrowserSampleApp
//
//  Created by Zhihui Chen on 2/18/15.
//  Copyright (c) 2015 ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//A counter for tracking the number of ooyala sdk events generated across all the test asset plays
@property (nonatomic,assign) int count ;


@end

