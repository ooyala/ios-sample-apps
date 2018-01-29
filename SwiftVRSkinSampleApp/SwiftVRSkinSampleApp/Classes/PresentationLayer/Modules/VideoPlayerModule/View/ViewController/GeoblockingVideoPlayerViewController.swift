//
//  GeoblockingVideoPlayerViewController.swift
//  SwiftVRSkinSampleApp
//
//  Created by Ivan Sakharovskii on 1/27/18.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

import Foundation

class GeoblockingVideoPlayerViewController: DefaultVideoPlayerViewController, OOEmbedTokenGenerator {
  
  // MARK: - lifecycle
  
  override func viewDidLoad() {
    OOOoyalaPlayer.setEnvironment(OOOoyalaPlayerEnvironmentStaging)
    super.viewDidLoad()
    print("Called view did load for geoblocking")
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    OOOoyalaPlayer.setEnvironment(OOOoyalaPlayerEnvironmentProduction)
  }
  
  // MARK: - override functions
  
  override func definePlayer(pcode: String, domain: OOPlayerDomain?, options: OOOptions?) -> OOOoyalaPlayer {
    return OOOoyalaVRPlayer(pcode: pcode, domain: domain, embedTokenGenerator: self, options: options)
  }
  
  // MARK: - protocol implementation
  
  func token(forEmbedCodes embedCodes: [Any]!, callback: OOEmbedTokenCallback!) {
    var params = Dictionary<String, String>()
    params["account_id"] = viewModel.videoItem.accountId;
    let stringEmbedCodes = embedCodes as! [String]
    let uri = String(format: "/sas/embed_token/%@/%@", viewModel.pcode, stringEmbedCodes.joined(separator: ", "))
    let urlGen = OOEmbeddedSecureURLGenerator(apiKey: viewModel.videoItem.apiKey, secret: viewModel.videoItem.secretKey)
    let embedTokenUrl = urlGen?.secureURL("http://player.ooyala.com", uri: uri, params: params)
    callback(embedTokenUrl?.absoluteString)
  }
}
