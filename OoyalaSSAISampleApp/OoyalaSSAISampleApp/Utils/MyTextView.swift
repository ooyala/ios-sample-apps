//
//  MyTextView.swift
//  OoyalaSSAISampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

@IBDesignable
class MyTextView: UITextView {
  
  @IBInspectable
  var borderColor: UIColor? = UIColor.clear {
    didSet {
      self.layer.borderColor = borderColor?.cgColor
    }
  }
  
  @IBInspectable
  var borderWidth: CGFloat = 0 {
    didSet {
      self.layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable
  var cornerRadius: CGFloat = 0 {
    didSet {
      self.layer.cornerRadius = cornerRadius
    }
  }
  
}
