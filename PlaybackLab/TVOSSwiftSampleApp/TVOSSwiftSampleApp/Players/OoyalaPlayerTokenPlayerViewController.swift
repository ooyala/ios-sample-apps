//
//  OoyalaPlayerTokenPlayerViewController.swift
//  TVOSSwiftSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import Foundation

class OoyalaPlayerTokenPlayerViewController: OOOoyalaTVPlayerViewController, OOEmbedTokenGenerator {
  
  var option: PlayerSelectionOption!
  /*
   * The API Key and Secret should not be saved inside your applciation (even in git!).
   * However, for debugging you can use them to locally generate Ooyala Player Tokens.
   */
  private var authorizeHost = "http://player.ooyala.com"
  private var apiKey = "Fill me in"
  private var secret = "Fill me in"
  private var accountId = "Fill me in"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    player = OOOoyalaPlayer(pcode: option.pcode, domain: OOPlayerDomain(string: option.domain), embedTokenGenerator: self)
    player.setEmbedCode(option.embedCode)
    player.play()
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
