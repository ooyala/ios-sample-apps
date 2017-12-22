//
//  ListOfVideosFactory.swift
//  VRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

import UIKit


class ListOfVideosFactory {
  
  // MARK: - Public functions
  
  func viewController(withVideoItem: VideoItem, pcode: String, domain: String, QAModeEnabled: Bool) -> UIViewController {
    var configuredViewController: UIViewController!
    
    switch withVideoItem.videoAdType {
    case .ima:
      configuredViewController = createIMAViewPlayerModule(withVideoItem: withVideoItem, pcode: pcode, domain: domain, QAModeEnabled: QAModeEnabled)
    default:
      configuredViewController = createDefaultVideoPlayerModule(withVideoItem: withVideoItem, pcode: pcode, domain: domain, QAModeEnabled: QAModeEnabled)
    }
    
    return configuredViewController
  }
  
  func configuredCustomVideoViewController(with completion: ((_ pCode: String, _ embedCode: String) -> Void)?) -> UIViewController {
     let customVideoViewController = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "CustomVideoViewController") as! CustomVideoViewController
    
    let customVideoViewModel = CustomVideoViewModel()
    
    customVideoViewController.viewModel = customVideoViewModel
    customVideoViewModel.delegate = customVideoViewController
    customVideoViewModel.completionBlock = completion
    
    return customVideoViewController
  }
  
  // MARK: - Private functions
  
  private func createDefaultVideoPlayerModule(withVideoItem: VideoItem, pcode: String, domain: String, QAModeEnabled: Bool) -> UIViewController {
    let videoPlayerViewModel = VideoPlayerViewModel(videoItem: withVideoItem, pcode: pcode, domain: domain, QAModeEnabled: QAModeEnabled)
    let videoPlayerViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DefaultVideoPlayerViewController") as! DefaultVideoPlayerViewController
    
    videoPlayerViewController.viewModel = videoPlayerViewModel
    
    return videoPlayerViewController
  }
  
  private func createIMAViewPlayerModule(withVideoItem: VideoItem, pcode: String, domain: String, QAModeEnabled: Bool) -> UIViewController {
    let videoPlayerViewModel = VideoPlayerViewModel(videoItem: withVideoItem, pcode: pcode, domain: domain, QAModeEnabled: QAModeEnabled)
    let videoPlayerViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IMAVideoPlayerViewController") as! IMAVideoPlayerViewController
    
    videoPlayerViewController.viewModel = videoPlayerViewModel
    
    return videoPlayerViewController
  }
  
  
}
