//
//  ListOfVideosViewModel.swift
//  VRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

import Foundation

class ListOfVideosViewModel {

  // MARK: - Constants
  private enum Constants {
    static let defaultPCode = "BzY2syOq6kIK6PTXN7mmrGVSJEFj"
    static let defaultDomain = "http://www.ooyala.com"
    static let customVideoTitle = "Custom video"

  }

  // MARK: - Private properties
  private var testDataService = TestDataService()
  private var listOfVideosFactory = ListOfVideosFactory()
  private var testData: [VideItemSection] = []

  // MARK: - Initialization
  init() {
    // Load items
    testData = testDataService.testData
  }

  // MARK: - Public functions
  func getCountSections() -> Int {
    return testData.count
  }

  func getCountRowsIn(section: Int) -> Int {
    if section < testData.count {
      return testData[section].videoItems.count
    }

    return 0
  }

  func getVideoItemSectionAt(section: Int) -> VideItemSection? {
    return section < testData.count ? testData[section] : nil
  }

  func getVideoItemAt(indexPath: IndexPath) -> VideoItem? {
    if indexPath.section < testData.count {
      if indexPath.row < testData[indexPath.section].videoItems.count {
        return testData[indexPath.section].videoItems[indexPath.row]
      }
    }

    return nil
  }

  func configuredCustomVideoViewController(completion: ((_ videoItem: VideoItem) -> Void)?) -> UIViewController {
    return listOfVideosFactory.configuredCustomVideoViewController { pCode, embedCode in
      let videoItem = VideoItem(embedCode: embedCode, title: Constants.customVideoTitle)
      videoItem.pcode = pCode
      videoItem.videoAdType = .unknown

      completion?(videoItem)
    }
  }

  func configuredVideoViewController(withVideoItem: VideoItem,
                                     QAModeEnabled: Bool) -> UIViewController {
    var pcode: String

    if let videoItemPCode = withVideoItem.pcode {
      pcode = videoItemPCode
    } else {
      pcode = Constants.defaultPCode
    }

    return listOfVideosFactory.viewController(withVideoItem: withVideoItem,
                                              pcode: pcode,
                                              domain: Constants.defaultDomain,
                                              QAModeEnabled: QAModeEnabled)
  }
}
