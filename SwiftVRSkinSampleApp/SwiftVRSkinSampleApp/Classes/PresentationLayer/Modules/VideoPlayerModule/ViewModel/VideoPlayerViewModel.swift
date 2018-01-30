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
  
  // MARK: - Constants
  
  private enum Constants {
    static let logFileName = "ooyalaDebugLog.log"
  }
  
  // MARK: - Initialization
  
  init(videoItem: VideoItem, pcode: String, domain: String, QAModeEnabled: Bool) {
    self.videoItem     = videoItem
    self.pcode         = pcode
    self.domain        = domain
    self.QAModeEnabled = QAModeEnabled
    
    removeLogFile(with: Constants.logFileName)
  }
  
  // MARK: - Public functions
  
  func debugPrint(debugString: String) {
    let logFilePath = pathToLogFile(with: Constants.logFileName)
    var dump = ""
    
    do {
      
      if FileManager.default.fileExists(atPath: logFilePath) {
        dump = try String(contentsOfFile: logFilePath, encoding: .utf8)
      }
      
      dump = "\(dump) :::::::::: \(debugString)"
      
      // Write to the file
      
      try dump.write(toFile: logFilePath, atomically: true, encoding: .utf8)
      
    } catch let error as NSError {
      print("Failed writing to log file: \(logFilePath), Error: " + error.localizedDescription)
    }
  }
  
  // MARK: - Private functions
  
  private func pathToLogFile(with name: String) -> String {
    var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    
    return (documentsDirectory as NSString).appendingPathComponent(name)
  }
  
  private func removeLogFile(with name: String) {
    let logFilePath = pathToLogFile(with: name)

    if FileManager.default.fileExists(atPath: logFilePath) {
      try? FileManager.default.removeItem(atPath: logFilePath)
    }
  }
}
