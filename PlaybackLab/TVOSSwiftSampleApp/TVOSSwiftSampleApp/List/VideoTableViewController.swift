//
//  ViewController.swift
//  TVOSSwiftSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class VideoTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  private var tableOptions = OptionDataSource.options
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: self.view.bounds)
    tableView.dataSource = self
    tableView.delegate = self
    return tableView
  }()
  private var rowHeight: CGFloat = 100

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.addSubview(tableView)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    tableView.frame = view.bounds
  }

  // MARK: - UITableViewDelegate
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    let option = tableOptions[indexPath.row]
    cell.textLabel?.text = option.title
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return rowHeight
  }
  
// MARK: - UITableViewDataSource's methods
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableOptions.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    let option = tableOptions[indexPath.row]
    performSegue(withIdentifier: option.segueName, sender: tableView.cellForRow(at: indexPath))
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = tableView.indexPathForSelectedRow else { return }
    switch segue.identifier {
    case "fullscreenSegue":
      guard let destination = segue.destination as? FullscreenPlayerViewController else { return }
      destination.option = tableOptions[indexPath.row]
    case "childSegue":
      guard let destination = segue.destination as? AbstractPlayerViewController else { return }
      destination.option = tableOptions[indexPath.row]
    case "playerTokenSegue":
      guard let destination = segue.destination as? OoyalaPlayerTokenPlayerViewController else { return }
      destination.option = tableOptions[indexPath.row]
    default:
      guard let destination = segue.destination as? FairplayPlayerViewController else { return }
      destination.option = tableOptions[indexPath.row]
    }
  }
}

