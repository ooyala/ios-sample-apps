//
//  OptionDataSource.swift
//  ControlsLockScreenSampleApp
//
//  Created by Carlos Ceja on 10/18/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

import Foundation

class OptionDataSource: NSObject {

  class func options() -> [PlayerSelectionOption] {
    return [
      PlayerSelectionOption(pcode: "c0cTkxOqALQviQIGAHWY5hP0q9gU",
                            embedCode: "JiOTdrdzqAujYa5qvnOxszbrTEuU5HMt",
                            title: "HLS Clear",
                            thumbnailURL: URL(string: "https://pbs.twimg.com/profile_images/519213440733171712/-Hwz3vF3.png")!,
                            domain: OOPlayerDomain(string: "http://www.ooyala.com")),
      PlayerSelectionOption(pcode: "x0b2cyOupu0FFK5hCr4zXg8KKcrm",
                            embedCode: "cycDhnMzE66D5DPpy3oIOzli1HVMoYnJ",
                            title: "HLS Fairplay (unconfigured)",
                            thumbnailURL: URL(string: "https://pbs.twimg.com/profile_images/519213440733171712/-Hwz3vF3.png")!,
                            domain: OOPlayerDomain(string: "http://www.ooyala.com"),
                            embedTokenGenerator: BasicEmbedTokenGenerator(pcode: "x0b2cyOupu0FFK5hCr4zXg8KKcrm",
                                                                          apiKey: "API_KEY",
                                                                          apiSecret: "API_SECRET",
                                                                          accountId: "",
                                                                          authorizeHost: "http://www.ooyala.com"))
      // if required, add more test cases here
    ]
  }
  
}
