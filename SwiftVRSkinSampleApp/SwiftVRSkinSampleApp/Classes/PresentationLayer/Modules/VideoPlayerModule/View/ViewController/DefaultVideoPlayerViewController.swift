//
//  DefaultVideoPlayerViewController.swift
//  VRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

import UIKit

class DefaultVideoPlayerViewController: UIViewController {
  
  // MARK: - Public properties
  
  var viewModel: VideoPlayerViewModel!
  var skinController: OOSkinViewController!
  var appDelegate: AppDelegate?

  // MARK: - IBOutlets
  
  @IBOutlet weak var skinContainerView: UIView!
  @IBOutlet weak var qaInfoTextView: UITextView!
  
  // MARK: - Init/deinit
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureObjects()
    configureUI()
  }
  
  // MARK: - Private functions
  
  private func configureObjects() {
    
    // App Delegate
  
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      self.appDelegate = appDelegate
    }
    
    // VR player
    
    let jsCodeLocation = Bundle.main.url(forResource: "main", withExtension: "jsbundle")
    let overrideConfigs = ["upNextScreen" : ["timeToShow" : "8"]]
    let options = OOOptions()
    
    options?.showPromoImage = true
    options?.bypassPCodeMatching = false
    
    let domain = OOPlayerDomain(string: viewModel.domain)
    let ooyalaVRPlayer = OOOoyalaVRPlayer(pcode: viewModel.pcode, domain: domain, options: options)
    
    // Skin
    
    let discoveryOptions = OODiscoveryOptions(type: .popular, limit: 10, timeout: 60)
    let skinOptions = OOSkinOptions(discoveryOptions: discoveryOptions, jsCodeLocation: jsCodeLocation, configFileName: "skin", overrideConfigs: overrideConfigs)
    
    skinController = OOSkinViewController(player: ooyalaVRPlayer, skinOptions: skinOptions, parent: skinContainerView, launchOptions: nil)
    
    // Subscribe for notifications with QA mode enabled
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(notificationHandler(notification:)),
                                           name: nil,
                                           object: skinController.player)

    NotificationCenter.default.addObserver(self,
                                           selector: #selector(switchFullScreenNotificationHandler(notification:)),
                                           name: NSNotification.Name.OOOoyalaPlayerSwitchScene,
                                           object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(touchesNotificationHandler(notification:)),
                                           name: NSNotification.Name.OOOoyalaPlayerHandleTouch,
                                           object: nil)
    
    // Set video embed code
    
    ooyalaVRPlayer?.setEmbedCode(viewModel.videoItem.embedCode)
  }
  
  private func configureUI() {
    
    // Title
    
    navigationItem.title = viewModel.videoItem.title
    
    // Add skin controlle what childer view controller

    addChildViewController(skinController)

    // Update container view Y position
    
    if !viewModel.QAModeEnabled {
      skinContainerView.frame = CGRect(
        x: skinContainerView.frame.origin.x,
        y: view.bounds.size.height / 2 - skinContainerView.bounds.size.height / 2,
        width: skinContainerView.bounds.size.width,
        height: skinContainerView.bounds.size.height)
    }
    
    // Set hidden text view with QA mode enabled
    
    qaInfoTextView.isHidden = !viewModel.QAModeEnabled
  }
  
  private func printLogInTextViewIfNeeded(logMessage: String) {

    // In QA Mode , adding notifications to the TextView

    if viewModel.QAModeEnabled {
      DispatchQueue.main.async {
        let string = self.qaInfoTextView.text
        let appendString = "\(string ?? "") :::::::::: \(logMessage)"

        self.qaInfoTextView.text = appendString
      }
    }
  }
  
  // MARK: - Notifications
  
  @objc private func notificationHandler(notification: Notification) {
    
    // Ignore TimeChangedNotificiations for shorter logs

    if notification.name == NSNotification.Name.OOOoyalaPlayerTimeChanged {
      return
    }
    
    let playerState = OOOoyalaVRPlayer.playerState(toString: skinController.player.state()) ?? "unknown"
    let playhead = skinController.player.playheadTime()
    let notificationsCount = appDelegate?.count ?? 0

    var message = "Notification Received: \(notification.name.rawValue). " +
      "state: \(playerState). " +
      "playhead: \(playhead). " +
      "count: \(notificationsCount)"
    
    if notification.name.rawValue == OOOoyalaPlayerVideoHasVRContent {
      let vrContentUserInfo = notification.userInfo
      let isVrContent = vrContentUserInfo?["vrContent"] as? Bool ?? false
      
      message += " vrContentEvent: \(isVrContent)"
    }
    
    NSLog(message)
    
    printLogInTextViewIfNeeded(logMessage: message)
    
    appDelegate?.count += 1
  }
  
  @objc private func switchFullScreenNotificationHandler(notification: Notification) {
    let playhead = skinController.player.playheadTime()
    let notificationsCount = appDelegate?.count ?? 0

    let message = "Notification Received: vrModeChanged. playhead: \(playhead). count: \(notificationsCount)"
    
    NSLog(message)
    
    printLogInTextViewIfNeeded(logMessage: message)
    
    appDelegate?.count += 1
  }
  
  @objc private func touchesNotificationHandler(notification: Notification) {
    let notificationObject = notification.object as? [String : Any]
    let playhead = skinController.player.playheadTime()
    let notificationsCount = appDelegate?.count ?? 0
    let touchesEventName = notificationObject?["eventName"] as? String ?? "unknown"
    
    let message = "Notification Received: gvrViewRotated. " +
      "touchesEventName: \(touchesEventName). " +
      "playhead: \(playhead). " +
      "count: \(notificationsCount)"

    NSLog(message)
    
    printLogInTextViewIfNeeded(logMessage: message)
    
    appDelegate?.count += 1
  }
  
  
}
