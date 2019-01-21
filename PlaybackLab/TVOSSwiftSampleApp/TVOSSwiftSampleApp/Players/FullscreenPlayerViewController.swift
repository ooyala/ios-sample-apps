//
//  FullscreenPlayerViewController.swift
//  TVOSSwiftSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import Foundation

class FullscreenPlayerViewController: OOOoyalaTVPlayerViewController {
  
  var option : PlayerSelectionOption!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    player = OOOoyalaPlayer(pcode: option.pcode, domain: OOPlayerDomain(string: option.domain))
    NotificationCenter.default.addObserver(self, selector: #selector(notificationHandler(_:)), name: nil, object: player)
    player.setEmbedCode(option.embedCode)
    player.play()
  }
  
  @objc func notificationHandler(_ notification: Notification) {
    let name = notification.name
    if name == NSNotification.Name.OOOoyalaPlayerTimeChanged {
      return
    }
    
    NSLog("Notification Received: %@. state: %@. playhead: %f", name.rawValue,
          OOOoyalaPlayerStateConverter.playerState(toString: player.state()),
          player.playheadTime())
  }
  
}
