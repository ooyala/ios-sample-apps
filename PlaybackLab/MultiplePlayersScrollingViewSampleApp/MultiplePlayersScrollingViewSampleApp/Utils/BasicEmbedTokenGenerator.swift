//
//  BasicEmbedTokenGenerator.swift
//  MultiplePlayersScrollingViewSampleApp
//
//  Copyright © 2019 Ooyala. All rights reserved.
//

import UIKit

class BasicEmbedTokenGenerator: NSObject, OOEmbedTokenGenerator {

  public private(set) var pcode: String
  
  public private(set) var apiKey: String
  
  public private(set) var apiSecret: String
  
  public private(set) var accountId: String
  
  public private(set) var authorizeHost: String
  
  init(pcode: String, apiKey: String, apiSecret: String, accountId: String, authorizeHost: String) {
    self.pcode = pcode
    self.apiKey = apiKey
    self.apiSecret = apiSecret
    self.accountId = accountId
    self.authorizeHost = authorizeHost
    super.init()
  }
  
  func token(forEmbedCodes embedCodes: [Any]!, callback: OOEmbedTokenCallback!) {
    var params = [AnyHashable: Any]()
    params["account_id"] = accountId
    
    let uri = "/sas/embed_token/\(pcode)/\((embedCodes as! [String]).joined(separator: ","))"
    // You should not be using OOEmbeddedSecureURLGenerator in your own app.
    // We recommend generating this URL in a remote server you own, as we discourage storing apiKey and apiSecret information within the app because of security concerns.
    
    let urlGen = OOEmbeddedSecureURLGenerator(apiKey: apiKey, secret: apiSecret)!
    let embedTokenUrl = urlGen.secureURL(authorizeHost, uri: uri, params: params)!
    
    callback(embedTokenUrl.absoluteString)
  }
  
}
