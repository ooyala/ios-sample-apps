//
//  AssetDownloadViewController.swift
//  AssetDownloadManagerSmapleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

import UIKit


class AssetDownloadViewController: UIViewController {

  // MARK: - Constants
  
  private enum Constants {
    
    // Set your properties

    static let embedCode1 = "tvaTluYzE6gfZg5nhqlqxPV7YbEukBCj" // No ads with watermark_V360
    static let embedCode2 = "syazl0YzE6sGVc6vA5sPUZK6RWp5aplu" // No ads with long description_V360
    static let embedCode3 = "FwOG5mZDE66kvaxH6EyZpj0iJ2AxBj_v" // No ads_V360
    
    static let accountID = "110698"
    static let PCODE     = "BzY2syOq6kIK6PTXN7mmrGVSJEFj"
    static let APIKey    = "BzY2syOq6kIK6PTXN7mmrGVSJEFj.APkQ3"
    static let secretKey = "nYDE1TkyZOhyQ2HZBRjCZ1E0tCNFvgk8b2UmvHd1"
    static let domain    = "http://player.ooyala.com"
  }
  
  // MARK: - IBOutlets

  @IBOutlet weak var assetsStackView: UIStackView!
  @IBOutlet weak var logTextView: UITextView!
  
  // MARK: - Private properties
  
