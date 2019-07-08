//
//  AppDelegate.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "ListOfVideosViewController.h"
#import "ListOfVideosViewModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [self initRootViewController];
  return YES;
}

#pragma mark - Private functions

- (void)initRootViewController {
  UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  UINavigationController *listOfVideosNavigationController = [main instantiateViewControllerWithIdentifier:@"ListOfVideosNavigationController"];
  
  ListOfVideosViewController *listOfVideosViewController = listOfVideosNavigationController.viewControllers.firstObject;
  ListOfVideosViewModel *listOfVideosViewModel = [ListOfVideosViewModel new];

  listOfVideosViewController.viewModel = listOfVideosViewModel;
  
  self.window = [UIWindow new];
  self.window.rootViewController = listOfVideosNavigationController;
  [self.window makeKeyAndVisible];
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application
  supportedInterfaceOrientationsForWindow:(UIWindow *)window {
  return UIInterfaceOrientationMaskAll;
}

@end
