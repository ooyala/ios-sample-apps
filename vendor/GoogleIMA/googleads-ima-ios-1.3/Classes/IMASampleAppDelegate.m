//
//  IMASampleAppDelegate.m
//  SampleAppV3
//
//  Copyright (c) 2013 Google Inc. All rights reserved.

#import "IMASampleAppDelegate.h"
#import "BaseViewController.h"

@implementation IMASampleAppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//  UIViewController *baseController = [[BaseViewController alloc]
//                            initWithNibName:@"BaseViewController"
//                                     bundle:[NSBundle mainBundle]];
  UIViewController *baseController;
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    baseController = [[BaseViewController alloc] initWithNibName:@"BaseViewController_iPhone" bundle:nil];
  } else {
    baseController = [[BaseViewController alloc] initWithNibName:@"BaseViewController_iPad" bundle:nil];
  }
  self.window = [[UIWindow alloc]
                    initWithFrame:[[UIScreen mainScreen] bounds]];
  UINavigationController *rootController = [[UINavigationController alloc] initWithRootViewController:baseController];
  self.window.rootViewController = rootController;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
