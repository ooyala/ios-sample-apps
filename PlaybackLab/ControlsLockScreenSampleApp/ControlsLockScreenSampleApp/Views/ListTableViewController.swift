//
//  ListTableViewController.swift
//  ControlsLockScreenSampleApp
//
//  Copyright © 2017 Ooyala. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
  
  // MARK: - Constants
  private let PLAYER_SEGUE = "PlayerViewControllerSegue"
  
  // MARK: - Private properties
  private let options: [PlayerSelectionOption] = OptionDataSource.options
  
  // MARK: - View controller lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
    tableView.bounces = false
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return options.count
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let option = options[indexPath.item]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER,
                                                   for: indexPath) as? OptionTableViewCell else { return UITableViewCell() }
    cell.option = option
    cell.textLabel?.text = option.title
    return cell
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // When tapping on a cell, we'll transition to the PlayerViewController.
    // If that's the case set the PlayerSelectionOption for the player.
    
    if let cell = sender as? OptionTableViewCell,
      let option = cell.option,
      segue.identifier == PLAYER_SEGUE {
      let playerViewController = segue.destination as! PlayerViewController
      playerViewController.option = option
    }
  }
  
}
