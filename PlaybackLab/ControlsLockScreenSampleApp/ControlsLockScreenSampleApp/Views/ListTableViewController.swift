//
//  ListTableViewController.swift
//  ControlsLockScreenSampleApp
//
//  Created by Carlos Ceja on 10/18/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
  
  private let options: [PlayerSelectionOption] = OptionDataSource.options()
  
  private var cellIdentifier: String = "cellOption"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
    tableView.bounces = false
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
  
  override var shouldAutorotate: Bool {
    return false
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return options.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    cell.textLabel?.text = options[indexPath.item].getTitle()
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let option = options[indexPath.item]
    let videoViewController: VideoViewController = VideoViewController.instantiate(with: option)
    show(videoViewController, sender: nil)
  }
  
}
