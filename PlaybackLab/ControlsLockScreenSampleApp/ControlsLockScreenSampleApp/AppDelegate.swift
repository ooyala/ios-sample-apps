//
//  AppDelegate.swift
//  ControlsLockScreenSampleApp
//
//  Copyright © 2017 Ooyala. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    // The audio session can be added in the video view controller.
    // The session has to be set before to play content.
    let session = AVAudioSession.sharedInstance()
    do {
      try session.setCategory(.playback, mode: .default)
      print("AVAudioSession Category Playback OK")
      do {
        try session.setActive(true)
        print("AVAudioSession is Active")
      } catch let error as NSError {
        print(error.localizedDescription)
      }
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    playbackBackground()
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    playbackBackground()
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive.
    // If the application was previously in the background, optionally refresh the user interface.
    playbackBackground()
  }
  
  private func playbackBackground() {
    guard let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController,
      let viewController = navigationController.viewControllers.last as? PlayerViewController,
      let player = viewController.ooyalaPlayerVC?.player else { return }
    if player.isPlaying() {
      player.perform(#selector(player.play as () -> Void), with: nil, afterDelay: 0.1)
    } else {
      player.perform(#selector(player.pause as () -> Void), with: nil, afterDelay: 0.1)
    }
    viewController.updatePlayingInfoCenter()
  }
}

