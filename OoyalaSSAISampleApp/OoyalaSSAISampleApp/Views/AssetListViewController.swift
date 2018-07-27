//
//  AssetListViewController.swift
//  OoyalaSSAISampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class AssetListViewController: UIViewController, UITableViewDataSource {

  @IBOutlet weak var swtSkin: UISwitch!
  @IBOutlet weak var swtQA: UISwitch!
  @IBOutlet weak var tableAssetList: UITableView!
  
  private let PLAYER_SEGUE_IDENTIFIER = "PlayerViewControllerSegue"
  private let CELL_REUSE_IDENTIFIER = "OptionCellReuseIdentifier"
  
  private let options = OptionDataSource.options()
  private var useSkin = false
  private var qaLogEnabled = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableAssetList.tableFooterView = UIView()
    tableAssetList.bounces = false
    
    swtSkin.addTarget(self, action: #selector(switchSkinChanged(mySwitch:)), for: .valueChanged)
    swtQA.addTarget(self, action: #selector(switchQAChanged(mySwitch:)), for: .valueChanged)
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
  
  // MARK: - UITableViewDataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return options.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CELL_REUSE_IDENTIFIER, for: indexPath)
    cell.textLabel?.text = options[indexPath.row].title
    return cell
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // When tapping on a cell, we'll transition to the PlayerViewController.
    // If that's the case set the PlayerSelectionOption for the player.
    if let indexPath = tableAssetList.indexPathForSelectedRow,
      segue.identifier == PLAYER_SEGUE_IDENTIFIER {
      let playerViewController = segue.destination as! PlayerViewController
      playerViewController.option = options[indexPath.row]
      playerViewController.usesSkin = useSkin
      playerViewController.qaLogEnabled = qaLogEnabled
    }
  }
  
  // MARK: - Switches
  @objc
  private func switchSkinChanged(mySwitch: UISwitch) {
    useSkin = mySwitch.isOn
  }
  
  @objc
  private func switchQAChanged(mySwitch: UISwitch) {
    qaLogEnabled = mySwitch.isOn
  }
  
}
