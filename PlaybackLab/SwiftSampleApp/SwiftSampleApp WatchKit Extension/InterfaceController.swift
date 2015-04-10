//
//  InterfaceController.swift
//  SwiftSampleApp WatchKit Extension
//
//  Created by Yi Gu on 3/31/15.
//  Copyright (c) 2015 Ooyala Inc. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

  @IBOutlet var LabelPlayhead: WKInterfaceLabel!
  var timer:NSTimer? = NSTimer()
  
  override func awakeWithContext(context: AnyObject?) {
      super.awakeWithContext(context)
        
      // Configure interface objects here.
  }

  override func willActivate() {
      // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }

  override func didDeactivate() {
      // This method is called when watch view controller is no longer visible
      super.didDeactivate()
  }

  @IBAction func play() {
    if timer == nil  {
      timer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: "updatePlayheadTime", userInfo: nil, repeats: true)
    }
    
    // Send count to parent application
    var strAction = "play"
    var dictAppData: NSDictionary = NSDictionary(object: strAction, forKey: "action")
    
    // Handle receiver in app delegate or parent app
    WKInterfaceController.openParentApplication(dictAppData as [NSObject : AnyObject], reply: { (replyInfo, error) -> Void in
       println("\(replyInfo), \(error)")
    })
  }
  
  @IBAction func pause() {
    timer!.invalidate()
    timer = nil
    
    // Send count to parent application
    var strAction = "pause"
    var dictAppData: NSDictionary = NSDictionary(object: strAction, forKey: "action")
    
    // Handle receiver in app delegate or parent app
    WKInterfaceController.openParentApplication(dictAppData as [NSObject : AnyObject], reply: { (replyInfo, error) -> Void in
      println("\(replyInfo), \(error)")
    })
  }
  
  func updatePlayheadTime() {
    var strAction = "playheadUpdate"
    var dictAppData: NSDictionary = NSDictionary(object: strAction, forKey: "action")
    
    // Handle receiver in app delegate or parent app
    WKInterfaceController.openParentApplication(dictAppData as [NSObject : AnyObject], reply: { (replyInfo, error) -> Void in
      var playheadTime = replyInfo["playheadTime"]
      
      println("\(replyInfo), \(error)")
      println("playheadTime = \(playheadTime)")
      
      var playheadTimeData = playheadTime?.doubleValue
      var formatter = NSDateFormatter()
      formatter.dateFormat = playheadTimeData < 3600 ? "m:ss" : "H:mm:ss"
      self.LabelPlayhead.setText("Playhead: " + formatter.stringFromDate(NSDate(timeIntervalSince1970: playheadTimeData!)))
    })
  }
}
