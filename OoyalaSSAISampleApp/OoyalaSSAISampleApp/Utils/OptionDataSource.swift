//
//  OptionDataSource.swift
//  OoyalaSSAISampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class OptionDataSource: NSObject {
  
  class func options() -> [PlayerSelectionOption] {
    return [
      PlayerSelectionOption(embedCode: "l5bm11ZjE6VFJyNE2iE6EKpCBVSRroAF",
                            pcode: "ZsdGgyOnugo44o442aALkge_dVVK",
                            title: "VOD - Ooyala Pulse",
                            adSetProvider: "ooyala_pulse",
                            domain: OOPlayerDomain(string: "http://www.ooyala.com")),
      PlayerSelectionOption(embedCode: "13bm11ZjE6Wl7CQ2iKPH_Z1VpspHGOud",
                            pcode: "ZsdGgyOnugo44o442aALkge_dVVK",
                            title: "VOD - DFP",
                            adSetProvider: "google_dfp",
                            domain: OOPlayerDomain(string: "http://www.ooyala.com")),
      // if required, add more test cases here
    ]
  }
  
}
