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
  var count: Int = 0

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    initRootViewController()
    return true
  }

  // MARK: - Private functions
  private func initRootViewController() {
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

    guard let listOfVideosNavigationController =
      mainStoryboard.instantiateViewController(withIdentifier: "ListOfVidesNavigationController")
        as? UINavigationController,
          let listOfVideosViewController = listOfVideosNavigationController.viewControllers.first
        as? ListOfVideosViewController else {
        fatalError("AppDelegate - initRootViewController, error")
    }

    let listOfVideosViewModel = ListOfVideosViewModel()
    listOfVideosViewController.viewModel = listOfVideosViewModel

    window = UIWindow()
    window?.rootViewController = listOfVideosNavigationController
    window?.makeKeyAndVisible()
  }

  func application(_ application: UIApplication,
                   supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return .all
  }
}
