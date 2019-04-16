//
//  PlayerSelectionOption.swift
//  MultiplePlayersScrollingViewSampleApp
//
//  Copyright © 2019 Ooyala. All rights reserved.
//

import UIKit

class PlayerSelectionOption: NSObject {

  public private(set) var embedCode: String
  
  public private(set) var pcode: String
  
  public private(set) var domain: OOPlayerDomain
  
  public private(set) var embedTokenGenerator: OOEmbedTokenGenerator?
  
  init(embedCode: String, pcode: String, domain: OOPlayerDomain) {
    self.embedCode = embedCode
    self.pcode     = pcode
    self.domain    = domain
    super.init()
  }
  
  convenience init(embedCode: String, pcode: String, domain: OOPlayerDomain, embedTokenGenerator: OOEmbedTokenGenerator) {
    self.init(embedCode: embedCode, pcode: pcode, domain: domain)
    self.embedTokenGenerator = embedTokenGenerator
  }
  
}