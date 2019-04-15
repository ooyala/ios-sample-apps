//
//  InterfaceController.swift
//  SwiftSampleApp WatchKit Extension
//
//  Created on 3/31/15.
//  Copyright (c) 2015 Ooyala Inc. All rights reserved.
//

import WatchKit
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

  @IBOutlet var LabelPlayhead: WKInterfaceLabel!

  let session = WCSession.default

  override func awake(withContext context: Any?) {
    super.awake(withContext: context)

    processApplicationContext()

    session.delegate = self
    session.activate()
  }

  @IBAction func play() {
  }

  @IBAction func pause() {
  }

  @objc func updatePlayheadTime() {
  }

  func session(_ session: WCSession,
               activationDidCompleteWith activationState: WCSessionActivationState,
               error: Error?) {
    DispatchQueue.main.async() {
      self.processApplicationContext()
    }
  }

  func processApplicationContext() {
  }

}
