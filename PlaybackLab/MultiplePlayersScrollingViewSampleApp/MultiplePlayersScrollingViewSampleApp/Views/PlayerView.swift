//
//  PlayerView.swift
//  MultiplePlayersScrollingViewSampleApp
//
//  Copyright © 2019 Ooyala. All rights reserved.
//

import UIKit

class PlayerView: UIView {
  
  let kCONTENT_XIB_NAME = "PlayerView"
  
  var currentOrientation: UIDeviceOrientation!
  
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var videoView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  
  // properties required for a Fairplay asset
  private var apiKey: String?
  private var apiSecret: String?
  
  private var playerSelectionOption: PlayerSelectionOption!
  public private(set) var skinController: OOSkinViewController!
  
  init(playerSelectionOption: PlayerSelectionOption) {
    self.playerSelectionOption = playerSelectionOption
    super.init(frame: CGRect.zero)
    Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
    
    currentOrientation = UIDevice.current.orientation
    
    videoView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = videoView.frame.maxY + 50
    
    frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
    
    addSubview(contentView)
    contentView.frame = bounds
    contentView.translatesAutoresizingMaskIntoConstraints = true
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    initPlayer()
    addObservers()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(coder: aDecoder)
  }
  
  private func initPlayer() {
    var player: OOOoyalaPlayer!
    if playerSelectionOption.embedTokenGenerator != nil {
      if let basicEmbedTokenGenerator = playerSelectionOption.embedTokenGenerator as? BasicEmbedTokenGenerator {
        apiKey = basicEmbedTokenGenerator.apiKey
        apiSecret = basicEmbedTokenGenerator.apiSecret
      } else {
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
      
      player = OOOoyalaPlayer(pcode: playerSelectionOption.pcode,
                              domain: playerSelectionOption.domain,
                              embedTokenGenerator: playerSelectionOption.embedTokenGenerator,
                              options: options)
    } else {
      player = OOOoyalaPlayer(pcode: playerSelectionOption.pcode,
                              domain: playerSelectionOption.domain)
    }
    
    let jsCodeLocation = Bundle.main.url(forResource: "main",
                                         withExtension: "jsbundle")!
    
    let skinOptions = OOSkinOptions(discoveryOptions: nil,
                                    jsCodeLocation: jsCodeLocation,
                                    configFileName: "skin",
                                    overrideConfigs: nil)
    
    skinController = OOSkinViewController(player: player,
                                          skinOptions: skinOptions,
                                          parent: videoView)
  }
  
  private func addObservers() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(setAssetInfo),
                                           name: Notification.Name.OOOoyalaPlayerCurrentItemChanged,
                                           object: skinController.player)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(rotated(_:)),
                                           name: UIDevice.orientationDidChangeNotification,
                                           object: UIDevice.current)
  }
  
  @objc
  private func setAssetInfo() {
    DispatchQueue.main.async { [weak self] in
      self?.titleLabel.text = self?.skinController.player.currentItem.title
    }
  }
  
  @objc
  private func rotated(_ notification: Notification) {
    let fullScreen = UIDevice.current.orientation.isLandscape
    skinController.isFullscreen = fullScreen
  }
  
}
