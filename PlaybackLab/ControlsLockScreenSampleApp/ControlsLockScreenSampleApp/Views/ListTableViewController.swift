//
//  ListTableViewController.swift
//  ControlsLockScreenSampleApp
//
//  Copyright © 2017 Ooyala. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
  
  private let PLAYER_SEGUE: String = "PlayerViewControllerSegue"
    
  private let options: [PlayerSelectionOption] = OptionDataSource.options()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
    tableView.bounces = false
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return options.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let option: PlayerSelectionOption = options[indexPath.item]
    let cell: OptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as! OptionTableViewCell
    cell.option = option
    cell.textLabel?.text = option.title
    return cell
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // When tapping on a cell, we'll transition to the PlayerViewController.
    // If that's the case set the PlayerSelectionOption for the player.
    
    if let cell: OptionTableViewCell = sender as? OptionTableViewCell,
      let option: PlayerSelectionOption = cell.option,
      segue.identifier == PLAYER_SEGUE {
      let playerViewController = segue.destination as! PlayerViewController
      playerViewController.option = option
    }
  }
  
}
