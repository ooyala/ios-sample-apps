//
//  OptionDataSource.swift
//  MultiplePlayersScrollingViewSampleApp
//
//  Copyright © 2019 Ooyala. All rights reserved.
//

import UIKit

class OptionDataSource: NSObject {
  
  static var options: [PlayerSelectionOption] {
    return [
      PlayerSelectionOption(embedCode: "ljOGlqMzE65m9-MhcFAt1CTr1lEZTh_O",
                            pcode: "c0cTkxOqALQviQIGAHWY5hP0q9gU",
                            domain: OOPlayerDomain(string: "http://www.ooyala.com")),
      PlayerSelectionOption(embedCode: "92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww",
                            pcode: "c0cTkxOqALQviQIGAHWY5hP0q9gU",
                            domain: OOPlayerDomain(string: "http://www.ooyala.com")),
      PlayerSelectionOption(embedCode: "ZlNDlrMzE6WdC-u2rkmosREUwyXXljeZ",
                            pcode: "c0cTkxOqALQviQIGAHWY5hP0q9gU",
                            domain: OOPlayerDomain(string: "http://www.ooyala.com")),
      /*
       * The API Key and Secret should not be saved inside your applciation (even in git!).
       * However, for debugging you can use them to locally generate Ooyala Player Tokens.
       */
      /*PlayerSelectionOption(embedCode: "",
                            pcode: "",
                            domain: OOPlayerDomain(string: "http://www.ooyala.com"),
                            embedTokenGenerator: BasicEmbedTokenGenerator(pcode: "",
                                                                          apiKey: "API_KEY",
                                                                          apiSecret: "API_SECRET",
                                                                          accountId: "ACCOUNT_ID",
                                                                          authorizeHost: "http://www.ooyala.com"))*/
      // if required, add more test cases here
    ]
  }
  
}
