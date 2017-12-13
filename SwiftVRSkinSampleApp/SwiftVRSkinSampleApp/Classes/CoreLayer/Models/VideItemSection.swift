//
//  VideItemSection.swift
//  VRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

final class VideItemSection {
  
  // MARK: - Public properties
  
  var videoItems: [VideoItem]
  var title: String
  
  // MARK: - Initialization
  
  init(videoItems: [VideoItem], title: String) {
    self.videoItems = videoItems
    self.title      = title
  }
  
  
}

// MARK: - Mappable

extension VideItemSection: Mappable {
  
  static func create<T>(fromJSON json: Any?) -> T? {
    guard let json = json as? [String : Any],
      let videosArrayJSON = json["videos"] as? [Any],
      let title = json["title"] as? String,
      let videoItems: [VideoItem] = VideoItem.createCollection(fromArrayJSON: videosArrayJSON) else { return nil }
    
    return VideItemSection(videoItems: videoItems, title: title) as? T
  }
  
  static func createCollection<T>(fromJSON json: Any?) -> [T]? {
    return createCollection(fromArrayJSON: json)
  }
  
  static func createCollection<T>(fromArrayJSON json: Any?) -> [T]? {
    guard let jsonArray = json as? [Any] else { return nil }
    
    return jsonArray.flatMap({ VideItemSection.create(fromJSON: $0) })
  }

  
}
