//
//  PlayerViewController.swift
//  ControlsLockScreenSampleApp
//
//  Copyright © 2017 Ooyala. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class PlayerViewController: OOOoyalaPlayerViewController {
    
  // properties for the video
  public var option: PlayerSelectionOption!
  
  // properties required for a Fairplay asset
  private var apiKey: String?
  private var apiSecret: String?
  
  // remote control center
  private let remoteCommandCenter: MPRemoteCommandCenter = MPRemoteCommandCenter.shared()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.title = option.title
    
    if option.embedTokenGenerator != nil {
      if let embedTokenGen = option.embedTokenGenerator as? BasicEmbedTokenGenerator {
        apiKey = embedTokenGen.apiKey
        apiSecret = embedTokenGen.apiSecret
      }
      else {
        apiKey = "API_KEY"
        apiSecret = "API_SECRET"
      }
      
      let options: OOOptions = OOOptions()!
      // For this example, we use the OOEmbededSecureURLGenerator to create the signed URL on the client
      // This is not how this should be implemented in production - In production, you should implement your own OOSecureURLGenerator
      // which contacts a server of your own, which will help sign the url with the appropriate API Key and Secret
      options.secureURLGenerator = OOEmbeddedSecureURLGenerator(apiKey: apiKey, secret: apiSecret)!
      player = OOOoyalaPlayer(pcode: option.pcode, domain: option.domain, embedTokenGenerator: option.embedTokenGenerator!, options: options)
    }
    else {
      player = OOOoyalaPlayer(pcode: option.pcode, domain: option.domain)
    }
    player.setEmbedCode(option.embedCode)
    
    addObservers()
    setupCommandCenter()
    setupPlayingInfoCenter()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    player.play()
  }
  
  func addObservers() {
    NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(_:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(playerStateChange(_:)), name: NSNotification.Name.OOOoyalaPlayerStateChanged, object: nil)
  }
  
  func setupCommandCenter() {
    remoteCommandCenter.playCommand.isEnabled = true
    remoteCommandCenter.playCommand.addTarget(self, action: #selector(playPauseCommand))
    
    remoteCommandCenter.pauseCommand.isEnabled = true
    remoteCommandCenter.pauseCommand.addTarget(self, action: #selector(playPauseCommand))
    
    remoteCommandCenter.skipBackwardCommand.isEnabled = true
    remoteCommandCenter.skipBackwardCommand.preferredIntervals = [15]
    remoteCommandCenter.skipBackwardCommand.addTarget(self, action: #selector(skipBackwardCommand(_:)))
    
    remoteCommandCenter.skipForwardCommand.isEnabled = true
    remoteCommandCenter.skipForwardCommand.preferredIntervals = [15]
    remoteCommandCenter.skipForwardCommand.addTarget(self, action: #selector(skipForwardCommand(_:)))
    
    remoteCommandCenter.changePlaybackPositionCommand.isEnabled = true
    remoteCommandCenter.changePlaybackPositionCommand.addTarget(self, action: #selector(changePlaybackPositionCommand(_:)))
  }
  
  func setupPlayingInfoCenter() {
    // Set properties of the asset to be shown in the screen (no required).
    var nowPlayingInfo: [String: Any] = [MPMediaItemPropertyTitle: option.title,
                                         MPMediaItemPropertyArtist: "Ooyala",
                                         MPMediaItemPropertyAlbumTitle: "Controls Lock Screen"
    ]
    
    // Set albumArt to show in the screen if image is available
    // The albumArt needs to be an UIImage, the image can be added in the assets of the project or retrieve the image using an URL
    if let imageData: NSData = NSData(contentsOf: option.thumbnailURL), let image: UIImage = UIImage(data: imageData as Data) {
      let albumArt: MPMediaItemArtwork = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { (size) -> UIImage in return image })
      nowPlayingInfo[MPMediaItemPropertyArtwork] = albumArt
    }
    
    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
  }
  
  // Updates the time labels.
  func updatePlayingInfoCenter() {
    let playingInfoCenter: MPNowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    if var displayInfo = playingInfoCenter.nowPlayingInfo {
      displayInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.isPlaying() ? 1 : 0
      displayInfo[MPMediaItemPropertyPlaybackDuration] = player.duration()
      displayInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.playheadTime()
      playingInfoCenter.nowPlayingInfo = displayInfo
    }
  }
  
  @objc func playPauseCommand(_ sender: MPRemoteCommandEvent) {
    if player != nil {
      if player.isPlaying() {
        player.pause()
      }
      else {
        player.play()
      }
      updatePlayingInfoCenter()
    }
  }
  
  @objc func skipBackwardCommand(_ sender: MPSkipIntervalCommandEvent) {
    if player != nil {
      player.seek(player.playheadTime() - sender.interval)
      player.play()
      updatePlayingInfoCenter()
    }
  }
  
  @objc func skipForwardCommand(_ sender: MPSkipIntervalCommandEvent) {
    if player != nil {
      player.seek(player.playheadTime() + sender.interval)
      player.play()
      updatePlayingInfoCenter()
    }
  }
  
  @objc func changePlaybackPositionCommand(_ sender: MPChangePlaybackPositionCommandEvent) {
    if player != nil {
      player.seek(sender.positionTime)
      player.play()
      updatePlayingInfoCenter()
    }
  }
  
  @objc func applicationDidEnterBackground(_ notification: Notification) {
    // The app detects that is running in background, we need to call the play method twice
    // to let the AudioSession works and play the audio.
    player.perform(#selector(player.play as () -> Void))
    player.perform(#selector(player.play as () -> Void), with: nil, afterDelay: 0.1)
  }
  
  @objc func playerStateChange(_ notification: Notification) {
    updatePlayingInfoCenter()
  }
  
  deinit {
    // Remove observers, targets and destroy the player.
    NotificationCenter.default.removeObserver(self)
    remoteCommandCenter.playCommand.removeTarget(self)
    remoteCommandCenter.pauseCommand.removeTarget(self)
    remoteCommandCenter.skipBackwardCommand.removeTarget(self)
    remoteCommandCenter.skipForwardCommand.removeTarget(self)
    remoteCommandCenter.changePlaybackPositionCommand.removeTarget(self)
    player.destroy()
    print("PlayerViewController is destroyed")
  }
  
}
