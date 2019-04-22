//
//  PlayerSelectionOption.swift
//  MultiplePlayersScrollingViewSampleApp
//
//  Copyright © 2019 Ooyala. All rights reserved.
//

class PlayerSelectionOption {
  
  public private(set) var domain: OOPlayerDomain
  
  public private(set) var pcode: String
  
  public private(set) var embedCode: String
  
  public private(set) var title: String
  
  public private(set) weak var embedTokenGenerator: OOEmbedTokenGenerator?

  init(pcode: String,
       embedCode: String,
       title: String,
       domain: OOPlayerDomain,
       embedTokenGenerator: OOEmbedTokenGenerator? = nil) {
    self.pcode = pcode
    self.embedCode = embedCode
    self.title = title
    self.domain = domain
    self.embedTokenGenerator = embedTokenGenerator
  }
}

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
