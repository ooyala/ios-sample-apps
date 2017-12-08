//
//  AppDelegate.m
//  VRTVSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <OoyalaVRTVSDK/OoyalaVRTVSDK.h>

@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [OOOoyalaVRTVPlayer setEnvironment:OOOoyalaPlayerEnvironmentStaging];
  return YES;
}

@end
