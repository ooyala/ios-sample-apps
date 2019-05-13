//
//  OptionDataSource.swift
//  TVOSSwiftSampleApp
//
//  Created on 4/19/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

import Foundation

class OptionDataSource {
  static var options: [PlayerSelectionOption] {
    return [
      PlayerSelectionOption(title: "Fullscreen Player",
                            embedCode: "Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1",
                            pcode: "c0cTkxOqALQviQIGAHWY5hP0q9gU",
                            domain: "http://www.ooyala.com",
                            segueName: "fullscreenSegue"),
      PlayerSelectionOption(title: "5.1 Audio, Single HLS Rendition",
                            embedCode: "04bnlxNzE6ZoNIUuEwvnso0Q5u2jOx_M",
                            pcode: "B3MDExOuTldXc1CiXbzAauYN7Iui",
                            domain: "http://www.ooyala.com",
                            segueName: "fullscreenSegue"),
      PlayerSelectionOption(title: "5.1 Audio E-AC3",
                            embedCode: "kyeHR5ODE6FDXOC9eZ5DTKuiJGVo0jnh",
                            pcode: "B3MDExOuTldXc1CiXbzAauYN7Iui",
                            domain: "http://www.ooyala.com",
                            segueName: "fullscreenSegue"),
      //Read the comments in ChildPlayerViewController.swift to know what this example is for
      //    PlayerSelectionOption(title: "Inline Player",
      //                          embedCode: "Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1",
      //                          pcode: "B3MDExOuTldXc1CiXbzAauYN7Iui",
      //                          domain: "http://www.ooyala.com",
      //                          segueName: "childSegue"),
      PlayerSelectionOption(title: "Player Token (Unconfigured)",
                            embedCode: "0yMjJ2ZDosUnthiqqIM3c8Eb8Ilx5r52",
                            pcode: "c0cTkxOqALQviQIGAHWY5hP0q9gU",
                            domain: "http://www.ooyala.com",
                            segueName: "playerTokenSegue"),
      PlayerSelectionOption(title: "Fairplay Baseline Profile (Unconfigured)",
                            embedCode: "V3NDdnMzE6tPCchL9wYTFZY8jAE8_Y21",
                            pcode: "x0b2cyOupu0FFK5hCr4zXg8KKcrm",
                            domain: "http://www.ooyala.com",
                            segueName: "fairplaySegue"),
      PlayerSelectionOption(title: "Fairplay Main Profile (Unconfigured)",
                            embedCode: "cycDhnMzE66D5DPpy3oIOzli1HVMoYnJ",
                            pcode: "x0b2cyOupu0FFK5hCr4zXg8KKcrm",
                            domain: "http://www.ooyala.com",
                            segueName: "fairplaySegue"),
      PlayerSelectionOption(title: "Fairplay High Profile (Unconfigured)",
                            embedCode: "d2dzhnMzE6h-LTaIavPD5k2eqLeCTMC5",
                            pcode: "x0b2cyOupu0FFK5hCr4zXg8KKcrm",
                            domain: "http://www.ooyala.com",
                            segueName: "fairplaySegue"),
      // if required, add more test cases here
    ]
  }
}
