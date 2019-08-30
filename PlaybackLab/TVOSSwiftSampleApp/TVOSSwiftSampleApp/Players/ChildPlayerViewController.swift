//
//  ChildPlayerViewController.swift
//  TVOSSwiftSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//
// This example shows shows a use case in which you want to show the player next to
// other UI in the screen, so the player will not be in fullscreen mode taking all
// your screen space, but it will be sharing the UI with other elements which could
// be actionable too, like buttons.
//
// This is not a verified use case by Ooyala and cause extrange behavior for the player,
// but we provide the example in case you want to use it.

import Foundation

class ChildPlayerViewController: AbstractPlayerViewController {
  
  @IBOutlet var playerView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
     // Create Ooyala ViewController
    let player = OOOoyalaPlayer(pcode: option.pcode,
                                domain: OOPlayerDomain(string: option.domain))
    ooyalaPlayerViewController = OOOoyalaTVPlayerViewController(player: player)
    ooyalaPlayerViewController.playbackControlsEnabled = false
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(notificationHandler(_:)),
                                           name: nil,
                                           object: player)
    
    // Attach it to current view
    addChild(ooyalaPlayerViewController)
    ooyalaPlayerViewController.view.frame = playerView.bounds
    playerView.addSubview(ooyalaPlayerViewController.view)
    ooyalaPlayerViewController.didMove(toParent: self)
    
    // Load the video
    ooyalaPlayerViewController.player.setEmbedCode(option.embedCode, shouldAutoPlay: true, withCallback: nil)
  }
  
}
