//
//  TestDataService.swift
//  VRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

import Foundation

class TestDataService {
}

// MARK: - TestDataServiceProtocol
extension TestDataService: TestDataServiceProtocol {

  var testData: [VideItemSection] {
    guard let pathToTestDataJSON = Bundle.main.path(forResource: "data",
                                                    ofType: "json") else { return [] }

    do {
      let urlToTestDataJSON = URL(fileURLWithPath: pathToTestDataJSON)
      let jsonData = try Data(contentsOf: urlToTestDataJSON)
      let json = try JSONSerialization.jsonObject(with: jsonData,
                                                  options: .allowFragments)

      return VideItemSection.createCollection(fromJSON: json) ?? []
    } catch {
      return []
    }
  }
}
