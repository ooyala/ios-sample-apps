//
//  PlayerViewController.swift
//  ControlsLockScreenSampleApp
//
//  Copyright © 2017 Ooyala. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

//now ViewController initializated from I.B.
class PlayerViewController: UIViewController {
  
  // MARK: - Private properties
  // properties for the video
  public var option: PlayerSelectionOption!
  
  private var ooyalaPlayerVC: OOOoyalaPlayerViewController?
  
  // remote control center
  private let remoteCommandCenter = MPRemoteCommandCenter.shared()
  
  // MARK: - View controller lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = option.title
    
    setupOoyalaPlayerStuff()
    
    if let playerVC = ooyalaPlayerVC {
      addPlayerViewController(vc: playerVC)
    }
    
    addObservers()
    setupCommandCenter()
    setupPlayingInfoCenter()

    ooyalaPlayerVC?.player.play()
  }
  
  // MARK: - Private methods
  private func addPlayerViewController(vc: UIViewController) {
    vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.addChild(vc)
    view.addSubview(vc.view)
    
    vc.view.translatesAutoresizingMaskIntoConstraints = false
    
    // Add constraints
    let marginsGuide = vc.view?.layoutMarginsGuide
    guard let margins = marginsGuide else { return }
    NSLayoutConstraint.activate([
      view.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
    ])
    guard let view = vc.view else { return }
    if #available(iOS 11, *) {
      let guide = self.view.safeAreaLayoutGuide
      NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: guide.topAnchor),
        guide.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
    } else {
      NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
        bottomLayoutGuide.topAnchor.constraint(equalTo: view.bottomAnchor)
      ])
    }
  }
  
  private func setupOoyalaPlayerStuff() {
    var player: OOOoyalaPlayer
    // properties required for a Fairplay asset
    var apiKey: String
    var apiSecret: String

    if let embedTokenGenerator = option.embedTokenGenerator {
      if let basicEmbedTokenGenerator = embedTokenGenerator as? BasicEmbedTokenGenerator {
        apiKey = basicEmbedTokenGenerator.apiKey
        apiSecret = basicEmbedTokenGenerator.apiSecret
      } else {
        apiKey = "API_KEY"
        apiSecret = "API_SECRET"
      }
      
      let options = OOOptions()
      // For this example, we use the OOEmbededSecureURLGenerator to create the signed URL on the client
      // This is not how this should be implemented in production - In production, you should implement your own OOSecureURLGenerator
      // which contacts a server of your own, which will help sign the url with the appropriate API Key and Secret
      options.secureURLGenerator = OOEmbeddedSecureURLGenerator(apiKey: apiKey,
                                                                secret: apiSecret)
      options.backgroundMode = .allowed
      player = OOOoyalaPlayer(pcode: option.pcode,
                              domain: option.domain,
                              embedTokenGenerator: embedTokenGenerator,
                              options: options)
    } else {
      let options = OOOptions()
      options.backgroundMode = .allowed
      player = OOOoyalaPlayer(pcode: option.pcode,
                              domain: option.domain,
                              options: options)
    }

    ooyalaPlayerVC = OOOoyalaPlayerViewController(player: player)
    ooyalaPlayerVC?.player.setEmbedCode(option.embedCode)
  }
  
  private func addObservers() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(playerStateChange(_:)),
                                           name: NSNotification.Name.OOOoyalaPlayerStateChanged,
                                           object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(notificationHandler(_:)),
                                           name: nil,
                                           object: ooyalaPlayerVC?.player)
  }
  
  private func setupCommandCenter() {
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
  
  private func setupPlayingInfoCenter() {
    // Set properties of the asset to be shown in the screen (no required).
    var nowPlayingInfo: [String: Any] = [MPMediaItemPropertyTitle: option.title,
                                         MPMediaItemPropertyArtist: "Ooyala",
                                         MPMediaItemPropertyAlbumTitle: "Controls Lock Screen"
    ]
    
    // Set albumArt to show in the screen if image is available
    // The albumArt needs to be an UIImage, the image can be added in the assets of the project or retrieve the image using an URL
    if let imageData = NSData(contentsOf: option.thumbnailURL), let image = UIImage(data: imageData as Data) {
      let albumArt = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { (size) -> UIImage in return image })
      nowPlayingInfo[MPMediaItemPropertyArtwork] = albumArt
    }
    
    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
  }
  
  // Updates the time labels.
  public func updatePlayingInfoCenter() {
    let playingInfoCenter = MPNowPlayingInfoCenter.default()
    guard var displayInfo = playingInfoCenter.nowPlayingInfo,
      let player = ooyalaPlayerVC?.player else { return }
    displayInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.isPlaying() ? 1 : 0
    displayInfo[MPMediaItemPropertyPlaybackDuration] = player.duration()
    displayInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.playheadTime()
    playingInfoCenter.nowPlayingInfo = displayInfo
  }
  
  // MARK: - Custom selectors
  @objc func playPauseCommand(_ sender: MPRemoteCommandEvent) {
    guard let player = ooyalaPlayerVC?.player else { return }
    if player.isPlaying() {
      player.pause()
    } else {
      player.playFromBackground()
    }
    updatePlayingInfoCenter()
  }
  
  @objc func skipBackwardCommand(_ sender: MPSkipIntervalCommandEvent) {
    guard let player = ooyalaPlayerVC?.player else { return }
    
    player.seek(player.playheadTime() - sender.interval)
    player.play()
    updatePlayingInfoCenter()
  }
  
  @objc func skipForwardCommand(_ sender: MPSkipIntervalCommandEvent) {
    guard let player = ooyalaPlayerVC?.player else { return }
    
    player.seek(player.playheadTime() + sender.interval)
    player.play()
    updatePlayingInfoCenter()
  }
  
  @objc func changePlaybackPositionCommand(_ sender: MPChangePlaybackPositionCommandEvent) {
    guard let player = ooyalaPlayerVC?.player else { return }
    
    player.seek(sender.positionTime)
    player.play()
    updatePlayingInfoCenter()
  }
  
  @objc func playerStateChange(_ notification: Notification) {
    updatePlayingInfoCenter()
  }
  
  @objc func notificationHandler(_ notification: Notification)  {
    // Ignore TimeChangedNotificiations for shorter logs
    if notification.name == NSNotification.Name.OOOoyalaPlayerTimeChanged { return }
    guard let player = ooyalaPlayerVC?.player,
          let stringState = OOOoyalaPlayerStateConverter.playerState(toString: player.state) else { return }
    print("PlayerVC Notification Received: \(notification.name.rawValue), state: \(stringState), playhead: \(player.playheadTime())")
  }
  
  // MARK: - Initialization
  deinit {
    // Remove observers, targets and destroy the player.
    remoteCommandCenter.playCommand.removeTarget(self)
    remoteCommandCenter.pauseCommand.removeTarget(self)
    remoteCommandCenter.skipBackwardCommand.removeTarget(self)
    remoteCommandCenter.skipForwardCommand.removeTarget(self)
    remoteCommandCenter.changePlaybackPositionCommand.removeTarget(self)
    ooyalaPlayerVC?.player.destroy()
    print("PlayerViewController is destroyed")
  }
  
}
