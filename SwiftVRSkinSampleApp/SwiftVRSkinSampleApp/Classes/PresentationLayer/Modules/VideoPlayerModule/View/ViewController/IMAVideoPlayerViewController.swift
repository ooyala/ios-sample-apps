//
//  IMAVideoPlayerViewController.swift
//  VRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

import UIKit

class IMAVideoPlayerViewController: DefaultVideoPlayerViewController {
  
  // MARK: - Private properties

  private var adsManager: OOIMAManager!
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureObjects()
  }
  
  // MARK: - Private functions
  
  private func configureObjects() {
    
    // Create ADS manager
    adsManager = OOIMAManager(ooyalaPlayer: skinController.player)
  }
  
  
}
