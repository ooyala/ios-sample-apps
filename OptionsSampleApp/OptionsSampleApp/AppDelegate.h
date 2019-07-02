//
//  AppDelegate.h
//  OptionsSampleApp
//
//  Created on 12/18/14.
//  Copyright (c) 2014 ooyala. All rights reserved.
//

@import UIKit;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic) UIWindow *window;

//A counter for tracking the number of ooyala sdk events generated across all the test asset plays
@property (nonatomic, assign) int count;

@end

