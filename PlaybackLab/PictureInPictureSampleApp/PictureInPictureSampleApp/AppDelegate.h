// Copyright (c) 2015 Ooyala, Inc. All rights reserved.

@import UIKit;
#import <OoyalaSDK/OoyalaSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
//A counter for tracking the number of ooyala sdk events generated across all the test asset plays
@property (nonatomic,assign) int count;

@end
