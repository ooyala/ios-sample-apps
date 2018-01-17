//
//  EmbedTokenGenerator.swift
//  AssetDownloadManagerSmapleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

import Foundation


class EmbedTokenGenerator: NSObject {
  
  // MARK: - Public properties
  
  var PCODE: String!
  var accountID: String!
  var APIKey: String!
  var secretKey: String!
  var domain: String!

  // MARK: - Initialization
  
  convenience init(PCODE: String, accountID: String, APIKey: String, secretKey: String, domain: String) {
    self.init()
    
    self.PCODE     = PCODE
    self.accountID = accountID
    self.APIKey    = APIKey
    self.secretKey = secretKey
    self.domain    = domain
  }
  
  
}

// MARK: - OOEmbedTokenGenerator

extension EmbedTokenGenerator: OOEmbedTokenGenerator {
  
  func token(forEmbedCodes embedCodes: [Any]!, callback: OOEmbedTokenCallback!) {
    var params = [String : Any]()
    
    params["account_id"] = accountID!
    let uri = "/sas/embed_token/\(PCODE!)/\((embedCodes as! [String]).joined(separator: ","))"
    
    let urlGenerator = OOEmbeddedSecureURLGenerator(apiKey: APIKey!, secret: secretKey!)
    let embedTokenURL = urlGenerator?.secureURL(domain!, uri: uri, params: params)!
    callback(embedTokenURL!.absoluteString)
  }
  
  
}
