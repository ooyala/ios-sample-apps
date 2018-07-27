//
//  PlayerSelectionOption.swift
//  OoyalaSSAISampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class PlayerSelectionOption: NSObject {
  
  private(set) var embedCode: String
  
  private(set) var pcode: String
  
  private(set) var title: String
  
  private(set) var adSetProvider: String
  
  private(set) var domain: OOPlayerDomain
  
  private(set) weak var embedTokenGenerator: OOEmbedTokenGenerator?
  
  init(embedCode: String, pcode: String, title: String, adSetProvider: String, domain: OOPlayerDomain) {
    self.embedCode = embedCode
    self.pcode = pcode
    self.domain = domain
    self.title = title
    self.adSetProvider = adSetProvider
    super.init()
  }
  
  convenience init(embedCode: String, pcode: String, title: String, adSetProvider: String, domain: OOPlayerDomain, embedTokenGenerator: OOEmbedTokenGenerator) {
    self.init(embedCode: embedCode, pcode: pcode, title: title, adSetProvider: adSetProvider, domain: domain)
    self.embedTokenGenerator = embedTokenGenerator
  }
  
}
