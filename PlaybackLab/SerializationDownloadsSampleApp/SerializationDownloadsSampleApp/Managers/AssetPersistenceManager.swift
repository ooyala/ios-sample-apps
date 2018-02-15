//
//  AssetPersistenceManager.swift
//  SerializationDownloadsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import Foundation

/**
 Identifies the different states for a download process. All the states are mutually exclusive for a single download task.
 
 - AssetNotDownloaded
 - AssetAuthorizing
 - AssetDownloading
 - AssetPaused
 - AssetDownloaded
 - AssetFailed
 - AssetInQueue
 */
enum AssetPersistenceState : Int {
  case assetNotDownloaded
  case assetAuthorizing
  case assetDownloading
  case assetPaused
  case assetDownloaded
  case assetFailed
  case assetInQueue
}

let FAIRPLAY_KEY_NAME = "OO_DTO_%@.key"
let AssetPersistenceStateChangedNotification = NSNotification.Name("AssetPersistenceStateChangedNotification")
let AssetDownloadProgressNotification = NSNotification.Name("AssetDownloadProgressNotification")
let AssetNameKey = "name"
let AssetStateKey = "downloadState"
let AssetProgressKey = "percentage"
let MaxDownloads = 3
let MaxRetries = 3

class AssetPersistenceManager: NSObject {
  
  static let shared = AssetPersistenceManager()
  
  fileprivate var pendingDownloads = Queue()
  fileprivate var activeDownloads = Queue()
  fileprivate var pausedDownloads = Queue()
  fileprivate var failedDownloads = Queue()
  fileprivate var queuedDownloads = Queue()
  fileprivate var retriesDownloads = [String: Int]()
  
  fileprivate func buildDownloadManager(for option: PlayerSelectionOption) -> OOAssetDownloadManager {
    let options = OOAssetDownloadOptions()
    options.pcode = option.pcode
    options.embedCode = option.embedCode
    options.domain = option.domain
    options.embedTokenGenerator = option.embedTokenGenerator
    options.allowsCellularAccess = false
    options.minimumBitrate = 0
    return OOAssetDownloadManager(options: options)
  }
  
  fileprivate func retryDownload(for downloadManager: OOAssetDownloadManager) {
    let retries = retriesDownloads[downloadManager.embedCode]!
    if retries > 0 {
      retriesDownloads.updateValue(retries - 1, forKey: downloadManager.embedCode)
      pendingDownloads.enqueue(downloadManager)
      downloadManager.startDownload()
    }
    else {
      retriesDownloads.removeValue(forKey: downloadManager.embedCode)
      let userInfo = [AssetNameKey: downloadManager.embedCode,
                  AssetStateKey: AssetPersistenceState.assetNotDownloaded] as [String: Any]
      
      NotificationCenter.default.post(name: AssetPersistenceStateChangedNotification,
                                      object: nil,
                                      userInfo: userInfo)
    }
  }
  
  func downloadState(forEmbedCode embedCode: String) -> AssetPersistenceState {
    if let fileURL = UserDefaults.standard.url(forKey: embedCode),
      FileManager.default.fileExists(atPath: fileURL.path) {
      return .assetDownloaded
    }
    else {
      if pendingDownloads.contains(embedCode) {
        return .assetAuthorizing
      }
      else if activeDownloads.contains(embedCode) {
        return .assetDownloading
      }
      else if pausedDownloads.contains(embedCode) {
        return .assetPaused
      }
      else if queuedDownloads.contains(embedCode) {
        return .assetInQueue
      }
      else if failedDownloads.contains(embedCode) {
        return .assetFailed
      }
      else {
        return .assetNotDownloaded
      }
    }
  }
  
  func deleteDownloadedFile(forEmbedCode embedCode: String) {
    print("[AssetPersistenceManager] Cancelled a download in progress for embed code: \(embedCode), current download state: Not Downloaded")
    
    // Delete the contents of a downloaded video and the reference to the URL in NSUSeerDefaults
    OOAssetDownloadManager.deleteFile(atLocation: UserDefaults.standard.url(forKey: embedCode))
    UserDefaults.standard.removeObject(forKey: embedCode)
    
    // Delete a Fairplay license and the reference to the URL in NSUSeerDefaults
    OOAssetDownloadManager.deleteFile(atLocation: UserDefaults.standard.url(forKey: String(format: FAIRPLAY_KEY_NAME, embedCode)))
    UserDefaults.standard.removeObject(forKey: String(format: FAIRPLAY_KEY_NAME, embedCode))
    
    // Notify about the state of this asset to be NotDownloaded.
    let userInfo = [AssetNameKey: embedCode,
                    AssetStateKey: AssetPersistenceState.assetNotDownloaded] as [String : Any]
    
    NotificationCenter.default.post(name: AssetPersistenceStateChangedNotification,
                                    object: nil,
                                    userInfo: userInfo)
  }
  
