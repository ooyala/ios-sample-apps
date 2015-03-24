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
    formatter = NSDateFormatter()
    ooyalaPlayerViewController = OOOoyalaPlayerViewController()
    
    super.init(coder: aDecoder)
  }
  
  @IBOutlet weak var playerView: UIView!
  @IBOutlet var textView: UITextView!
  
  let EMBED_CODE = "lrZmRiMzrr8cP77PPW0W8AsjjhMJ1BBe"
  let PCODE = "Z5Mm06XeZlcDlfU_1R9v_L2KwYG6"
  let PLAYERDOMAIN = "http://www.ooyala.com"
  
  var formatter: NSDateFormatter
  var ooyalaPlayerViewController: OOOoyalaPlayerViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Create Ooyala ViewController
    var player: OOOoyalaPlayer = OOOoyalaPlayer(pcode: PCODE, domain: OOPlayerDomain(string: PLAYERDOMAIN))
    ooyalaPlayerViewController = OOOoyalaPlayerViewController(player: player)
    
    // Attach it to current view
    self.addChildViewController(ooyalaPlayerViewController)
    ooyalaPlayerViewController.view.frame = playerView.bounds
    self.addChildViewController(ooyalaPlayerViewController)
    playerView.addSubview(ooyalaPlayerViewController.view)
    
    // Setup an UI_textView for dislaying message
    self.view.addSubview(textView)
    textView.text = "LOG:"
    
    // Setup time format
    let locale = NSLocale.currentLocale()
    let dateFormat = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: locale)
    formatter.dateFormat = dateFormat
    
    // Load the video
    ooyalaPlayerViewController.player.setEmbedCode(EMBED_CODE)
    //NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector(notificationHandler()), name: nil, object: ooyalaPlayerViewController.player)
  }
  
  func onPlayerError(notification: NSNotification){
    NSLog("Error: %@", ooyalaPlayerViewController.player.error)
  }
  
  func notificationHandler(notification: NSNotification) {
    var name = notification.name
    if name == OOOoyalaPlayerTimeChangedNotification {
      return
    }
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}
