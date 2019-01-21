//
//  FairplayPlayerViewController.swift
//  TVOSSwiftSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import Foundation

class FairplayPlayerViewController: OOOoyalaTVPlayerViewController, OOEmbedTokenGenerator {
  
  var option: PlayerSelectionOption!
  // You need to fill the following params
  private var authorizeHost = "http://player.ooyala.com"
  private var apiKey = "Fill me in"
  private var secret = "Fill me in"
  private var accountId = "Fill me in"
  
  override func viewDidLoad() {
    super.viewDidLoad()

    OODebugMode.setDebugMode(DebugMode.LogAndAbort)
    assert(apiKey.contains(option.pcode), "pcode must be the long prefix of apiKey.")
    
    let options = OOOptions()
    
    // For this example, we use the OOEmbededSecureURLGenerator to create the signed URL on the client
    // This is not how this should be implemented in production - In production, you should implement your own OOSecureURLGenerator
    //   which contacts a server of your own, which will help sign the url with the appropriate API Key and Secret
    options?.secureURLGenerator = OOEmbeddedSecureURLGenerator(apiKey: apiKey, secret: secret)
    
    player = OOOoyalaPlayer(pcode: option.pcode, domain: OOPlayerDomain(string: option.domain), embedTokenGenerator: self, options: options)
    
    NotificationCenter.default.addObserver(self, selector: #selector(notificationHandler(_:)), name: nil, object: player)
    
    player.setEmbedCode(option.embedCode)
    player.play()
  }
  
  @objc func notificationHandler(_ notification: Notification) {
    let name = notification.name
    if name == NSNotification.Name.OOOoyalaPlayerTimeChanged {
      return
    }
    
    NSLog("Notification Received: %@. state: %@. playhead: %f", name.rawValue, OOOoyalaPlayer.playerState(toString: player.state()), player.playheadTime())
  }
  
  func token(forEmbedCodes embedCodes: [Any]!, callback: OOEmbedTokenCallback!) {
    var params: [String: Any] = [:]
    
    params["account_id"] = accountId

    guard let embedCodes = embedCodes as? [String] else { return }
    let uri = String(format: "/sas/embed_token/%@/%@", option.pcode, embedCodes.joined(separator: ","))
    
    let urlGen = OOEmbeddedSecureURLGenerator(apiKey: apiKey, secret: secret)
    let embedTokenUrl = urlGen?.secureURL(authorizeHost, uri: uri, params: params)
    callback(embedTokenUrl?.absoluteString)
  }
}
