//
//  BasicEmbedTokenGenerator.swift
//  ControlsLockScreenSampleApp
//
//  Created by Carlos Ceja on 10/18/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

import UIKit

class BasicEmbedTokenGenerator: NSObject, OOEmbedTokenGenerator {
  
  private var pcode: String
  
  private var apiKey: String
  
  private var apiSecret: String
  
  private var accountId: String
  
  private var authorizeHost: String
  
  init(pcode: String, apiKey: String, apiSecret: String, accountId: String, authorizeHost: String) {
    self.pcode = pcode
    self.apiKey = apiKey
    self.apiSecret = apiSecret
    self.accountId = accountId
    self.authorizeHost = authorizeHost
    super.init()
  }
  
  func getApiKey() -> String {
    return apiKey
  }
  
  func getApiSecret() -> String {
    return apiSecret
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
