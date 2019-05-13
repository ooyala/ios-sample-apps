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

  func token(forEmbedCodes embedCodes: [String],
             callback: @escaping OOEmbedTokenCallback) {
    let params = ["account_id": accountId]

    let uri = "/sas/embed_token/\(pcode)/\(embedCodes.joined(separator: ","))"
    // You should not be using OOEmbeddedSecureURLGenerator in your own app.
    // We recommend generating this URL in a remote server you own, as we discourage storing apiKey and apiSecret information within the app because of security concerns.

    let urlGen = OOEmbeddedSecureURLGenerator(apiKey: apiKey, secret: apiSecret)
    guard let embedTokenUrl = urlGen.secureURL(forHost: authorizeHost,
                                               uri: uri,
                                               params: params) else {
                                                return callback(nil)
    }

    callback(embedTokenUrl.absoluteString)
  }
}
