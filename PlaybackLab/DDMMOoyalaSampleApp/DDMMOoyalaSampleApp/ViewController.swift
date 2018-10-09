//
//  ViewController.swift
//  DDMMOoyalaSampleApp
//
//  Created by Eric Vargas on 10/8/18.
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit
import CapsGeneratorFramework

class MyPlayerInfo : OODefaultPlayerInfo {
  
  var myAdditionalParams: [AnyHashable : Any]?
  
  override var additionalParams: [AnyHashable : Any]? {
    get {
      return myAdditionalParams
    }
    set {
      myAdditionalParams = newValue
    }
  }
}

class ViewController: UIViewController {

  let embedCode = "Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1" // Clear HLS
  let pcode = "c0cTkxOqALQviQIGAHWY5hP0q9gU"
  let playerDomain = "https://www.ooyala.com"
  
  var playerVC: OOOoyalaPlayerViewController?
  
  @IBOutlet weak var playerView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let playerInfo = preparePlayerInfo()
    
    let options = OOOptions()
    options?.playerInfo = playerInfo
    
    let player = OOOoyalaPlayer(pcode: pcode, domain: OOPlayerDomain(string: playerDomain), options: options)
    self.playerVC = OOOoyalaPlayerViewController(player: player)
    
    self.addChild(self.playerVC!)
    self.playerView.addSubview(self.playerVC!.view)
    self.playerVC?.view.frame = self.playerView.frame
    
    self.playerVC?.player.setEmbedCode(self.embedCode)
    self.playerVC?.player.play()
  }
  
  func preparePlayerInfo() -> MyPlayerInfo {
    let capabilitiesB64 = CapsGenerator.getCapabilitiesJsonBase64()
    let playerInfo = MyPlayerInfo()
    playerInfo.additionalParams = ["ddmm_device_param": capabilitiesB64]
    
    return playerInfo
  }
}

