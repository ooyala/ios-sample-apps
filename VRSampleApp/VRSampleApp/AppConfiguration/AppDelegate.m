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
  UINavigationController *listOfVideosNavigationController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"ListOfVideosNavigationController"];
  
  ListOfVideosViewController *listOfVideosViewController = listOfVideosNavigationController.viewControllers.firstObject;
  ListOfVideosViewModel *listOfVideosViewModel = [ListOfVideosViewModel new];

  listOfVideosViewController.viewModel = listOfVideosViewModel;
  
  self.window = [UIWindow new];
  self.window.rootViewController = listOfVideosNavigationController;
  [self.window makeKeyAndVisible];
  
}


@end
