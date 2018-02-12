//
//  AssetTableViewController.swift
//  SerializationDownloadsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

let PLAYER_SEGUE  = "PlayerViewControllerSegue"

class AssetTableViewController: UITableViewController, OptionTableViewCellDelegate {
  
  private let options = OptionDataSource.options()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
    tableView.bounces = false
    tableView.rowHeight = 75.0
    
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return options.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CELL_REUSE_IDENTIFIER, for: indexPath) as! OptionTableViewCell
    let option = options[indexPath.row] 
    cell.setup(delegate: self, option: option)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! OptionTableViewCell
    let option = cell.option as! PlayerSelectionOption
    let state = AssetPersistenceManager.shared.downloadState(forEmbedCode: option.embedCode)
    var alertActions: [UIAlertAction]
    
    switch state {
    case .assetNotDownloaded, .assetFailed:
      alertActions = [UIAlertAction(title: "Download",
                                    style: .default,
                                    handler: {(_ action: UIAlertAction) -> Void in
                                      AssetPersistenceManager.shared.startDownload(for: option)
      })]
    case .assetAuthorizing, .assetDownloading:
      alertActions = [UIAlertAction(title: "Pause",
                                    style: .default,
                                    handler: {(_ action: UIAlertAction) -> Void in
                                       AssetPersistenceManager.shared.pauseDownload(forEmbedCode: option.embedCode)
      }),
                      UIAlertAction(title: "Cancel",
                                    style: .default,
                                    handler: {(_ action: UIAlertAction) -> Void in
                                      AssetPersistenceManager.shared.cancelDownload(forEmbedCode: option.embedCode)
                      })]
    case .assetPaused:
      alertActions = [UIAlertAction(title: "Resume",
                                    style: .default,
                                    handler: {(_ action: UIAlertAction) -> Void in
                                      AssetPersistenceManager.shared.resumeDownload(forEmbedCode: option.embedCode)
      })]
    case .assetDownloaded:
      alertActions = [UIAlertAction(title: "Delete",
                                    style: .default,
                                    handler: {(_ action: UIAlertAction) -> Void in
                                      AssetPersistenceManager.shared.deleteDownloadedFile(forEmbedCode: option.embedCode)
      })]
    case .assetInQueue:
      alertActions = [UIAlertAction(title: "Cancel",
                                    style: .default,
                                    handler: {(_ action: UIAlertAction) -> Void in
                                      AssetPersistenceManager.shared.pauseDownload(forEmbedCode: option.embedCode)
      })]
    }
    
    let alertController = UIAlertController(title: option.title, message: "Select an option", preferredStyle: .actionSheet)
    for action: UIAlertAction in alertActions {
      alertController.addAction(action)
    }
    alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
    
    if UI_USER_INTERFACE_IDIOM() == .pad {
      alertController.popoverPresentationController?.sourceView = cell
      alertController.popoverPresentationController?.sourceRect = cell.bounds
    }
    present(alertController, animated: true) {() -> Void in }

  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // When tapping on a cell, we'll transition to the PlayerViewController.
    // If that's the case set the PlayerSelectionOption for the player.
    if let cell = sender as? OptionTableViewCell,
      let option = cell.option,
      segue.identifier == PLAYER_SEGUE {
      let playerViewController = segue.destination as! PlayerViewController
      playerViewController.setOption(option)
    }
  }
  
  // MARK: - OptionTableViewCellDelegate
  func optionCell(_ cell: OptionTableViewCell) {
    // The given cell is letting this delegate (table view) know that the download state of its asset changed.
    // Refresh the UI for that given cell.
    if let indexPath = tableView.indexPath(for: cell) {
      tableView.reloadRows(at: [indexPath], with: .automatic)
    }
  }
  
}
