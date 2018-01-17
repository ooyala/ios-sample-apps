//
//  AssetDownloadManager.swift
//  AssetDownloadManagerSmapleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

import Foundation


protocol AssetDownloadManagerDelegate: class {
  
  func downloadPercentage(percentage: Float64, embedCode: String)
  func downloadCompletedAtLocation(location: URL?, embedCode: String, error: OOOoyalaError?)
  func paused(embedCode: String)
  func resumed(embedCode: String)

}

class AssetDownloadManager: NSObject {
  
  // MARK: - Public properties
  
  weak var delegate: AssetDownloadManagerDelegate?
  var downloadsPendingAuth: Set<OOAssetDownloadManager>
  var activeDownloads: Set<OOAssetDownloadManager>
  var embedTokenGenerator: OOEmbedTokenGenerator!
  
  var PCODE: String!
  var minimumBitrate: NSNumber! = 2855600
  var domain: String!

  // MARK: - Initializaiton
  
  override init() {
    downloadsPendingAuth = Set()
    activeDownloads = Set()
  }
  
  convenience init(embedTokenGenerator: EmbedTokenGenerator) {
    self.init()
    
    self.embedTokenGenerator = embedTokenGenerator
    
    self.PCODE = embedTokenGenerator.PCODE
    self.domain = embedTokenGenerator.domain
  }
  
  // MARK: - Public functions
  
  func authorizeDownload(embedCode: String) {
    embedTokenGenerator.token(forEmbedCodes: [embedCode]) { (embedToken) in
      if let _ = embedToken {
        self.startDownload(embedCode: embedCode, embedTokenGenerator: self.embedTokenGenerator)
      } else {
        assertionFailure("embed token failed load")
      }
    }
  }
  
  func pauseDownloadingFile(embedCode: String) {
    var downloadPauseSuccess = false
    
    for downloadManager in downloadsPendingAuth {
      if downloadManager.embedCode == embedCode {
        downloadPauseSuccess = true
        downloadManager.pauseDownload()
        break
      }
    }
    
    for downloadManager in activeDownloads {
      if downloadManager.embedCode == embedCode {
        downloadPauseSuccess = true
        downloadManager.pauseDownload()
        break
      }
    }
    
    if downloadPauseSuccess  {
      delegate?.paused(embedCode: embedCode)
      print("--> pauseDownloadingFile paused (embedCode = \(embedCode)")
    } else {
      print("--> pauseDownloadingFile not paused (embedCode = \(embedCode)")
    }
  }
  
  func resumeDownload(embedCode: String) {
    var downloadResumeSuccess = false
    
    for downloadManager in downloadsPendingAuth {
      if downloadManager.embedCode == embedCode {
        downloadResumeSuccess = true
        downloadManager.resumeDownload()
        break
      }
    }
    
    for downloadManager in activeDownloads {
      if downloadManager.embedCode == embedCode {
        downloadResumeSuccess = true
        downloadManager.resumeDownload()
        break
      }
    }
    
    if downloadResumeSuccess {
      delegate?.resumed(embedCode: embedCode)
      print("--> resumeDownload resumed (embedCode = \(embedCode)")
    } else {
      print("--> resumeDownload not resumed (embedCode = \(embedCode)")
      deleteDownloadedFile(embedCode: embedCode)
    }
  }
  
  func cancelDownload(embedCode: String) {
    for downloadManager in downloadsPendingAuth {
      if downloadManager.embedCode == embedCode {
        downloadManager.cancelDownload()
        deleteDownloadedFile(embedCode: embedCode)
        downloadsPendingAuth.remove(downloadManager)
        break
      }
    }
    
    for downloadManager in activeDownloads {
      if downloadManager.embedCode == embedCode {
        downloadManager.cancelDownload()
        deleteDownloadedFile(embedCode: embedCode)
        activeDownloads.remove(downloadManager)
        break
      }
    }
  }
  
