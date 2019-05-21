//
//  AppDelegate.swift
//  DownloadToOwnSampleAppSwift
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  var orientationLock = UIInterfaceOrientationMask.portrait

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    OODtoAsset.restoreAllDownloads(for: OptionDataSource.dtoAssets as! NSMutableArray)
    return true
  }

  func application(_ application: UIApplication,
                   handleEventsForBackgroundURLSession identifier: String,
                   completionHandler: @escaping () -> Void) {
    OODtoAsset.setBackgroundSessionCompletionHandler(completionHandler)
  }
  
  func application(_ application: UIApplication,
                   supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return orientationLock
  }

}