  func video(forEmbedCode embedCode: String) -> OOOfflineVideo {
    // Search for the location of the video and fairplay license.
    let location = UserDefaults.standard.url(forKey: embedCode)
    let keyLocation = UserDefaults.standard.url(forKey: String(format: FAIRPLAY_KEY_NAME, embedCode))
    return OOOfflineVideo(videoLocation: location, fairplayKeyLocation: keyLocation)
  }
  
  func startDownload(for option: PlayerSelectionOption) {
    print("[AssetPersistenceManager] download intent started for embed code: \(option.embedCode), current download state:  Authorizing")
    
    // First, need to verify the download is not in the failed queue.
    var downloadManager: OOAssetDownloadManager!
    if !failedDownloads.contains(option.embedCode) {
      downloadManager = buildDownloadManager(for: option)
      // this class becomes the delegate of the newly created OOAssetDownloadManager instance.
      // After starting a download, we'll be notified about it in the OOAssetDownloadManagerDelegate methods.
      downloadManager.delegate = self
    }
    else {
      downloadManager = failedDownloads.getOOAssetDownloadManager(option.embedCode)
      failedDownloads.remove(option.embedCode)
    }
    
    var state = AssetPersistenceState.assetAuthorizing
    if activeDownloads.count < MaxDownloads {
      downloadManager.startDownload()
      pendingDownloads.enqueue(downloadManager)
    }
    else {
      queuedDownloads.enqueue(downloadManager)
      state = AssetPersistenceState.assetInQueue
    }
    
    let userInfo = [AssetNameKey: downloadManager.embedCode,
                    AssetStateKey: state] as [String : Any]
    
    NotificationCenter.default.post(name: AssetPersistenceStateChangedNotification,
                                    object: nil,
                                    userInfo: userInfo)
  }
  
  func pauseDownload(forEmbedCode embedCode: String) {
    // find a download in progress for the given embed code, pause the download.
    print("[AssetPersistenceManager] Attempting to pause a download for embed code: \(embedCode)")
    
    if let downloadManager = pendingDownloads.getOOAssetDownloadManager(embedCode) {
      pendingDownloads.remove(embedCode)
      pausedDownloads.enqueue(downloadManager)
    }
    else if let downloadManager = activeDownloads.getOOAssetDownloadManager(embedCode) {
      activeDownloads.remove(embedCode)
      pausedDownloads.enqueue(downloadManager)
    }
    
    let userInfo = [AssetNameKey: embedCode,
                    AssetStateKey: AssetPersistenceState.assetPaused] as [String : Any]
    NotificationCenter.default.post(name: AssetPersistenceStateChangedNotification,
                                    object: nil,
                                    userInfo: userInfo)
  }
  
  func resumeDownload(forEmbedCode embedCode: String) {
    // find a paused download for the given embed code, resume the download.
    print("[AssetPersistenceManager] Attempting to resume a download for embed code: \(embedCode)")
    let downloadManager = pausedDownloads.getOOAssetDownloadManager(embedCode)!
    if activeDownloads.count < MaxDownloads {
      pausedDownloads.remove(embedCode)
      downloadManager.resumeDownload()
      activeDownloads.enqueue(downloadManager)
    }
    else {
      pausedDownloads.remove(embedCode)
      queuedDownloads.enqueue(downloadManager)
    }
    let userInfo = [AssetNameKey: embedCode,
                    AssetStateKey: AssetPersistenceState.assetDownloading] as [String : Any]
    
    NotificationCenter.default.post(name: AssetPersistenceStateChangedNotification,
                                    object: nil,
                                    userInfo: userInfo)
  }
  
  func cancelDownload(forEmbedCode embedCode: String) {
    // find a download in progress for the given embed code, cancel the download and remove the remaining contents if something was downloaded already.
    print("[AssetPersistenceManager] Attempting to cancel a download for embed code: \(embedCode)")
    if let downloadManager = pendingDownloads.getOOAssetDownloadManager(embedCode) {
      downloadManager.cancelDownload()
      pendingDownloads.remove(embedCode)
    }
    else if let downloadManager = activeDownloads.getOOAssetDownloadManager(embedCode) {
      downloadManager.cancelDownload()
      activeDownloads.remove(embedCode)
    }
    else if let downloadManager = queuedDownloads.getOOAssetDownloadManager(embedCode) {
      downloadManager.cancelDownload()
      queuedDownloads.remove(embedCode)
    }
  }
  
}

