// Copyright (c) 2015 Ooyala, Inc. All rights reserved.

#import "AppDelegate.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  OOOptions *options = [OOOptions new];
  self.player = [[OOOoyalaPlayer alloc] initWithPcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU" domain:[[OOPlayerDomain alloc] initWithString:@"http://player.ooyala.com"] options:options];
  return YES;
}

@end
