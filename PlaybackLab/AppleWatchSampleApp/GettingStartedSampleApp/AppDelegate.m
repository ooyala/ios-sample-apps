//
//  AppDelegate.m
//  GettingStartedSampleApp
//
//  Created by Chris Leonavicius on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BaseViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  UIViewController *baseController;
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    baseController = [[BaseViewController alloc] initWithNibName:@"BaseViewController_iPhone" bundle:nil];
  } else {
    baseController = [[BaseViewController alloc] initWithNibName:@"BaseViewController_iPad" bundle:nil];
  }

  UINavigationController *rootController = [[UINavigationController alloc] initWithRootViewController:baseController];
  self.window.rootViewController = rootController;
  [self.window makeKeyAndVisible];
  return YES;
}


- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply {


  NSString *action = [userInfo objectForKey:@"action"];
  NSLog(@"action = %@", action);
  ViewController *vc = (ViewController *)((UINavigationController*)self.window.rootViewController).visibleViewController;
  if ([vc isKindOfClass:[ViewController class]]) {
    if ([action isEqualToString:@"play"]) {
      [vc play];
      reply(@{@"action play executed":@(YES)});
    } else if ([action isEqualToString:@"pause"]){
      [vc pause];
      reply(@{@"action pause executed":@(YES)});
    } else {
      CGFloat playhead = [vc getPlayheadTime];
      reply(@{@"playheadTime":@(playhead)});
    }
  } else {
    reply(@{@"action executed":@(NO)});
  }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  /*
   Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  /*
   Called when the application is about to terminate.
   Save data if appropriate.
   See also applicationDidEnterBackground:.
   */
}

@end