extension AssetPersistenceManager: OOAssetDownloadManagerDelegate {
  func downloadManager(_ manager: OOAssetDownloadManager!, downloadTaskStartedWithError error: OOOoyalaError!) {
    var downloadState = AssetPersistenceState.assetDownloading
    // the download task either started or failed to be authorized, either way we must remove it from the downloadsPendingAuth Set.
    
    pendingDownloads.remove(manager.embedCode)
    if error != nil {
      print("[AssetPersistenceManager] error starting a download for embed code: \(manager.embedCode), current download state: Not Downloaded, error object: \(error)")
      downloadState = AssetPersistenceState.assetNotDownloaded
      failedDownloads.enqueue(manager)
      
      if !retriesDownloads.contains(where: { $0.key == manager.embedCode }) {
        retriesDownloads[manager.embedCode] = MaxRetries
      }
      
    }
    else {
      // If a download was started successfuly, then we add it to the activeDownloads Set.
      print("[AssetPersistenceManager] download started successfuly for embed code: \(manager.embedCode), current download state: Downloading")
      activeDownloads.enqueue(manager)
    }
    
    // Notify the download state of the asset, either Downloading or NotDownloaded.
    let userInfo = [AssetNameKey: manager.embedCode,
                    AssetStateKey: downloadState] as [String: Any]
    
    NotificationCenter.default.post(name: AssetPersistenceStateChangedNotification,
                                    object: nil,
                                    userInfo: userInfo)
    
    if activeDownloads.isEmpty, queuedDownloads.isEmpty {
      if let downloadManager = failedDownloads.dequeue() {
        retryDownload(for: downloadManager)
      }
    }
  }
  
  func downloadManager(_ manager: OOAssetDownloadManager!, downloadCompletedAtLocation location: URL!, withError error: OOOoyalaError!) {
    var downloadState =  AssetPersistenceState.assetDownloading
    // Save the location in NSUserDefaults. The location is needed it if we want to delete the file after an error.
    UserDefaults.standard.set(location, forKey: manager.embedCode)
    
    if error != nil {
      print("[AssetPersistenceManager] error completing a download for embed code: \(manager.embedCode), current download state: Not Downloaded, error object: \(error)")
      downloadState = AssetPersistenceState.assetNotDownloaded
      deleteDownloadedFile(forEmbedCode: manager.embedCode)
      
      // The error with the 'Cancelled' message is not added in the queue, this error comes when the user cancels the download.
      if !error!.description.contains("Cancelled") {
        failedDownloads.enqueue(manager)
        if !retriesDownloads.contains(where: { $0.key == manager.embedCode }) {
          retriesDownloads[manager.embedCode] = MaxDownloads
        }
      }
    }
    else {
      print("[AssetPersistenceManager] download completed successfuly for embed code: \(manager.embedCode) current download state: Downloaded.")
      downloadState = AssetPersistenceState.assetDownloaded
    }
    
    // At this point the download completed successfuly or not, either way we must remove the manager from the activeDownloads Set.
    activeDownloads.remove(manager.embedCode)
    
    // Notify the download state of the asset, either Downloaded or NotDownloaded.
    let userInfo = [AssetNameKey: manager.embedCode,
                    AssetStateKey: downloadState] as [String: Any]
    
    NotificationCenter.default.post(name: AssetPersistenceStateChangedNotification,
                                    object: nil,
                                    userInfo: userInfo)
    
    if activeDownloads.count < MaxDownloads {
      if let downloadManager = queuedDownloads.dequeue() {
        downloadManager.startDownload()
      }
      else if let downloadManager = failedDownloads.dequeue() {
        retryDownload(for: downloadManager)
      }
    }
  }
  
  func downloadManager(_ manager: OOAssetDownloadManager!, persistedContentKeyAtLocation location: URL!) {
    // Store the location of the Fairplay Key in NSUserDefaults, we'll need it to playback the DRM video offline.
    print("[AssetPersistenceManager] Saving Fairplay license location in NSUserDefaults using key: \(String(format: FAIRPLAY_KEY_NAME, manager.embedCode))")
    
    UserDefaults.standard.set(location, forKey: String(format: FAIRPLAY_KEY_NAME, manager.embedCode))
  }
  
  func downloadManager(_ manager: OOAssetDownloadManager!, downloadPercentage percentage: Float64) {
    let userInfo = [AssetNameKey: manager.embedCode,
                    AssetProgressKey: percentage] as [String: Any]
    
    NotificationCenter.default.post(name: AssetDownloadProgressNotification,
                                    object: nil,
                                    userInfo: userInfo)
  }
}
