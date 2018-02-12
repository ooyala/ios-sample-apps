//
//  PlayerViewController.swift
//  SerializationDownloadsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var playerView: UIView!
  
  @IBOutlet weak var stateLabel: UILabel!
  
  @IBOutlet weak var playOnlineButton: UIButton!
  
  @IBOutlet weak var playOfflineButton: UIButton!
  
  
  /**
   The option contains the info concerning this cell.
   The cell cares a lot about the embed code to know what to do
   when it gets the embed code through a notification, for example.
   */
  public private(set) var option: PlayerSelectionOption!
  
  // properties required for a Fairplay asset
  private var apiKey = ""
  private var apiSecret = ""
  
  private var ooyalaPlayerViewController: OOSkinViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel?.text = option.title
    
    var player: OOOoyalaPlayer!
    if option.embedTokenGenerator != nil {
      if option.embedTokenGenerator is BasicEmbedTokenGenerator {
        let basicEmbedTokenGen = option.embedTokenGenerator as! BasicEmbedTokenGenerator
        apiKey = basicEmbedTokenGen.apiKey
        apiSecret = basicEmbedTokenGen.apiSecret
      }
      else {
        // If you're not using the BasicEmbedTokenGenerator provided in the example,
        // supply your own API_KEY and API_SECRET
        apiKey = "API_KEY"
        apiSecret = "API_SECRET"
      }
      let options = OOOptions()!
      // For this example, we use the OOEmbededSecureURLGenerator to create the signed URL on the client
      // This is not how this should be implemented in production -
      // In production, you should implement your own OOSecureURLGenerator
      // which contacts a server of your own, which will help sign the url with the appropriate API Key and Secret
      options.secureURLGenerator = OOEmbeddedSecureURLGenerator(apiKey: apiKey,
                                                                 secret: apiSecret)
      player = OOOoyalaPlayer(pcode: option.pcode,
                              domain: option.domain,
                              embedTokenGenerator: option.embedTokenGenerator,
                              options: options)

    }
    else {
      player = OOOoyalaPlayer(pcode: option.pcode,
                              domain: option.domain)
    }
    
    let jsCodeLocation = Bundle.main.url(forResource: "main",
                                         withExtension: "jsbundle")
    
    let skinOptions = OOSkinOptions(discoveryOptions: nil,
                                    jsCodeLocation: jsCodeLocation,
                                    configFileName: "skin",
                                    overrideConfigs: nil)
    
    ooyalaPlayerViewController = OOSkinViewController(player: player,
                                                      skinOptions: skinOptions,
                                                      parent: playerView,
                                                      launchOptions: nil)!
    
    ooyalaPlayerViewController.willMove(toParentViewController: self)
    addChildViewController(ooyalaPlayerViewController)
    ooyalaPlayerViewController.view.frame = playerView.bounds
    ooyalaPlayerViewController.didMove(toParentViewController: self)
    
    updateUI(usingState: AssetPersistenceManager.shared.downloadState(forEmbedCode: option.embedCode))
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Become an observer for the AssetPersistenceStateChangedNotification notification.
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(handleAssetStateChanged(_:)),
                                           name: AssetPersistenceStateChangedNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(handleProgressChanged(_:)),
                                           name: AssetDownloadProgressNotification,
                                           object: nil)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // Remove this class as an observer.
    NotificationCenter.default.removeObserver(self)
  }
  
  public func setOption(_ option: PlayerSelectionOption) {
    self.option = option
  }
  
  private func updateUI(usingState state: AssetPersistenceState) {
    switch state {
    case .assetNotDownloaded:
      stateLabel.text = "State: Not Downloaded"
      playOfflineButton.isEnabled = false
    case .assetAuthorizing:
      stateLabel.text = "State: Authorizing"
      playOfflineButton.isEnabled = false
    case .assetDownloading:
      stateLabel.text = "State: Downloading"
      playOfflineButton.isEnabled = false
    case .assetPaused:
      stateLabel.text = "State: Paused"
      playOfflineButton.isEnabled = false
    case .assetInQueue:
      stateLabel.text = "State: In Queue"
      playOfflineButton.isEnabled = false
    case .assetFailed:
      stateLabel.text = "State: Download Failed"
      playOfflineButton.isEnabled = false
    case .assetDownloaded:
      stateLabel.text = "State: Downloaded"
      playOfflineButton.isEnabled = true
    }
  }
  
  @objc
  private func handleAssetStateChanged(_ notification: Notification) {
    let embedCode = notification.userInfo![AssetNameKey] as! String
    let state = notification.userInfo![AssetStateKey] as! AssetPersistenceState
    
    // update the UI only if it is the correct embed code.
    if (embedCode == option.embedCode && state != AssetPersistenceState.assetDownloading) {
      DispatchQueue.main.async(execute: {() -> Void in
        self.updateUI(usingState: state)
      })
    }
  }

  @objc
  private func handleProgressChanged(_ notification: Notification) {
    let embedCode = notification.userInfo![AssetNameKey] as! String
    let state = AssetPersistenceManager.shared.downloadState(forEmbedCode: embedCode)

    // update the UI only if it is the correct embed code.
    if (embedCode == option.embedCode && state == AssetPersistenceState.assetDownloading) {
      DispatchQueue.main.async(execute: {() -> Void in
        let percentage = notification.userInfo![AssetProgressKey] as! NSNumber
        self.stateLabel?.text = String(format: "State: Downloading (%.0f%%)", Float(truncating: percentage) * 100)
      })
    }
  }
  
  @IBAction func playOnline() {
    ooyalaPlayerViewController.player.setEmbedCode(option.embedCode)
    ooyalaPlayerViewController.player.play()
  }
  
  @IBAction func playOffline() {
    let video = AssetPersistenceManager.shared.video(forEmbedCode: option.embedCode)
    ooyalaPlayerViewController.player.setUnbundledVideo(video)
    ooyalaPlayerViewController.player.play()
  }
  
  deinit {
    print("<PlayerViewController> has been destroyed.")
  }
  
}
