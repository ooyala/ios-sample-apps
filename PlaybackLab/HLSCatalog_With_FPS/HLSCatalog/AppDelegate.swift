/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 `AppDelegate` is the AppDelegate for this sample.  The only additional work this class does is intiate the restoring process of `AssetPersistenceManager by calling AssetPersistenceManager.sharedManager.restorePersistenceManager().
 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Restore the state of the application and any running downloads.
        AssetPersistenceManager.sharedManager.restorePersistenceManager()
        
        return true
    }
}
