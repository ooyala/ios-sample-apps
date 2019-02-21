//
//  OptionTableViewCell.swift
//  DownloadToOwnSampleAppSwift
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

  static let reuseId = "OptionCellReuseIdentifier"
  /**
   Shows the title of the asset
   */
  @IBOutlet weak var titleLabel: UILabel!
  /**
   Shows the download state of the asset
   */
  @IBOutlet weak var subtitleLabel: UILabel!
  /**
   Shows the percentage progress of an active download.
   */
  @IBOutlet weak var downloadProgressView: UIProgressView!
}
