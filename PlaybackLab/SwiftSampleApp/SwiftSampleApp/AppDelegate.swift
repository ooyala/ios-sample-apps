//
//  AppDelegate.swift
//  SwiftSampleApp
//
//  Created by Yi Gu on 3/23/15.
//  Copyright (c) 2015 Ooyala Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  func application(_ application: UIApplication, handleWatchKitExtensionRequest userInfo: [AnyHashable: Any]?, reply: (([AnyHashable: Any]?) -> Void)!) {
    let info = userInfo as NSDictionary?
    let action:NSString = info!.object(forKey: "action") as! NSString
    let vc: ViewController = (self.window?.rootViewController as! UINavigationController).visibleViewController as! ViewController
    
    if vc.isKind(of: ViewController.self) {
      if action == "play" {
        vc.play()
        reply(["action play executed":"YES"])
      }else if action == "pause" {
        vc.pause()
        reply(["action pause executed":"YES"]);
      }else {
        let playhead = vc.getPlayhead()
        reply(["playheadTime":playhead]);
      }
    }else {
      reply(["action executed":"NO"])
    }
  }
  

}

