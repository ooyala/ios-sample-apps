//
//  VideoPlayerViewModel.swift
//  VRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

class VideoPlayerViewModel {
  
  // MARK: - Public properties
  
  var videoItem: VideoItem
  var pcode: String
  var domain: String
  var QAModeEnabled: Bool
  
  // MARK: - Initialization
  
  init(videoItem: VideoItem, pcode: String, domain: String, QAModeEnabled: Bool) {
    self.videoItem     = videoItem
    self.pcode         = pcode
    self.domain        = domain
    self.QAModeEnabled = QAModeEnabled
  }
  
  
}
