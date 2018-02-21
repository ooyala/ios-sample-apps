//
//  OptionTableViewCell.swift
//  SerializationDownloadsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

let CELL_REUSE_IDENTIFIER = "OptionCellReuseIdentifier"

class OptionTableViewCell: UITableViewCell {
  
  /**
   Shows the title of the asset
   */
  @IBOutlet weak var titleLabel: UILabel!
  
  /**
   Shows the download state of the asset
   */
  @IBOutlet weak var subtitleLabel: UILabel!
  
  /**
   Shows the percentage progress of an active download.
   */
  @IBOutlet weak var downloadProgressView: UIProgressView!
  
  /**
   The option contains the info concerning this cell.
   The cell cares a lot about the embed code to know what to do
   when it gets the embed code through a notification, for example.
   */
  
  public private(set) var option: PlayerSelectionOption!
  /**
   Calls the delegate when it needs to, to notify it about changes about the download process.
   */
  weak var delegate: OptionTableViewCellDelegate!
  
  /**
   When we set the option for a cell, each cell becomes a notification observer of the
   AssetPersistenceStateChangedNotification and AssetDownloadProgressNotification notifications.
   
   @param option with the title and embed code info that this cell can use to render its UI.
   */
  
  func setup(delegate: OptionTableViewCellDelegate, option: PlayerSelectionOption) {
    self.delegate = delegate
    self.option = option
    
    titleLabel.text = option.title
    updateCell(withState: AssetPersistenceManager.shared.downloadState(forEmbedCode: self.option.embedCode))
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(handleAssetStateChanged(_:)),
                                           name: AssetPersistenceStateChangedNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(handleProgressChanged(_:)),
                                           name: AssetDownloadProgressNotification,
                                           object: nil)
  }
  
  private func updateCell(withState state: AssetPersistenceState) {
    switch state {
    case .assetNotDownloaded:
      subtitleLabel.text = "not downloaded"
      downloadProgressView.isHidden = true
    case .assetAuthorizing:
      subtitleLabel.text = "authorizing"
      downloadProgressView.isHidden = true
    case .assetDownloading:
      subtitleLabel.text = "download starting"
      downloadProgressView.setProgress(0.0, animated: false)
      downloadProgressView.isHidden = false
    case .assetPaused:
      subtitleLabel.text = "paused download"
      downloadProgressView.isHidden = true
    case .assetDownloaded:
      subtitleLabel.text = "downloaded"
      downloadProgressView.isHidden = true
    case .assetInQueue:
      subtitleLabel.text = "in queue, maximum of downloads is \(MaxDownloads)"
      downloadProgressView.isHidden = true
    case .assetFailed:
      subtitleLabel.text = "download failed"
      downloadProgressView.isHidden = true
    }
  }
  
  /**
   When there's a download state change, this method gets called.
   It will update the cell's UI if the given notification has
   the same embed code as this cell's embed code.
   
   @param notification containing information about which embed code has a state change and what is the state.
   */
  @objc
  private func handleAssetStateChanged(_ notification: Notification) {
    let embedCode = notification.userInfo![AssetNameKey] as! String
    
    // we only care if the notification's embed code is the same as the one we have in this cell.
    if (embedCode == option.embedCode) {
      DispatchQueue.main.async(execute: {() -> Void in
        let state = notification.userInfo![AssetStateKey] as! AssetPersistenceState
        self.updateCell(withState: state)
        self.delegate.optionCell(self)
      })
    }
  }
  
  /**
   We'll get this notification when there's an active download in progress.
   This lets us know about the percentage progress.
   
   @param notification containing information about the download progress of a given embed code.
   */
  
  @objc
  private func handleProgressChanged(_ notification: Notification) {
    let embedCode = notification.userInfo![AssetNameKey] as! String
    let state = AssetPersistenceManager.shared.downloadState(forEmbedCode: option.embedCode)
    if embedCode == option.embedCode && state == AssetPersistenceState.assetDownloading {
      // Update progressView with the percentage progress of the notification.
      // We assume it has a value between 0.0 and 1.0.
      DispatchQueue.main.async(execute: {() -> Void in
        let percentage = notification.userInfo![AssetProgressKey] as! NSNumber
        self.subtitleLabel.text = String(format: "downloading: %.0f%%", Float(truncating: percentage ) * 100)
        self.downloadProgressView.setProgress(Float(truncating: percentage), animated: true)
      })
    }
  }
  
}

protocol OptionTableViewCellDelegate: NSObjectProtocol {
  /**
   Notifies the delegate about the download state of a given cell's embed code.
   @param cell OptionTableViewCell that is calling this method.
   */
  func optionCell(_ cell: OptionTableViewCell)
}
