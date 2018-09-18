//
//  ViewController.swift
//  DDMMSampleApp
//
//  Created by Eric Vargas on 9/18/18.
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit
import CapsGeneratorFramework

class ViewController: UIViewController {

  @IBOutlet weak var playerView: UIView!
  let pcode = "c0cTkxOqALQviQIGAHWY5hP0q9gU"
  let embedCode = "Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
  let domain = "http://www.ooyala.com"
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func setupOoyalaPlayer() {
    
    let playerInfo = MyPlayerInfo()
    let myParams = ["ddmm_device_param": "myVal"]
    playerInfo.additionalParams = myParams
    let options = OOOptions()
    options?.playerInfo = playerInfo
    let player = OOOoyalaPlayer(pcode: self.pcode, domain: OOPlayerDomain(string: self.domain), options: options)
  }
}

class MyPlayerInfo: OODefaultPlayerInfo {
  var myOverridenParams: [AnyHashable: Any]?
  
  override var additionalParams: [AnyHashable : Any]? {
    get {
      return myOverridenParams
    }
    
    set {
      myOverridenParams = newValue
    }
  }
}
