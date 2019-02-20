//
//  AppDelegate.h
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

@import UIKit;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic) UIWindow *window;

// A counter for tracking the number of ooyala sdk events generated across all the test asset plays
@property (nonatomic) NSInteger count;

@end
