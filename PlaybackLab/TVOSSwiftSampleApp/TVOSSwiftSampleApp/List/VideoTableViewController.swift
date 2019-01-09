//
//  ViewController.swift
//  TVOSSwiftSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class VideoTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  private var tableOptions : [PlayerSelectionOption] = []
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
    populateOptions()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    tableView.frame = view.bounds
  }
  
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
      guard let destination = segue.destination as? FullscreenPlayerViewController else {return}
      destination.option = tableOptions[indexPath.row]
    case "childSegue":
      guard let destination = segue.destination as? AbstractPlayerViewController else {return}
      destination.option = tableOptions[indexPath.row]
    case "playerTokenSegue":
      guard let destination = segue.destination as? OoyalaPlayerTokenPlayerViewController else {return}
      destination.option = tableOptions[indexPath.row]
    default:
      guard let destination = segue.destination as? FairplayPlayerViewController else {return}
      destination.option = tableOptions[indexPath.row]
    }
  }
  
  func populateOptions() {
    tableOptions.append(PlayerSelectionOption(title: "Fullscreen Player",
                                              embedCode: "Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1",
                                              pcode: "c0cTkxOqALQviQIGAHWY5hP0q9gU",
                                              domain: "http://www.ooyala.com",
                                              segueName: "fullscreenSegue"))
    tableOptions.append(PlayerSelectionOption(title: "5.1 Audio, Single HLS Rendition",
                                              embedCode: "04bnlxNzE6ZoNIUuEwvnso0Q5u2jOx_M",
                                              pcode: "B3MDExOuTldXc1CiXbzAauYN7Iui",
                                              domain: "http://www.ooyala.com",
                                              segueName: "fullscreenSegue"))
    tableOptions.append(PlayerSelectionOption(title: "5.1 Audio E-AC3",
                                              embedCode: "kyeHR5ODE6FDXOC9eZ5DTKuiJGVo0jnh",
                                              pcode: "B3MDExOuTldXc1CiXbzAauYN7Iui",
                                              domain: "http://www.ooyala.com",
                                              segueName: "fullscreenSegue"))
    //Read the comments in ChildPlayerViewController.swift to know what this example is for
//    tableOptions.append(PlayerSelectionOption(title: "Inline Player",
//                                                   embedCode: "Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1",
//                                                   pcode: "B3MDExOuTldXc1CiXbzAauYN7Iui",
//                                                   domain: "http://www.ooyala.com",
//                                                   segueName: "childSegue"))
    tableOptions.append(PlayerSelectionOption(title: "Player Token (Unconfigured)",
                                              embedCode: "0yMjJ2ZDosUnthiqqIM3c8Eb8Ilx5r52",
                                              pcode: "c0cTkxOqALQviQIGAHWY5hP0q9gU",
                                              domain: "http://www.ooyala.com",
                                              segueName: "playerTokenSegue"))
    tableOptions.append(PlayerSelectionOption(title: "Fairplay Baseline Profile (Unconfigured)",
                                              embedCode: "V3NDdnMzE6tPCchL9wYTFZY8jAE8_Y21",
                                              pcode: "x0b2cyOupu0FFK5hCr4zXg8KKcrm",
                                              domain: "http://www.ooyala.com",
                                              segueName: "fairplaySegue"))
    tableOptions.append(PlayerSelectionOption(title: "Fairplay Main Profile (Unconfigured)",
                                              embedCode: "cycDhnMzE66D5DPpy3oIOzli1HVMoYnJ",
                                              pcode: "x0b2cyOupu0FFK5hCr4zXg8KKcrm",
                                              domain: "http://www.ooyala.com",
                                              segueName: "fairplaySegue"))
    tableOptions.append(PlayerSelectionOption(title: "Fairplay High Profile (Unconfigured)",
                                              embedCode: "d2dzhnMzE6h-LTaIavPD5k2eqLeCTMC5",
                                              pcode: "x0b2cyOupu0FFK5hCr4zXg8KKcrm",
                                              domain: "http://www.ooyala.com",
                                              segueName: "fairplaySegue"))
    tableView.reloadData()
  }
}

