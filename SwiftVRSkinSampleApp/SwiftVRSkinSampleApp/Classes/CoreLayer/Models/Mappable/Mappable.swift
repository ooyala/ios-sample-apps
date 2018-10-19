//
//  Mappable.swift
//  VRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

protocol Mappable {
  static func create<T>(fromJSON json: Any?) -> T?
  static func createCollection<T>(fromJSON json: Any?) -> [T]?
  static func createCollection<T>(fromArrayJSON json: Any?) -> [T]?
}

extension Mappable {
  static func createCollection<T>(fromJSON json: Any?) -> [T]? {
    fatalError("createCollection:fromJSON --> Method not implemented")
  }

  static func createCollection<T>(fromArrayJSON json: Any?) -> [T]? {
    fatalError("createCollection:fromArrayJSON ---> Method not implemented")
  }
}
