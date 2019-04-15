//
//  BasicEmbedTokenGenerator.swift
//  DownloadToOwnSampleAppSwift
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import Foundation

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
    let params = ["account_id": accountId]

    guard let embedCodesArray = embedCodes as? [String] else {
      return callback(nil)
    }
    
    let uri = "/sas/embed_token/\(pcode)/\(embedCodesArray.joined(separator: ","))"
    // You should not be using OOEmbeddedSecureURLGenerator in your own app.
    // We recommend generating this URL in a remote server you own, as we discourage storing apiKey and apiSecret information within the app because of security concerns.
    
    let urlGen = OOEmbeddedSecureURLGenerator(apiKey: apiKey, secret: apiSecret)!
    let embedTokenUrl = urlGen.secureURL(authorizeHost, uri: uri, params: params)!
    
    callback(embedTokenUrl.absoluteString)
  }
  
}
