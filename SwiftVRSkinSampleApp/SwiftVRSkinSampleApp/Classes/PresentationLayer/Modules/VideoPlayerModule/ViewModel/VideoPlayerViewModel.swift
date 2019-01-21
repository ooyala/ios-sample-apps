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

    removeLogFile(named: Constants.logFileName)
  }

  // MARK: - Public functions
  func debugPrint(debugString: String) {
    guard let logFileURL = pathToLogFile(named: Constants.logFileName) else { return }
    var dump = ""

    do {
      if FileManager.default.fileExists(atPath: logFileURL.path) {
        dump = try String(contentsOf: logFileURL, encoding: .utf8)
      }

      dump = "\(dump) :::::::::: \(debugString)"

      // Write to the file
      try dump.write(to: logFileURL, atomically: true, encoding: .utf8)

    } catch {
      print("Failed writing to log file: \(logFileURL.path), Error: " + error.localizedDescription)
    }
  }

  // MARK: - Private functions
  private func pathToLogFile(named name: String) -> URL? {
    guard let documentsPathURL = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask).first else {
                                                            return nil
    }
    return documentsPathURL.appendingPathComponent(name)
  }

  private func removeLogFile(named name: String) {
    guard let logFileURL = pathToLogFile(named: name) else { return }

    if FileManager.default.fileExists(atPath: logFileURL.path) {
      try? FileManager.default.removeItem(at: logFileURL)
    }
  }
}
