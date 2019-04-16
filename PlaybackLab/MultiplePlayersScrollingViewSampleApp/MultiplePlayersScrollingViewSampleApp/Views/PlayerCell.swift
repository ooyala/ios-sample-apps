//
//  PlayerCell.swift
//  MultiplePlayersScrollingViewSampleApp
//
//  Copyright © 2019 Ooyala. All rights reserved.
//

import UIKit

class PlayerCell: UICollectionViewCell {
  
  static let reuseId = "PlayerCellReuseIdentifier"
  
  public private(set) var playerSelectionOption: PlayerSelectionOption?
  public var playheadTime: Float64 = 0
  
  var titleLabel: UILabel!
  var videoView: UIView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    titleLabel = UILabel(frame: .zero)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.textAlignment = .center
    titleLabel.font = .boldSystemFont(ofSize: 17)
    titleLabel.text = ""
    
    videoView = UIView(frame: .zero)
    videoView.translatesAutoresizingMaskIntoConstraints = false
    videoView.backgroundColor = .black
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(videoView)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: 30),
      videoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
      videoView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      videoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(_ playerSelectionOption: PlayerSelectionOption) {
    self.playerSelectionOption = playerSelectionOption
  }
  
}
