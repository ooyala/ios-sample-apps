//
//  PlayerSelectionOption.swift
//  ControlsLockScreenSampleApp
//
//  Created by Carlos Ceja on 10/18/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

import Foundation

class PlayerSelectionOption: NSObject {
  
  private var domain: OOPlayerDomain
  
  private var pcode: String
  
  private var embedCode: String
  
  private var title: String
  
  private var thumbnailURL: URL
  
  private weak var embedTokenGenerator: OOEmbedTokenGenerator?
  
  init(pcode: String, embedCode: String, title: String, thumbnailURL: URL, domain: OOPlayerDomain) {
    self.domain = domain
    self.pcode = pcode
    self.embedCode = embedCode
    self.title = title
    self.thumbnailURL = thumbnailURL
    super.init()
  }
  
  convenience init(pcode: String, embedCode: String, title: String, thumbnailURL: URL, domain: OOPlayerDomain, embedTokenGenerator: OOEmbedTokenGenerator) {
    self.init(pcode: pcode, embedCode: embedCode, title: title, thumbnailURL: thumbnailURL, domain: domain)
    self.embedTokenGenerator = embedTokenGenerator
  }
  
  func getDomain() -> OOPlayerDomain {
    return domain
  }
  
  func getPcode() -> String {
    return pcode
  }
  
  func getEmbedCode() -> String {
    return embedCode
  }
  
  func getTitle() -> String {
    return title
  }
  
  func getThumbnailURL() -> URL {
    return thumbnailURL
  }
  
  func getEmbedTokenGenerator() -> OOEmbedTokenGenerator? {
    return embedTokenGenerator
  }
  
}
