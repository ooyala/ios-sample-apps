//
//  VideoViewController.swift
//  ControlsLockScreenSampleApp
//
//  Created by Carlos Ceja on 10/18/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class VideoViewController: OOOoyalaPlayerViewController {
  
  @IBOutlet weak var playerView: UIView!
  
  // properties for the video to be played
  private var option: PlayerSelectionOption!
  
  // properties required for a Fairplay asset
  private var apiKey: String?
  private var apiSecret: String?
  
  internal static func instantiate(with option: PlayerSelectionOption) -> VideoViewController {
    let vc: VideoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VideoViewController") as! VideoViewController
    vc.option = option
    return vc
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = option.getTitle()
    
    if option.getEmbedTokenGenerator() != nil {
      if option.getEmbedTokenGenerator() is BasicEmbedTokenGenerator {
        // If you're using the BasicEmbedTokenGenerator we provided in this sample app, this block will be called.
        // check the OptionsDataSource class to see how we define the assets for the app and how we add a reference to a BasicEmbedTokenGenerator to a given asset.
        let basicEmbedTokenGen: BasicEmbedTokenGenerator = option.getEmbedTokenGenerator() as! BasicEmbedTokenGenerator
        apiKey = basicEmbedTokenGen.getApiKey()
        apiSecret = basicEmbedTokenGen.getApiSecret()
      }
      else {
        // If you're not using the BasicEmbedTokenGenerator provided in the example, supply your own API_KEY and API_SECRET
        apiKey = "API_KEY"
        apiSecret = "API_SECRET"
      }
      
      let options: OOOptions = OOOptions()!
      // For this example, we use the OOEmbededSecureURLGenerator to create the signed URL on the client
      // This is not how this should be implemented in production - In production, you should implement your own OOSecureURLGenerator
      // which contacts a server of your own, which will help sign the url with the appropriate API Key and Secret
      options.secureURLGenerator = OOEmbeddedSecureURLGenerator(apiKey: apiKey, secret: apiSecret)!
      
      player = OOOoyalaPlayer(pcode: option.getPcode(), domain: option.getDomain(), embedTokenGenerator: option.getEmbedTokenGenerator()!, options: options)
    }
    else {
      player = OOOoyalaPlayer(pcode: option.getPcode(), domain: option.getDomain())
    }
    
    player.setEmbedCode(option.getEmbedCode())
    
    let remoteCommandCenter: MPRemoteCommandCenter = MPRemoteCommandCenter.shared()
    remoteCommandCenter.playCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
      self.player.play()
      self.updateControlCenter()
      return MPRemoteCommandHandlerStatus.success
    }
    
    remoteCommandCenter.pauseCommand.addTarget(handler: { (event) -> MPRemoteCommandHandlerStatus in
      self.player.pause()
      self.updateControlCenter()
      return MPRemoteCommandHandlerStatus.success
    })
    
    remoteCommandCenter.skipForwardCommand.preferredIntervals = [15]
    remoteCommandCenter.skipForwardCommand.addTarget(handler: { (event) -> MPRemoteCommandHandlerStatus in
      self.player.seek(self.player.playheadTime() + 15.0)
      return MPRemoteCommandHandlerStatus.success
    })
    
    remoteCommandCenter.skipBackwardCommand.preferredIntervals = [15]
    remoteCommandCenter.skipBackwardCommand.addTarget(handler: { (event) -> MPRemoteCommandHandlerStatus in
      self.player.seek(self.player.playheadTime() - 15.0)
      return MPRemoteCommandHandlerStatus.success
    })
    
    // Set properties of the asset.
    var nowPlayingInfo: [String : Any] = [MPMediaItemPropertyTitle: option.getTitle(),
                                          MPMediaItemPropertyArtist: "Ooyala",
                                          MPMediaItemPropertyAlbumTitle: "Controls Lock Screen"
    ]
    
    // Set albumArt to show in the screen if image is available
    if let imageData: NSData = NSData(contentsOf: option.getThumbnailURL()), let image: UIImage = UIImage(data: imageData as Data) {
      let albumArt: MPMediaItemArtwork = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { (size) -> UIImage in return image })
      nowPlayingInfo[MPMediaItemPropertyArtwork] = albumArt
    }
    
    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    
    NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(_:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(playerStateChange(_:)), name: NSNotification.Name.OOOoyalaPlayerStateChanged, object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    UIApplication.shared.beginReceivingRemoteControlEvents()
    becomeFirstResponder()
    
    player.play()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    UIApplication.shared.endReceivingRemoteControlEvents()
    resignFirstResponder()
    player.destroy()
    NotificationCenter.default.removeObserver(self)
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  @objc
  func applicationDidEnterBackground(_ notification: Notification) {
    player.perform(#selector(player.play as () -> Void), with: nil, with: 0.01)
  }
  
  @objc
  func playerStateChange(_ notification: Notification) {
    updateControlCenter()
  }
  
  func updateControlCenter() {
    let playingInfoCenter: MPNowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    if var displayInfo = playingInfoCenter.nowPlayingInfo {
      displayInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1
      displayInfo[MPMediaItemPropertyPlaybackDuration] = player.duration()
      displayInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.playheadTime()
      playingInfoCenter.nowPlayingInfo = displayInfo
    }
  }
}
