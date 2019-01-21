//
//  ListOfVideosFactory.swift
//  VRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

import UIKit

class ListOfVideosFactory {
  // MARK: - Public functions
  func viewController(withVideoItem: VideoItem,
                      pcode: String,
                      domain: String,
                      QAModeEnabled: Bool) -> UIViewController {
    var configuredViewController: UIViewController

    switch withVideoItem.videoAdType {
    case .ima:
      configuredViewController = createIMAViewPlayerModule(withVideoItem: withVideoItem,
                                                           pcode: pcode,
                                                           domain: domain,
                                                           QAModeEnabled: QAModeEnabled)
    default:
      configuredViewController = createDefaultVideoPlayerModule(withVideoItem: withVideoItem,
                                                                pcode: pcode,
                                                                domain: domain,
                                                                QAModeEnabled: QAModeEnabled)
    }

    return configuredViewController
  }

  func configuredCustomVideoViewController(with
    completion: ((_ pCode: String, _ embedCode: String) -> Void)?) -> UIViewController {

    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    guard let customVideoViewController =
      mainStoryboard.instantiateViewController(withIdentifier: "CustomVideoViewController")
        as? CustomVideoViewController else {
        return UIViewController()
    }

    let customVideoViewModel = CustomVideoViewModel()
    customVideoViewController.viewModel = customVideoViewModel
    customVideoViewModel.delegate = customVideoViewController
    customVideoViewModel.completionBlock = completion

    return customVideoViewController
  }

  // MARK: - Private functions
  private func createDefaultVideoPlayerModule(withVideoItem: VideoItem,
                                              pcode: String,
                                              domain: String,
                                              QAModeEnabled: Bool) -> UIViewController {
    let videoPlayerViewModel = VideoPlayerViewModel(videoItem: withVideoItem,
                                                    pcode: pcode,
                                                    domain: domain,
                                                    QAModeEnabled: QAModeEnabled)
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    guard let videoPlayerViewController =
      mainStoryboard.instantiateViewController(withIdentifier: "DefaultVideoPlayerViewController")
        as? DefaultVideoPlayerViewController else {
      return UIViewController()
    }

    videoPlayerViewController.viewModel = videoPlayerViewModel

    return videoPlayerViewController
  }

  private func createIMAViewPlayerModule(withVideoItem: VideoItem,
                                         pcode: String,
                                         domain: String,
                                         QAModeEnabled: Bool) -> UIViewController {
    let videoPlayerViewModel = VideoPlayerViewModel(videoItem: withVideoItem,
                                                    pcode: pcode,
                                                    domain: domain,
                                                    QAModeEnabled: QAModeEnabled)
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    guard let videoPlayerViewController =
      mainStoryboard.instantiateViewController(withIdentifier: "IMAVideoPlayerViewController")
        as? IMAVideoPlayerViewController else {
      return UIViewController()
    }

    videoPlayerViewController.viewModel = videoPlayerViewModel

    return videoPlayerViewController
  }
}
