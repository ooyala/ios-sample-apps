//
//  PlayerCell.swift
//  MultiplePlayersScrollingViewSampleApp
//
//  Copyright © 2019 Ooyala. All rights reserved.
//

import UIKit

class PlayerCell: UICollectionViewCell {
  
  static let reuseId = "PlayerCellReuseIdentifier"
  
  public private(set) lazy var titleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = ""
    label.textAlignment = .center
    label.font = .boldSystemFont(ofSize: 17)
    return label
  }()
  
  public lazy var videoView: UIView = {
    let view = UIView(frame: .zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .black
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
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
  
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = ""
    videoView.subviews.forEach({ $0.removeFromSuperview() })
  }
  
}