  private var assetOneLoadAssetView: LoadAssetView!
  private var assetTwoLoadAssetView: LoadAssetView!
  private var assetThreeLoadAssetView: LoadAssetView!
  private var assetDownloadManager: AssetDownloadManager!
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureObjects()
    configureUI()
  }

  // MARK: - Private funtions
  
  private func configureObjects() {
    
    // Embed token generator
  
    let embedTokenGenerator = EmbedTokenGenerator(PCODE: Constants.PCODE,
                                                  accountID: Constants.accountID,
                                                  APIKey: Constants.APIKey,
                                                  secretKey: Constants.secretKey,
                                                  domain: Constants.domain)
    
    // Asset download manager
    
    assetDownloadManager = AssetDownloadManager(embedTokenGenerator: embedTokenGenerator)
    assetDownloadManager.delegate = self
    
    // Load views
    
    assetOneLoadAssetView = Bundle.main.loadNibNamed("LoadAssetView", owner: self, options: nil)?.first as? LoadAssetView
    assetTwoLoadAssetView = Bundle.main.loadNibNamed("LoadAssetView", owner: self, options: nil)?.first as? LoadAssetView
    assetThreeLoadAssetView = Bundle.main.loadNibNamed("LoadAssetView", owner: self, options: nil)?.first as? LoadAssetView
    
    assetsStackView.addArrangedSubview(assetOneLoadAssetView)
    assetsStackView.addArrangedSubview(assetTwoLoadAssetView)
    assetsStackView.addArrangedSubview(assetThreeLoadAssetView)

    // Actions for load asset views
    
    assetOneLoadAssetView.startStopLoadAssetButton.addTarget(self, action: #selector(assetStartStopAction(_:)), for: .touchUpInside)
    assetTwoLoadAssetView.startStopLoadAssetButton.addTarget(self, action: #selector(assetStartStopAction(_:)), for: .touchUpInside)
    assetThreeLoadAssetView.startStopLoadAssetButton.addTarget(self, action: #selector(assetStartStopAction(_:)), for: .touchUpInside)
    
    assetOneLoadAssetView.cancelLoadAssetButton.addTarget(self, action: #selector(assetCancelButtonAction(_:)), for: .touchUpInside)
    assetTwoLoadAssetView.cancelLoadAssetButton.addTarget(self, action: #selector(assetCancelButtonAction(_:)), for: .touchUpInside)
    assetThreeLoadAssetView.cancelLoadAssetButton.addTarget(self, action: #selector(assetCancelButtonAction(_:)), for: .touchUpInside)
  }
  
  private func configureUI() {
    
    // Assets names
    
    assetOneLoadAssetView.assetNameLabel.text   = "Asset 1 (\(Constants.embedCode1))"
    assetTwoLoadAssetView.assetNameLabel.text   = "Asset 2 (\(Constants.embedCode2))"
    assetThreeLoadAssetView.assetNameLabel.text = "Asset 3 (\(Constants.embedCode3))"
    
    // Assets progresses
    
    assetOneLoadAssetView.progressView.progress   = 0
    assetTwoLoadAssetView.progressView.progress   = 0
    assetThreeLoadAssetView.progressView.progress = 0
  }
  
  private func startStopActionFor(loadAssetView: LoadAssetView, embedCode: String) {
    switch loadAssetView.state {
    case .canceled:
      loadAssetView.state = .loading
      loadAssetView.progressView.progress = 0.0
      loadAssetView.startStopLoadAssetButton.setTitle("Pause", for: .normal)
      loadAssetView.cancelLoadAssetButton.isEnabled = true
      assetDownloadManager.authorizeDownload(embedCode: embedCode)
    case .loading:
      loadAssetView.state = .paused
      loadAssetView.startStopLoadAssetButton.setTitle("Load", for: .normal)
      assetDownloadManager.pauseDownloadingFile(embedCode: embedCode)
    case .paused:
      loadAssetView.state = .loading
      loadAssetView.startStopLoadAssetButton.setTitle("Pause", for: .normal)
      assetDownloadManager.resumeDownload(embedCode: embedCode)
    }
  }
  
  private func cancelActionFor(loadAssetView: LoadAssetView, embedCode: String) {
    assetDownloadManager.cancelDownload(embedCode: embedCode)
    loadAssetView.state = .canceled
    loadAssetView.startStopLoadAssetButton.setTitle("Load", for: .normal)
    loadAssetView.cancelLoadAssetButton.isEnabled = false
    loadAssetView.progressView.progress = 0.0
  }

  private func handlePercentageChanged(loadAssetView: LoadAssetView, percentage: Float64) {
    loadAssetView.progressView.progress = Float(percentage)
  }
  
  private func handleChangedCompletedDownload(loadAssetView: LoadAssetView, error: OOOoyalaError?) {
    if let _ = error {
      loadAssetView.progressView.progress = 0.0
    } else {
      loadAssetView.progressView.progress = 1.0
    }
    
    loadAssetView.state = .canceled
    loadAssetView.startStopLoadAssetButton.setTitle("Load", for: .normal)
    loadAssetView.cancelLoadAssetButton.isEnabled = false
  }
  
  private func assetNameFrom(embedCode: String) -> String {
    if embedCode == Constants.embedCode1 {
      return "Asset 1"
    } else if embedCode == Constants.embedCode2 {
      return "Asset 2"
    } else if embedCode == Constants.embedCode3 {
      return "Asset 3"
    }
    
    return "unknown asset"
  }
  
  // MARK: - Actions
  
  @objc private func assetStartStopAction(_ sender: UIButton) {
    if sender === assetOneLoadAssetView.startStopLoadAssetButton {
      startStopActionFor(loadAssetView: assetOneLoadAssetView, embedCode: Constants.embedCode1)
    } else if sender === assetTwoLoadAssetView.startStopLoadAssetButton {
      startStopActionFor(loadAssetView: assetTwoLoadAssetView, embedCode: Constants.embedCode2)
    } else if sender === assetThreeLoadAssetView.startStopLoadAssetButton {
      startStopActionFor(loadAssetView: assetThreeLoadAssetView, embedCode: Constants.embedCode3)
    }
  }
  
  @objc private func assetCancelButtonAction(_ sender: UIButton) {
    if sender === assetOneLoadAssetView.cancelLoadAssetButton {
      cancelActionFor(loadAssetView: assetOneLoadAssetView, embedCode: Constants.embedCode1)
    } else if sender === assetTwoLoadAssetView.cancelLoadAssetButton {
      cancelActionFor(loadAssetView: assetTwoLoadAssetView, embedCode: Constants.embedCode2)
    } else if sender === assetThreeLoadAssetView.cancelLoadAssetButton {
      cancelActionFor(loadAssetView: assetThreeLoadAssetView, embedCode: Constants.embedCode3)
    }
  }


}

// MARK: - AssetDownloadManagerDelegate

extension AssetDownloadViewController: AssetDownloadManagerDelegate {
  
  func downloadPercentage(percentage: Float64, embedCode: String) {
    
    if embedCode == Constants.embedCode1 {
      handlePercentageChanged(loadAssetView: assetOneLoadAssetView, percentage: percentage)
    } else if embedCode == Constants.embedCode2 {
      handlePercentageChanged(loadAssetView: assetTwoLoadAssetView, percentage: percentage)
    } else if embedCode == Constants.embedCode3 {
      handlePercentageChanged(loadAssetView: assetThreeLoadAssetView, percentage: percentage)
    }
    
    var log = logTextView.text ?? ""
    log = "\(log)\nload percentage - \(assetNameFrom(embedCode: embedCode)) - \(Int(percentage * 100))%"
    logTextView.text = log
  }
  
  func downloadCompletedAtLocation(location: URL?, embedCode: String, error: OOOoyalaError?) {
    
    if embedCode == Constants.embedCode1 {
      handleChangedCompletedDownload(loadAssetView: assetOneLoadAssetView, error: error)
    } else if embedCode == Constants.embedCode2 {
      handleChangedCompletedDownload(loadAssetView: assetTwoLoadAssetView, error: error)
    } else if embedCode == Constants.embedCode3 {
      handleChangedCompletedDownload(loadAssetView: assetThreeLoadAssetView, error: error)
    }
    
    var log = logTextView.text ?? ""
    
    if let error = error {
      log = "\(log)\ndownload completed - \(assetNameFrom(embedCode: embedCode)) with error - \(error) ❌"
    } else {
      log = "\(log)\ndownload completed - \(assetNameFrom(embedCode: embedCode)) ✅"
    }
   
    logTextView.text = log
  }
  
  func paused( embedCode: String) {
    var log = logTextView.text ?? ""

    log = "\(log)\npaused - \(assetNameFrom(embedCode: embedCode)) ⏸"
    
    logTextView.text = log
  }
  
  func resumed(embedCode: String) {
    var log = logTextView.text ?? ""
    
    log = "\(log)\nresumed - \(assetNameFrom(embedCode: embedCode))"
    
    logTextView.text = log
  }
  
  
}
