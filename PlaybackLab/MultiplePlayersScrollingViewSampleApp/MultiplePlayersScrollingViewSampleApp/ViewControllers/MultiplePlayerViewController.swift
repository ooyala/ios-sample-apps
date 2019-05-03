//
//  MultiplePlayerViewController.swift
//  MultiplePlayersScrollingViewSampleApp
//
//  Copyright © 2019 Ooyala. All rights reserved.
//

import UIKit

class MultiplePlayerViewController: UIViewController {
  
  let options = OptionDataSource.options
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.text = "Video Feed"
    label.textAlignment = .center
    label.font = .boldSystemFont(ofSize: 20)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    return layout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let collection = UICollectionView(frame: .zero,
                                      collectionViewLayout: self.collectionViewFlowLayout)
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.backgroundColor = .white
    collection.allowsSelection = false
    collection.delegate = self
    collection.dataSource = self
    collection.register(PlayerCell.self,
                        forCellWithReuseIdentifier: PlayerCell.reuseId)
    return collection
  }()
  
  private lazy var player: OOOoyalaPlayer = {
    let playerSelectionOption = options[0]
    var player: OOOoyalaPlayer
    var apiKey: String
    var apiSecret: String
    
    if playerSelectionOption.embedTokenGenerator != nil {
      if let basicEmbedTokenGenerator = playerSelectionOption.embedTokenGenerator as? BasicEmbedTokenGenerator {
        apiKey = basicEmbedTokenGenerator.apiKey
        apiSecret = basicEmbedTokenGenerator.apiSecret
      } else {
        // If you're not using the BasicEmbedTokenGenerator provided in the example,
        // supply your own API_KEY and API_SECRET
        apiKey = "API_KEY"
        apiSecret = "API_SECRET"
      }
      
      let options = OOOptions()
      // For this example, we use the OOEmbededSecureURLGenerator to create the signed URL on the client
      // This is not how this should be implemented in production -
      // In production, you should implement your own OOSecureURLGenerator
      // which contacts a server of your own, which will help sign the url with the appropriate API Key and Secret
      options.secureURLGenerator = OOEmbeddedSecureURLGenerator(apiKey: apiKey,
                                                                secret: apiSecret)
      
      player = OOOoyalaPlayer(pcode: playerSelectionOption.pcode,
                              domain: playerSelectionOption.domain,
                              embedTokenGenerator: playerSelectionOption.embedTokenGenerator,
                              options: options)
      
    } else {
      player = OOOoyalaPlayer(pcode: playerSelectionOption.pcode,
                              domain: playerSelectionOption.domain)
    }
    
    player.actionAtEnd = .pause
    return player
  }()
  
  private lazy var sharedPlayer: OOSkinViewController = {
    let jsCodeLocation = Bundle.main.url(forResource: "main",
                                         withExtension: "jsbundle")!
    
    let skinOptions = OOSkinOptions(discoveryOptions: nil,
                                    jsCodeLocation: jsCodeLocation,
                                    configFileName: "skin",
                                    overrideConfigs: nil)
    
    let skinViewController = OOSkinViewController(player: self.player,
                                                  skinOptions: skinOptions,
                                                  parent: UIView())
    
    skinViewController.isAutoFullscreenWithRotatedEnabled = true
    skinViewController.view.translatesAutoresizingMaskIntoConstraints = false
    
    return skinViewController
  }()
  
  var playerTimer: Timer!
  
  var currentItem = -1
  
  override func loadView() {
    super.loadView()
    
    view.addSubview(titleLabel)
    view.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 20),
      titleLabel.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: 20),
      collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
      collectionView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
      ])
    
    addObservers()
    initTimer()
  }
  
  func addObservers() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(currentItemChanged),
                                           name: NSNotification.Name.OOOoyalaPlayerCurrentItemChanged,
                                           object: sharedPlayer.player)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(playerStateHandler(_:)),
                                           name: NSNotification.Name.OOOoyalaPlayerStateChanged,
                                           object: sharedPlayer.player)
  }
  
  func initTimer() {
    if playerTimer != nil {
      playerTimer.invalidate()
    }
    
    playerTimer = Timer.scheduledTimer(timeInterval: 0.5,
                                       target: self,
                                       selector: #selector(runTimedCode),
                                       userInfo: nil,
                                       repeats: false)
  }
  
  @objc
  func runTimedCode() {
    var indexPath = IndexPath(item: 0, section: 0)
    var distTemp: CGFloat = CGFloat.greatestFiniteMagnitude
    for cell in collectionView.visibleCells {
      let t = collectionView.convert(cell.frame, to: collectionView.superview)
      let dist = distance(from: t, to: collectionView.contentOffset);
      if dist <= distTemp {
        indexPath = collectionView.indexPath(for: cell)!
        distTemp = dist
      }
    }
    
    if currentItem == indexPath.row {
      self.sharedPlayer.player.play()
      return
    }
    
    currentItem = indexPath.row
    let playerSelectionOption = options[currentItem]
    
    DispatchQueue.main.async {
      guard let cell = self.collectionView.cellForItem(at: indexPath) as? PlayerCell else { return }
      
      if Thread.isMainThread {
        self.sharedPlayer.player.setEmbedCode(playerSelectionOption.embedCode)
        
      }
    }
  }
  
  @objc
  func currentItemChanged() {
    guard let currentItem = sharedPlayer.player.currentItem,
      let index = options.firstIndex(where: { $0.embedCode == currentItem.embedCode }) else { return }
    let indexPath = IndexPath(row: index, section: 0)
    DispatchQueue.main.async {
      guard let cell = self.collectionView.cellForItem(at: indexPath) as? PlayerCell else { return }
      
      cell.titleLabel.text = "\(indexPath.row + 1).- \((self.sharedPlayer.player.currentItem.title)!)"
      cell.videoView.addSubview(self.sharedPlayer.view)
      NSLayoutConstraint.activate([
        self.sharedPlayer.view.topAnchor.constraint(equalTo: cell.videoView.topAnchor),
        self.sharedPlayer.view.bottomAnchor.constraint(equalTo: cell.videoView.bottomAnchor),
        self.sharedPlayer.view.trailingAnchor.constraint(equalTo: cell.videoView.trailingAnchor),
        self.sharedPlayer.view.leadingAnchor.constraint(equalTo: cell.videoView.leadingAnchor),
        ])
    }
  }
  
  @objc
  func playerStateHandler(_ notification: Notification) {
    let state = sharedPlayer.player.state()
    let playerSelectionOption = options[currentItem]
    if state == .ready {
      sharedPlayer.player.play(withInitialTime: playerSelectionOption.playheadTime)
    }
  }
  
  func distance(from rect: CGRect, to point: CGPoint) -> CGFloat {
    let dy = max(rect.minY - point.y, point.y - rect.maxY, 0)
    return dy
  }
  
}

extension MultiplePlayerViewController: UICollectionViewDelegate {
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    guard let currentItem = sharedPlayer.player.currentItem,
      let index = options.firstIndex(where: { $0.embedCode == currentItem.embedCode }) else { return }
    
    let indexPath = IndexPath(item: index, section: 0)
    let playerSelectionOption = options[indexPath.row]
    
    sharedPlayer.player.pause()
    playerSelectionOption.playheadTime = sharedPlayer.player.playheadTime()
    
    initTimer()
  }
  
}

extension MultiplePlayerViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return options.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCell.reuseId,
                                                        for: indexPath) as? PlayerCell else { fatalError() }
    return cell
  }
  
}

extension MultiplePlayerViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.bounds.size
  }
  
}
