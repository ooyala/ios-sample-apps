//
//  PlayerViewController.swift
//  DownloadToOwnSampleAppSwift
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

  var dtoAsset: OODtoAsset!
  
  // properties required for a Fairplay asset
  private var apiKey = ""
  private var apiSecret = ""
  
  private var ooyalaPlayerViewController: OOSkinViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    var player: OOOoyalaPlayer!

    if dtoAsset.options.embedTokenGenerator != nil {
      if let basicEmbedTokenGen = dtoAsset.options.embedTokenGenerator as? BasicEmbedTokenGenerator {
        apiKey = basicEmbedTokenGen.apiKey
        apiSecret = basicEmbedTokenGen.apiSecret
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
      player = OOOoyalaPlayer(pcode: self.dtoAsset.options.pcode,
                              domain: self.dtoAsset.options.domain,
                              embedTokenGenerator: dtoAsset.options.embedTokenGenerator,
                              options: options)

    } else {
      player = OOOoyalaPlayer(pcode: self.dtoAsset.options.pcode,
                              domain: self.dtoAsset.options.domain)
    }
    
    guard let jsCodeLocation = Bundle.main.url(forResource: "main",
                                               withExtension: "jsbundle") else { return }
    
    let skinOptions = OOSkinOptions(discoveryOptions: nil,
                                    jsCodeLocation: jsCodeLocation,
                                    configFileName: "skin")
    
    ooyalaPlayerViewController = OOSkinViewController(player: player,
                                                      skinOptions: skinOptions,
                                                      parent: playerView,
                                                      launchOptions: nil)
    
    ooyalaPlayerViewController.willMove(toParent: self)
    addChild(ooyalaPlayerViewController)
    ooyalaPlayerViewController.view.frame = playerView.bounds
    ooyalaPlayerViewController.didMove(toParent: self)

    titleLabel.text = dtoAsset.name
    stateLabel.text = dtoAsset.stateText
    playOfflineButton.isEnabled = dtoAsset.state == .downloaded

    // We're setting progress and finish closures for the given OODtoAsset in order to represent state
    dtoAsset.progress { [weak self] progress in
      DispatchQueue.main.async {
        self?.stateLabel.text = "\(self?.dtoAsset.stateText ?? "") \(progress * 100)"
      }
    }
    dtoAsset.finish { [weak self] relativePath in
      DispatchQueue.main.async {
        self?.stateLabel.text = self?.dtoAsset.stateText ?? ""
        self?.playOfflineButton.isEnabled = true
      }
    }
    dtoAsset.onErrorWithErrorClosure { [weak self] error in
      DispatchQueue.main.async {
        self?.stateLabel.text = self?.dtoAsset.stateText ?? ""
        self?.playOfflineButton.isEnabled = false
      }
    }
  }

  @IBAction func playOnline() {
    ooyalaPlayerViewController.player.setEmbedCode(self.dtoAsset.embedCode)
    ooyalaPlayerViewController.player.play()
  }
  
  @IBAction func playOffline() {
    guard let video = dtoAsset.offlineVideo else { return }
    ooyalaPlayerViewController.player.setUnbundledVideo(video)
    ooyalaPlayerViewController.player.play()
  }
  
  deinit {
    print("<PlayerViewController> has been destroyed.")
  }
  
}
