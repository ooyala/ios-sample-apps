//
//  MultiplePlayerViewController.swift
//  MultiplePlayersScrollingViewSampleApp
//
//  Copyright © 2019 Ooyala. All rights reserved.
//

import UIKit

class MultiplePlayerViewController: UIViewController {
  
  // MARK: - Properties

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
                                      collectionViewLayout: collectionViewFlowLayout)
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
    
    player.actionAtEnd = .reset
    return player
  }()
  
  private lazy var sharedPlayer: OOSkinViewController = {
    guard let jsCodeLocation = Bundle.main.url(forResource: "main",
                                               withExtension: "jsbundle") else { fatalError() }

    // guard let jsCodeLocation = URL(string: "http://localhost:8081/index.ios.bundle?platform=ios") else { fatalError() }

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
  
  private var playerTimer: Timer!
  private var currentItemIndex = -1
  fileprivate var isScrolling = false

  // MARK: - Life cycle
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
  
  // MARK: - Private methods
  private func addObservers() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(currentItemChanged),
                                           name: NSNotification.Name.OOOoyalaPlayerCurrentItemChanged,
                                           object: sharedPlayer.player)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(playerStateHandler(_:)),
                                           name: NSNotification.Name.OOOoyalaPlayerStateChanged,
                                           object: sharedPlayer.player)

    NotificationCenter.default.addObserver(self,
                                           selector: #selector(playerSeekCompleted(_:)),
                                           name: NSNotification.Name.OOOoyalaPlayerSeekCompleted,
                                           object: sharedPlayer.player)

    NotificationCenter.default.addObserver(self,
                                           selector: #selector(playerTimeChanged(_:)),
                                           name: NSNotification.Name.OOOoyalaPlayerTimeChanged,
                                           object: sharedPlayer.player)

    NotificationCenter.default.addObserver(self,
                                           selector: #selector(fullscreenChanged(_:)),
                                           name: NSNotification.Name.OOSkinViewControllerFullscreenChanged,
                                           object: sharedPlayer)
  }
  
  fileprivate func initTimer() {
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
    var indexPathForVisibleCell = IndexPath(item: 0, section: 0)
    let visibleCells = collectionView.visibleCells
    var tmpRatio: CGFloat = 0.0
    for cell in visibleCells {
      let cellRect = collectionView.convert(cell.frame, to: collectionView.superview)
      let intersect = collectionView.frame.intersection(cellRect)
      let visibleHeight = intersect.height
      let cellHeight = cellRect.height
      let ratio = visibleHeight / cellHeight
      if ratio > tmpRatio {
        indexPathForVisibleCell = collectionView.indexPath(for: cell)!
        tmpRatio = ratio
      }
    }
    
    var playerSelectionOption = options[indexPathForVisibleCell.row]
    
    if currentItemIndex == indexPathForVisibleCell.row {
      if !playerSelectionOption.isPaused {
        sharedPlayer.player.play(withInitialTime: playerSelectionOption.playheadTime)
      } else {
        sharedPlayer.player.seek(playerSelectionOption.playheadTime)
      }
      return
    } else {
      currentItemIndex = indexPathForVisibleCell.row
      playerSelectionOption = options[currentItemIndex]
      DispatchQueue.main.async {
        if Thread.isMainThread {
          self.sharedPlayer.player.setEmbedCode(playerSelectionOption.embedCode)
        }
      }
    }
  }
  
  private func displayPlayerOnCell(_ indexPath: IndexPath) {
    DispatchQueue.main.async {
      guard let cell = self.collectionView.cellForItem(at: indexPath) as? PlayerCell else { return }
      cell.titleLabel.text = "\(indexPath.row + 1).- \((self.sharedPlayer.player.currentItem.title)!)"
      cell.videoView.subviews.forEach({ $0.removeFromSuperview() })
      cell.videoView.addSubview(self.sharedPlayer.view)
      NSLayoutConstraint.activate([
        self.sharedPlayer.view.topAnchor.constraint(equalTo: cell.videoView.topAnchor),
        self.sharedPlayer.view.bottomAnchor.constraint(equalTo: cell.videoView.bottomAnchor),
        self.sharedPlayer.view.trailingAnchor.constraint(equalTo: cell.videoView.trailingAnchor),
        self.sharedPlayer.view.leadingAnchor.constraint(equalTo: cell.videoView.leadingAnchor),
        ])
    }
  }
  
  // MARK: - Observer handlers
  @objc
  func currentItemChanged() {
    isScrolling = false
    guard let currentItem = sharedPlayer.player.currentItem,
      let index = options.firstIndex(where: { $0.embedCode == currentItem.embedCode }) else { return }
    let indexPath = IndexPath(row: index, section: 0)
    displayPlayerOnCell(indexPath)
  }

  @objc
  func playerStateHandler(_ notification: Notification) {
    if isScrolling {
      return
    }

    let state = sharedPlayer.player.state()
    let playerSelectionOption = options[currentItemIndex]
    
    print("Ooyala Player State: \(String(describing: OOOoyalaPlayerStateConverter.playerState(toString: state)!))")

    switch (state) {
    case .ready:
      if !playerSelectionOption.isPaused {
        sharedPlayer.player.play(withInitialTime: playerSelectionOption.playheadTime)
      } else {
        sharedPlayer.player.seek(playerSelectionOption.playheadTime)
      }
      break
    case .playing:
      playerSelectionOption.isPaused = false
      break
    case .paused:
      playerSelectionOption.isPaused = true
      break
    case .completed:
      playerSelectionOption.playheadTime = 0.0
      break
    default:
      break
    }
  }
  
  @objc
  func playerTimeChanged(_ notification: Notification) {
    if isScrolling {
      return
    }
    let playerSelectionOption = options[currentItemIndex]
    playerSelectionOption.playheadTime = sharedPlayer.player.playheadTime()
  }

  @objc
  func playerSeekCompleted(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
      let seekInfo = userInfo["seekInfo"] as? OOSeekInfo else { return }
    let playerSelectionOption = options[currentItemIndex]
    playerSelectionOption.playheadTime = seekInfo.seekEnd
  }
  
  @objc
  func fullscreenChanged(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
      let isFullscreen = userInfo["fullscreen"] as? Bool else { return }

    if !isFullscreen {
      let indexPath = IndexPath(row: currentItemIndex, section: 0)
      collectionView.scrollToItem(at: indexPath,
                                  at: .centeredVertically,
                                  animated: false)
      displayPlayerOnCell(indexPath)
    }
  }

}

// MARK: - UICollectionViewDelegate

extension MultiplePlayerViewController: UICollectionViewDelegate {
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    isScrolling = true
    sharedPlayer.player.pause()
    initTimer()
  }
  
}

// MARK: - UICollectionViewDataSource

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

// MARK: - UICollectionViewDelegateFlowLayout

extension MultiplePlayerViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.bounds.size
  }
  
}
