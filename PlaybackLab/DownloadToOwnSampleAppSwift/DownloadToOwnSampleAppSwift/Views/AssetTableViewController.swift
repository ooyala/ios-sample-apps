//
//  AssetTableViewController.swift
//  DownloadToOwnSampleAppSwift
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class AssetTableViewController: UITableViewController {
  
  private let dtoAssets = OptionDataSource.dtoAssets
  private var selectedIndexPath: IndexPath?
  private let playerSegue  = "PlayerViewControllerSegue"

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
    tableView.bounces = false

    reloadSelectedCell()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    reloadSelectedCell()
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }

  private func reloadSelectedCell() {
    guard let notNilSelectedIndexPath = selectedIndexPath else { return }
    let dtoAsset = dtoAssets[notNilSelectedIndexPath.row]

    guard let cell = tableView.cellForRow(at: notNilSelectedIndexPath) as? OptionTableViewCell else { return }
    cell.subtitleLabel.text = dtoAsset.stateText
    let showProgress = dtoAsset.state == .downloading || dtoAsset.state == .paused
    cell.downloadProgressView.isHidden = !showProgress

    dtoAsset.progress { progress in
      DispatchQueue.main.async {
        cell.downloadProgressView.isHidden = false
        cell.subtitleLabel.text = "\(dtoAsset.stateText) \(dtoAsset.currentDownload ?? "") \(progress * 100)"
        cell.downloadProgressView.progress = Float(progress)
      }
    }

    dtoAsset.finish { relativePath in
      DispatchQueue.main.async {
        guard let path = self.selectedIndexPath else { return }
        self.tableView.reloadRows(at: [path], with: .fade)
      }
    }
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dtoAssets.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.reuseId,
                                                   for: indexPath) as? OptionTableViewCell else {
      return UITableViewCell()
    }
    let dtoAsset = dtoAssets[indexPath.row]
    cell.downloadProgressView.isHidden = true
    cell.titleLabel.text = dtoAsset.name
    cell.subtitleLabel.text = dtoAsset.stateText

    return cell
  }
  
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? OptionTableViewCell else { return }

    let dtoAsset = dtoAssets[indexPath.row]

    var alertActions: [UIAlertAction]
    
    switch dtoAsset.state {
    case .notDownloaded:
      alertActions = [UIAlertAction(title: "Download",
                                    style: .default,
                                    handler: { action in
        cell.downloadProgressView.isHidden = false
        cell.downloadProgressView.progress = 0
        cell.subtitleLabel.text = "Authorizing"

        dtoAsset.download(progressClosure: { progress in
          DispatchQueue.main.async {
            cell.subtitleLabel.text = "\(dtoAsset.stateText) \(dtoAsset.currentDownload ?? "") \(progress * 100)"
            cell.downloadProgressView.progress = Float(progress)
          }
        })

        dtoAsset.finish(relativePath: { _ in
          DispatchQueue.main.async {
            self.tableView.reloadRows(at: [indexPath], with: .left)
          }
        })

        dtoAsset.onErrorWithErrorClosure({ error in
          DispatchQueue.main.async {
            self.tableView.reloadRows(at: [indexPath], with: .right)
            print("Error occured: \(error?.message ?? "")")
          }
        })
      })]

    case .authorizing, .downloading:
      alertActions = [UIAlertAction(title: "Pause",
                                    style: .default,
                                    handler: { action in
        dtoAsset.pauseDownload()
        DispatchQueue.main.async {
          cell.subtitleLabel.text = dtoAsset.stateText
        }
      }),
                      UIAlertAction(title: "Cancel",
                                    style: .default,
                                    handler: { action in
        dtoAsset.cancelDownload()
      })]

    case .paused:
      alertActions = [UIAlertAction(title: "Resume",
                                    style: .default,
                                    handler: { action in
        dtoAsset.resumeDownload()
      })]

    case .downloaded:
      alertActions = [UIAlertAction(title: "Delete",
                                    style: .default,
                                    handler: { action in
        dtoAsset.delete()
        self.tableView.reloadRows(at: [indexPath], with: .left)
      })]

    @unknown default:
      fatalError()
    }
    
    let alertController = UIAlertController(title: dtoAsset.name,
                                            message: "Select an option",
                                            preferredStyle: .actionSheet)
    for action: UIAlertAction in alertActions {
      alertController.addAction(action)
    }
    alertController.addAction(UIAlertAction(title: "Dismiss",
                                            style: .cancel,
                                            handler: nil))
    
    if UI_USER_INTERFACE_IDIOM() == .pad {
      alertController.popoverPresentationController?.sourceView = cell
      alertController.popoverPresentationController?.sourceRect = cell.bounds
    }
    present(alertController, animated: true, completion: nil)
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let dtoAsset = dtoAssets[indexPath.row]
    selectedIndexPath = indexPath
    performSegue(withIdentifier: playerSegue, sender: dtoAsset)
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let dtoAsset = sender as? OODtoAsset,
       segue.identifier == playerSegue {
      guard let playerViewController = segue.destination as? PlayerViewController else { return }
      playerViewController.dtoAsset = dtoAsset
    }
  }

}
