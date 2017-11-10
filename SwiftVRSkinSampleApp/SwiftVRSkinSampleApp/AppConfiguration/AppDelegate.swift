//
//  AppDelegate.swift
//  VRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    initRootViewController()
    
    return true
  }

  // MARK: - Private functions
  
  private func initRootViewController() {
    
    guard let listOfVideosNavigationController = UIStoryboard.init(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "ListOfVidesNavigationController") as? UINavigationController,
      let listOfVideosViewController = listOfVideosNavigationController.viewControllers.first as? ListOfVideosViewController else {
        fatalError("AppDelegate - initRootViewController, error")
    }
    
    let listOfVideosViewModel = ListOfVideosViewModel()
    
    listOfVideosViewController.viewModel = listOfVideosViewModel
    
    window = UIWindow()
    
    window?.rootViewController = listOfVideosNavigationController
    
    window?.makeKeyAndVisible()
  }

  
}
