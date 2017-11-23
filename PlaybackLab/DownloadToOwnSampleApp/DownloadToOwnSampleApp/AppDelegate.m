//
//  AppDelegate.m
//  DownloadToOwnSampleApp
//
//  Created on 8/8/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "AppDelegate.h"
#import "AssetPersistenceManager.h"
#import "Alert.h"

@interface AppDelegate ()

@property (nonatomic, retain) Reachability *reachability;

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  [self setUpNetworkObserver];
  [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];

  return YES;
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
  [self networkStatusDidChanged:nil];
  completionHandler(YES);
}

-(void)setUpNetworkObserver {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusDidChanged:) name:kReachabilityChangedNotification object:nil];
  self.reachability = [Reachability reachabilityForInternetConnection];
  [self.reachability startNotifier];

  self.netStatus = [self.reachability currentReachabilityStatus];
}

- (void) networkStatusDidChanged:(NSNotification *)notice {
  self.netStatus = [self.reachability currentReachabilityStatus];
  BOOL isDownloading = [[AssetPersistenceManager sharedManager] isDownloading];
  BOOL arePendingDownloads = [[AssetPersistenceManager sharedManager] arePendingDownloads];

  switch (self.netStatus) {
    case NotReachable: {
      if (isDownloading) {
        [[AssetPersistenceManager sharedManager] pauseDownloads];
        [Alert showAlertInWindow:self.window title:@"Network Connection Lost" andMessage:@"Downloads are paused now, please reconnect to continue downloading."];
      }
      break;
    }
    case ReachableViaWWAN: {
      BOOL useCellularForDownloads = [[NSUserDefaults standardUserDefaults] boolForKey:@"use_cellular"];
      if (!useCellularForDownloads) {
        if (isDownloading) {
          [[AssetPersistenceManager sharedManager] pauseDownloads];
          [Alert showAlertInWindow:self.window title:@"Network Connection Lost" andMessage:@"Downloads are paused now, please reconnect to continue downloading or allow downloads over cellular network on settings."];
        }
      }
      else {
        if (arePendingDownloads) {
          [[AssetPersistenceManager sharedManager] resumeDownloads];
        }
      break;
      }
    }
    case ReachableViaWiFi: {
      if (arePendingDownloads) {
        [[AssetPersistenceManager sharedManager] resumeDownloads];
      }
      break;
    }
  }
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler {
  
}

@end
