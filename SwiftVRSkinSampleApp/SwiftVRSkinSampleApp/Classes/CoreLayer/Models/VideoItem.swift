//
//  VideoItem.swift
//  VRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

final class VideoItem {
  
  // MARK: - Public properties
  
  enum VideoType: String {
    case unknown
    case noAds        = "NO-ADS"
    case ooyala       = "OOYALA"
    case ima          = "IMA"
    case vast         = "VAST"
    case freewheel    = "FREEWHEEL"
    case geoblocking  = "GEOBLOCKING"
  }
  
  var embedCode: String
  var title: String
  var pcode: String?
  var accountId: String?
  var secretKey: String?
  var apiKey: String?
  var videoAdType: VideoType = .unknown
  
  // MARK: - Initialization
  
  init(embedCode: String, title: String) {
    self.embedCode = embedCode
    self.title     = title
  }
  
  
}

// MARK: - Mappable

extension VideoItem: Mappable {
  
  static func create<T>(fromJSON json: Any?) -> T? {
    guard let json = json as? [String : String],
      let embedCode = json["embed-code"],
      let title = json["title"] else { return nil }
    
    let newVideoItem = VideoItem(embedCode: embedCode, title: title)
    
    if let parsedAdTypeString = json["ad-type"],
      let parsedAdType = VideoType(rawValue: parsedAdTypeString) {
      
      newVideoItem.videoAdType = parsedAdType
    }
    
    newVideoItem.pcode = json["provider-code"]
    newVideoItem.apiKey = json["api-key"]
    newVideoItem.secretKey = json["secret-key"]
    newVideoItem.accountId = json["account-id"]
    
    return newVideoItem as? T
  }
  
  static func createCollection<T>(fromArrayJSON json: Any?) -> [T]? {
    guard let jsonArray = json as? [Any] else { return nil }
    
    return jsonArray.flatMap({ VideoItem.create(fromJSON: $0) })
  }
  
}
