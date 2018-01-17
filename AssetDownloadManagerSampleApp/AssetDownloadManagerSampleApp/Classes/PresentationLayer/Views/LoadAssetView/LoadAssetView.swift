//
//  AssetView.swift
//  AssetDownloadManagerSmapleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

import UIKit


enum LoadAssetViewState {
  case loading
  case paused
  case canceled
}

class LoadAssetView: UIView {
 
  // MARK: - IBOutlets
  
  @IBOutlet weak var assetNameLabel: UILabel!
  @IBOutlet weak var startStopLoadAssetButton: UIButton!
  @IBOutlet weak var cancelLoadAssetButton: UIButton!
  @IBOutlet weak var progressView: UIProgressView!
  
  // MARK: - Public properties
  
  var state: LoadAssetViewState = .canceled
  
  
}
