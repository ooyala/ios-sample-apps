//
//  Queue.swift
//  SerializationDownloadsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import Foundation

struct Queue {
  fileprivate var array = [OOAssetDownloadManager]()
  
  var isEmpty: Bool {
    return array.isEmpty
  }
  
  var count: Int {
    return array.count
  }
  
  var front: OOAssetDownloadManager? {
    return array.first
  }
  
  mutating func enqueue(_ element: OOAssetDownloadManager) {
    array.append(element)
  }
  
  mutating func dequeue() -> OOAssetDownloadManager? {
    if isEmpty {
      return nil
    } else {
      return array.removeFirst()
    }
  }
  
  mutating func remove(_ embedCode: String) {
    if let index = array.index(where: { $0.embedCode == embedCode }) {
      array.remove(at: index)
    }
  }
  
  func contains(_ embedCode: String) -> Bool {
    return array.contains(where: { $0.embedCode == embedCode })
  }

  func getOOAssetDownloadManager(_ embedCode: String) -> OOAssetDownloadManager? {
    if let index = array.index(where: { $0.embedCode == embedCode }) {
      return array[index]
    }
    return nil
  }
  
}
