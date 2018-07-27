//
//  PlayerViewController.swift
//  OoyalaSSAISampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

  private var alertController: UIAlertController?
  
  @IBOutlet weak var playerView: UIView!
  
  @IBOutlet weak var btnSetPlayerParams: MyButton!
  @IBOutlet weak var txtViewPlayerParams: MyTextView!
  @IBOutlet weak var txtViewLog: MyTextView!
  
  public var option: PlayerSelectionOption!
  public var usesSkin: Bool!
  public var qaLogEnabled: Bool!
  
  private var player: OOOoyalaPlayer!
  
  // properties required for a Fairplay asset
  private var apiKey = ""
  private var apiSecret = ""
  
  private var ssaiPlugin: OOSsaiPlugin!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = option.title
    qaEnabled()
    
    var ooyalaPlayerViewController: UIViewController
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
    
    if usesSkin {
      let jsCodeLocation = Bundle.main.url(forResource: "main", withExtension: "jsbundle")
      
      let overrideConfigs = ["adScreen" : ["showControlBar":true]];
      
      let skinOptions = OOSkinOptions(discoveryOptions: nil,
                                      jsCodeLocation: jsCodeLocation,
                                      configFileName: "skin",
                                      overrideConfigs: overrideConfigs)
      
      ooyalaPlayerViewController = OOSkinViewController(player: player,
                                                        skinOptions: skinOptions,
                                                        parent: playerView,
                                                        launchOptions: nil)
    }
    else {
      ooyalaPlayerViewController = OOOoyalaPlayerViewController(player: player)
    }
    
    player.setEmbedCode(option.embedCode)
    
    addChildViewController(ooyalaPlayerViewController)
    playerView.addSubview(ooyalaPlayerViewController.view)
    ooyalaPlayerViewController.view.frame = playerView.bounds
    
    // Ooyala SSAI Plugin
    ssaiPlugin = OOSsaiPlugin()
    ssaiPlugin.register(player)
    
    if qaLogEnabled {
      
      let filePath = Bundle.main.url(forResource: option.adSetProvider, withExtension: "json")!
      txtViewPlayerParams.text = try! String(contentsOf: filePath)
      
      NotificationCenter.default.addObserver(self,
                                             selector: #selector(notificationHandler(notification:)),
                                             name: nil,
                                             object: player)
      
    }
  }
  
  // MARK: - QA Log
  @objc
  private func notificationHandler(notification: NSNotification) {
    if ( notification.name == NSNotification.Name.OOOoyalaPlayerTimeChanged ){
      return;
    }
    let message = "Notification Received: \(notification.name.rawValue). state: \(OOOoyalaPlayer.playerState(toString: player.state())!). playhead: \(String(format: "%.2f", player.playheadTime()))"
    txtViewLog.text  = "\(message)\n\(txtViewLog.text!)"
  }
  
  // MARK: - SSAI Plugin
  @objc
  private func setPlayerParams() {
    let params = txtViewPlayerParams.text
    if ( ssaiPlugin.setParams(params) && ssaiPlugin.player().state != .playing ){
      player.setEmbedCode(option.embedCode)
    }
    else {
      if ssaiPlugin.player().state == .playing {
        showAlertMsg(title: "OoyalaSSAISampleApp",
                     message: "Player Params cannot be set while AD is playing.",
                     time: 1)
      }
      else {
        showAlertMsg(title: "OoyalaSSAISampleApp",
                     message: "The format of the player params is not a valid json.",
                     time: 1)
      }
      
    }
  }
  
  // MARK: - Utils
  private func qaEnabled() {
    if qaLogEnabled {
      btnSetPlayerParams.addTarget(self, action: #selector(setPlayerParams), for: .touchUpInside)
    }
    else {
      let navigationBarHeight = (navigationController?.navigationBar.frame.size.height)! + (navigationController?.navigationBar.frame.origin.y)!
      playerView.frame = CGRect(x: 0,
                                y: navigationBarHeight,
                                width: view.frame.width,
                                height: view.frame.height - navigationBarHeight)
      btnSetPlayerParams.isHidden = true
      txtViewPlayerParams.isHidden = true
      txtViewLog.isHidden = true
    }
  }
  
  private func showAlertMsg(title: String, message: String, time: Int) {
    guard (alertController == nil) else {
      return
    }
    alertController = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .cancel) { (action) in
                                      self.alertController = nil;
    }
    alertController!.addAction(cancelAction)
    present(alertController!, animated: true, completion: nil)
  }
  
  // MARK: - Denit
  deinit {
    if qaLogEnabled {
      NotificationCenter.default.removeObserver(self)
    }
    ssaiPlugin.deregister(player)
    print("PlayerViewController: Deinit complete.")
  }
  
}
