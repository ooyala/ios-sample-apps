//
//  ListOfVideosViewController.swift
//  VRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

import UIKit


class ListOfVideosViewController: UIViewController {
  
  // MARK: - Public properties
  
  var viewModel: ListOfVideosViewModel!
  
  // MARK: - Private properties
  private var QAModeSwitch: UISwitch!
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavigationBar()
  }
  
  // MARK: - Private functions
  
  private func configureNavigationBar() {
    
    // Add QA switch
    
    QAModeSwitch = UISwitch()
    let QALabel = UILabel(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    
    QALabel.textAlignment = .right
    QALabel.text = "QA"
    
    let QASwitchBarButtonItem = UIBarButtonItem(customView: QAModeSwitch)
    let QALabelBarButtonItem = UIBarButtonItem(customView: QALabel)
    
    // Add custom video bar button item
    
    let customVideoBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add, target: self, action: #selector(customVideoBarButtonAction))
    
    // Add elements to navigation bar
    
    navigationItem.rightBarButtonItems = [QASwitchBarButtonItem, QALabelBarButtonItem]
    navigationItem.leftBarButtonItems = [customVideoBarButtonItem]
  }
  
  private func showCustomVideoItemViewController() {
    let customVideoViewController = viewModel.configuredCustomVideoViewController(completion: { videoItem in
      self.openVideoPlayerModule(withVideoItem: videoItem)
    })
    
    self.present(customVideoViewController, animated: true, completion: nil)
  }
    
  private func openVideoPlayerModule(withVideoItem: VideoItem) {
    let viewController = viewModel.configuredVideoViewController(
      withVideoItem: withVideoItem, QAModeEnabled: QAModeSwitch.isOn)
    
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  // MARK: - Actions
  
  @objc private func customVideoBarButtonAction(_ sender: Any?) {
    showCustomVideoItemViewController()
  }
  
  
}

// MARK: - UITableViewDataSource

extension ListOfVideosViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.getCountSections()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getCountRowsIn(section: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "ListOfVideosViewControllerTableViewCellID")
    
    if cell == nil {
      cell = UITableViewCell(style: .default, reuseIdentifier: "ListOfVideosViewControllerTableViewCellID")
    }
    
    if let videoItem = viewModel.getVideoItemAt(indexPath: indexPath) {
      cell?.textLabel?.text = videoItem.title
    } else {
      cell?.textLabel?.text = "Unknow video"
    }
    
    return cell!
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if let videItemSection = viewModel.getVideoItemSectionAt(section: section) {
      return videItemSection.title
    }
    
    return "Unknow section title"
  }
  
  
}

// MARK: - UITableViewDelegate

extension ListOfVideosViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let videoItem = viewModel.getVideoItemAt(indexPath: indexPath) {
      openVideoPlayerModule(withVideoItem: videoItem)
    }
  }
  
  
}
