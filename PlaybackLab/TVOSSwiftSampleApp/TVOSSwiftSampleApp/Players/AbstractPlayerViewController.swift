//
//  AbstractPlayerViewController.swift
//  TVOSSwiftSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import Foundation

class AbstractPlayerViewController: UIViewController {
  
  var ooyalaPlayerViewController : OOOoyalaTVPlayerViewController!
  var option: PlayerSelectionOption!
  var player: OOOoyalaPlayer!
  
  @objc func notificationHandler(_ notification: Notification) {
    let name = notification.name
    if name == NSNotification.Name.OOOoyalaPlayerTimeChanged {
      return
    }
    
    NSLog("Notification Received: %@. state: %@. playhead: %f", name.rawValue,
          OOOoyalaPlayerStateConverter.playerState(toString: player.state),
          player.playheadTime())
  }
  
}
