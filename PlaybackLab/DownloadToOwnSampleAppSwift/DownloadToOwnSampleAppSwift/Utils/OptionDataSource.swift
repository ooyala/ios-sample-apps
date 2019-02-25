//
//  OptionDataSource.swift
//  DownloadToOwnSampleAppSwift
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import Foundation

class OptionDataSource {
  
  static var options: [PlayerSelectionOption] {
    return [
      PlayerSelectionOption(pcode: "c0cTkxOqALQviQIGAHWY5hP0q9gU",
                            embedCode: "JiOTdrdzqAujYa5qvnOxszbrTEuU5HMt",
                            title: "Clear HLS Video",
                            domain: OOPlayerDomain(string: "http://www.ooyala.com")),
      PlayerSelectionOption(pcode: "c0cTkxOqALQviQIGAHWY5hP0q9gU",
                            embedCode: "42cnNsMjE62UDH0JlCssXEPhxlhj1YBN",
                            title: "Clear HLS Main Profile",
                            domain: OOPlayerDomain(string: "http://www.ooyala.com")),
      PlayerSelectionOption(pcode: "c0cTkxOqALQviQIGAHWY5hP0q9gU",
                            embedCode: "V5ZnNsMjE6NRd7hfQYZibvDufNgB_233",
                            title: "Clear HLS Baseline Profile",
                            domain: OOPlayerDomain(string: "http://www.ooyala.com")),
      PlayerSelectionOption(pcode: "c0cTkxOqALQviQIGAHWY5hP0q9gU",
                            embedCode: "FlNXNsMjE6SvZO6iFmPgfXhG_PKX1yTJ",
                            title: "Clear HLS High Profile",
                            domain: OOPlayerDomain(string: "http://www.ooyala.com")),
      PlayerSelectionOption(pcode: "c0cTkxOqALQviQIGAHWY5hP0q9gU",
                            embedCode: "JiOTdrdzqAujYa5qvnOxszbrTEuU5Hat",
                            title: "Failed",
                            domain: OOPlayerDomain(string: "http://www.ooyala.com")),
      PlayerSelectionOption(pcode: "x0b2cyOupu0FFK5hCr4zXg8KKcrm",
                            embedCode: "cycDhnMzE66D5DPpy3oIOzli1HVMoYnJ",
                            title: "HLS Fairplay (unconfigured)",
                            domain: OOPlayerDomain(string: "http://www.ooyala.com"),
                            embedTokenGenerator: BasicEmbedTokenGenerator(pcode: "x0b2cyOupu0FFK5hCr4zXg8KKcrm",
                                                                          apiKey: "API_KEY",
                                                                          apiSecret: "API_SECRET",
                                                                          accountId: "ACCOUNT_ID",
                                                                          authorizeHost: "http://www.ooyala.com")),
      // if required, add more test cases here
    ]
  }

  static var dtoAssets: [OODtoAsset] {
    var assets: [OODtoAsset] = []
    for option in self.options {
      assets.append(buildDtoAsset(for: option))
    }
    return assets
  }

  private static func buildDtoAsset(for option: PlayerSelectionOption) -> OODtoAsset {
    let options                  = OOAssetDownloadOptions()
    options.pcode                = option.pcode
    options.embedCode            = option.embedCode
    options.domain               = option.domain
    options.embedTokenGenerator  = option.embedTokenGenerator
    options.allowsCellularAccess = false
    options.minimumBitrate       = 0
    return OODtoAsset(options: options, andName: option.title)
  }
}