  // MARK: - Private functions
  
  private func startDownload(embedCode: String, embedTokenGenerator: OOEmbedTokenGenerator) {
    let downloadManager = createDownloadManager(embedCode: embedCode, embedTokenGenerator: embedTokenGenerator)
    downloadManager.delegate = self
    downloadManager.startDownload()
    
    downloadsPendingAuth.insert(downloadManager)
    
    print("--> startDownload (embedCode = \(embedCode)")
  }
  
  private func createDownloadManager(embedCode: String, embedTokenGenerator: OOEmbedTokenGenerator) -> OOAssetDownloadManager {
    let options = OOAssetDownloadOptions()
    options.pcode = PCODE
    options.minimumBitrate = minimumBitrate
    options.domain = OOPlayerDomain.domain(with: domain) as! OOPlayerDomain
    options.embedCode = embedCode
    options.embedTokenGenerator = embedTokenGenerator
    
    return OOAssetDownloadManager(options: options)
  }
  
  private func deleteDownloadedFile(embedCode: String) {
    print("--> delete downloaded file (embedCode = \(embedCode)")
    
    // Delete the contents of a downloaded video and the reference to the URL in NSUSeerDefaults
    
    OOAssetDownloadManager.deleteFile(atLocation: UserDefaults.standard.url(forKey: embedCode))
    UserDefaults.standard.removeObject(forKey: embedCode)
    
    // Delete a Fairplay license and the reference to the URL in NSUSeerDefaults
    
    OOAssetDownloadManager.deleteFile(atLocation: UserDefaults.standard.url(forKey: "OO_DTO_\(embedCode).key"))
  }
  
  
}

// MARK: - OOAssetDownloadManagerDelegate

extension AssetDownloadManager: OOAssetDownloadManagerDelegate {
  
  func downloadManager(_ manager: OOAssetDownloadManager!, downloadTaskStartedWithError error: OOOoyalaError!) {
    
    // The download task either started or failed to be authorized, either way we must remove it from the downloadsPendingAuth Set.
    
    downloadsPendingAuth.remove(manager)
    
    if let error = error {
      print("*** downloadTaskStartedWithError error! \(error) - \(manager.embedCode!)")
    } else {
      print("*** downloadTaskStartedWithSuccess - \(manager.embedCode!)")
      
      activeDownloads.insert(manager)
    }
  }
  
  func downloadManager(_ manager: OOAssetDownloadManager!, downloadCompletedAtLocation location: URL!, withError error: OOOoyalaError!) {
    if let error = error {
      print("*** downloadCompletedAtLocation error! \(error) - \(manager.embedCode!)")
    } else {
      print("*** downloadCompletedAtLocation - \(manager.embedCode!)")

      // A download completed successfuly, save the location in NSUserDefaults
      
      UserDefaults.standard.set(location, forKey: manager.embedCode)
    }
    
    // At this point the download completed successfuly or not, either way we must remove the manager from the activeDownloads Set.
    
    activeDownloads.remove(manager)
    delegate?.downloadCompletedAtLocation(location: location, embedCode: manager.embedCode, error: error)
  }
  
  func downloadManager(_ manager: OOAssetDownloadManager!, downloadPercentage percentage: Float64) {
    delegate?.downloadPercentage(percentage: percentage, embedCode: manager.embedCode)
    
    print("*** downloadPercentage (embedCode = \(manager.embedCode!) -- \(Int(percentage * 100))%")
  }
  
  func downloadManager(_ manager: OOAssetDownloadManager!, persistedContentKeyAtLocation location: URL!) {
    
    // Store the location of the Fairplay Key in NSUserDefaults, we'll need it to playback the DRM video offline.
    
    UserDefaults.standard.set(location, forKey: "OO_DTO_\(manager.embedCode).key")
    
    print("*** persistedContentKeyAtLocation - \(manager.embedCode!)")
  }
  
  
}
