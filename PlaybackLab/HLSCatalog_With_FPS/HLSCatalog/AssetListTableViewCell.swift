/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 `AssetListTableViewCell` is the `UITableViewCell` subclass that represents an `Asset` visually in `AssetListTableViewController`.  This cell handles responding to user events as well as updating itself to reflect the state of the `Asset` if it has been downloaded, deleted, or is actively downloading.
 */

import UIKit

class AssetListTableViewCell: UITableViewCell {
    // MARK: Properties
    
    static let reuseIdentifier = "AssetListTableViewCellIdentifier"
    
    @IBOutlet weak var assetNameLabel: UILabel!
    
    @IBOutlet weak var downloadStateLabel: UILabel!
    
    @IBOutlet weak var downloadProgressView: UIProgressView!
    
    weak var delegate: AssetListTableViewCellDelegate?
    
    var asset: Asset? {
        didSet {
            if let asset = asset {
                let downloadState = AssetPersistenceManager.sharedManager.downloadState(for: asset)
                
                switch downloadState {
                case .downloaded:
                    downloadProgressView.isHidden = true
                    
                case .downloading:
                    
                    downloadProgressView.isHidden = false
                    
                case .notDownloaded:
                    break
                }
                
                assetNameLabel.text = asset.name
                downloadStateLabel.text = downloadState.rawValue
                
                let notificationCenter = NotificationCenter.default
                notificationCenter.addObserver(self, selector: #selector(handleAssetDownloadStateChangedNotification(_:)), name: AssetDownloadStateChangedNotification, object: nil)
                notificationCenter.addObserver(self, selector: #selector(handleAssetDownloadProgressNotification(_:)), name: AssetDownloadProgressNotification, object: nil)
            }
            else {
                downloadProgressView.isHidden = false
                assetNameLabel.text = ""
                downloadStateLabel.text = ""
            }
        }
    }
    
    // MARK: Notification handling
    
    func handleAssetDownloadStateChangedNotification(_ notification: Notification) {
        guard let assetStreamName = notification.userInfo![Asset.Keys.name] as? String,
            let downloadStateRawValue = notification.userInfo![Asset.Keys.downloadState] as? String,
            let downloadState = Asset.DownloadState(rawValue: downloadStateRawValue),
            let asset = asset
            , asset.name == assetStreamName else { return }
        
        DispatchQueue.main.async {
            switch downloadState {
            case .downloading:
                self.downloadProgressView.isHidden = false
                
                if let downloadSelection = notification.userInfo?[Asset.Keys.downloadSelectionDisplayName] as? String {
                    self.downloadStateLabel.text = "\(downloadState): \(downloadSelection)"
                    return
                }
                
            case .downloaded, .notDownloaded:
                self.downloadProgressView.isHidden = true
            }
            
            self.delegate?.assetListTableViewCell(self, downloadStateDidChange: downloadState)
        }
    }
    
    func handleAssetDownloadProgressNotification(_ notification: NSNotification) {
        guard let assetStreamName = notification.userInfo![Asset.Keys.name] as? String, let asset = asset , asset.name == assetStreamName else { return }
        guard let progress = notification.userInfo![Asset.Keys.percentDownloaded] as? Double else { return }
        
        self.downloadProgressView.setProgress(Float(progress), animated: true)
    }
}

protocol AssetListTableViewCellDelegate: class {
    
    func assetListTableViewCell(_ cell: AssetListTableViewCell, downloadStateDidChange newState: Asset.DownloadState)
}
