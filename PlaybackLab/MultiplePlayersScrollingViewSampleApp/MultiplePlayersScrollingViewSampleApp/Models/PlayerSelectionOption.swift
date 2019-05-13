//
//  PlayerSelectionOption.swift
//  MultiplePlayersScrollingViewSampleApp
//
//  Copyright © 2019 Ooyala. All rights reserved.
//

class PlayerSelectionOption {

  public private(set) var embedCode: String
  public private(set) var pcode: String
  public private(set) var domain: OOPlayerDomain
  public private(set) var embedTokenGenerator: OOEmbedTokenGenerator?
  public var playheadTime: Float64 = 0
  public var isPaused = false
  
  init(embedCode: String,
       pcode: String,
       domain: OOPlayerDomain,
       embedTokenGenerator: OOEmbedTokenGenerator? = nil) {
    self.embedCode = embedCode
    self.pcode     = pcode
    self.domain    = domain
    self.embedTokenGenerator = embedTokenGenerator
  }

}
