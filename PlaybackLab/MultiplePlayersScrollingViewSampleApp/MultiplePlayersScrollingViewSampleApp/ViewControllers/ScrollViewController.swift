//
//  ScrollViewController.swift
//  MultiplePlayersScrollingViewSampleApp
//
//  Copyright © 2019 Ooyala. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  
  let options = OptionDataSource.options()
  var players = [PlayerView]()
  
  var currentIndex: Int!
  var playerTimer: Timer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // add the scroll view to self.view
    scrollView.delegate = self
    view.addSubview(scrollView)
    
    var yPosition: CGFloat = 10.0
    for playerOption in options {
      let player = PlayerView(playerSelectionOption: playerOption)
      player.translatesAutoresizingMaskIntoConstraints = true
      player.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      player.center.x = view.center.x
      player.frame.origin.y = yPosition
      yPosition += player.frame.height + 10.0
      players.append(player)
      scrollView.addSubview(player)
    }
    
    let sizeOfContent: CGFloat = (players.last?.frame.maxY ?? UIScreen.main.bounds.height) + 10
    scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: sizeOfContent)
    
    playerTimer = Timer.scheduledTimer(timeInterval: 0.5,
                                       target: self,
                                       selector: #selector(runTimedCode),
                                       userInfo: nil,
                                       repeats: false)
  }
  
  @objc
  func fullscreentest(_ notification: Notification) {
    print("")
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
}

extension ScrollViewController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if currentIndex != nil {
      players[currentIndex].skinController.player.pause()
    }
    
    if playerTimer != nil {
      playerTimer.invalidate()
      playerTimer = nil
    }
    
    playerTimer = Timer.scheduledTimer(timeInterval: 0.5,
                                       target: self,
                                       selector: #selector(runTimedCode),
                                       userInfo: nil,
                                       repeats: false)
    
  }
  
  @objc
  func runTimedCode() {
    currentIndex = players.firstIndex(where: { scrollView.bounds.contains($0.frame)} )
    
    if currentIndex == nil {
      return
    }
    
    if players[currentIndex].skinController.player.currentItem == nil {
      players[currentIndex].skinController.player.setEmbedCode(options[currentIndex].embedCode)
    }
    players[currentIndex].skinController.player.play()
  }
  
}
