/**
 * Copyright (c) 2015, Ooyala, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
//A counter for tracking the number of ooyala sdk events generated across all the test asset plays
@property (nonatomic,assign) int count;

@end
