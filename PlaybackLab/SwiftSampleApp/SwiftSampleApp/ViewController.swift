//
//  ViewController.swift
//  SwiftSampleApp
//
//  Created by Yi Gu on 3/23/15.
//  Copyright (c) 2015 Ooyala Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  required init(coder aDecoder: NSCoder) {
    formatter = DateFormatter()
    ooyalaPlayerViewController = OOOoyalaPlayerViewController()
    
    super.init(coder: aDecoder)!
  }
  
  @IBOutlet weak var playerView: UIView!
  @IBOutlet var textView: UITextView!
  
  let EMBED_CODE = "Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
  let PCODE = "c0cTkxOqALQviQIGAHWY5hP0q9gU"
  let PLAYERDOMAIN = "http://www.ooyala.com"
  
  var formatter: DateFormatter
  var ooyalaPlayerViewController: OOOoyalaPlayerViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Create Ooyala ViewController
    let player: OOOoyalaPlayer = OOOoyalaPlayer(pcode: PCODE, domain: OOPlayerDomain(string: PLAYERDOMAIN))
    ooyalaPlayerViewController = OOOoyalaPlayerViewController(player: player)

    // Attach it to current view
    self.addChild(ooyalaPlayerViewController)
    ooyalaPlayerViewController.view.frame = playerView.bounds
    self.addChild(ooyalaPlayerViewController)
    playerView.addSubview(ooyalaPlayerViewController.view)
    
    // Setup an UI_textView for dislaying message
    self.view.addSubview(textView)
    textView.text = "LOG:"
    
    // Hide Keyboard by setting the size of keyboard to (0, 0)
    let keyboardView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    textView.inputView = keyboardView
    
    // Setup time format
    let zone  = TimeZone.autoupdatingCurrent
    formatter.timeZone = zone
    formatter.dateFormat = "\nyyyy-MM-dd HH:mm:ss \n"
    
    // Load the video
    ooyalaPlayerViewController.player.setEmbedCode(EMBED_CODE)
    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.notificationHandler(_:)), name: nil, object: ooyalaPlayerViewController.player)
  }
  
  func onPlayerError(_ notification: Notification){
    NSLog("Error: %@", ooyalaPlayerViewController.player.error)
  }

  @objc func notificationHandler(_ notification: Notification) {
    let name = notification.name
    if name == NSNotification.Name.OOOoyalaPlayerTimeChanged {
      return
    }

    NSLog("Notification Received: %@", name.rawValue)
  }

  func play() {
    ooyalaPlayerViewController.player.play()
  }
  
  func pause() {
    ooyalaPlayerViewController.player.pause()
  }
  
  func getPlayhead() -> Float64 {
    return ooyalaPlayerViewController.player.playheadTime()
  }

}
