//
//  PlayerSelectionOption.swift
//  DownloadToOwnSampleAppSwift
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import Foundation

class PlayerSelectionOption {
  
  public private(set) var domain: OOPlayerDomain
  public private(set) var pcode: String
  public private(set) var embedCode: String
  public private(set) var title: String
  public private(set) var embedTokenGenerator: OOEmbedTokenGenerator?
  
  init(pcode: String,
       embedCode: String,
       title: String,
       domain: OOPlayerDomain,
       embedTokenGenerator: OOEmbedTokenGenerator? = nil) {
    self.domain = domain
    self.pcode = pcode
    self.embedCode = embedCode
    self.title = title
    self.embedTokenGenerator = embedTokenGenerator
  }
}
