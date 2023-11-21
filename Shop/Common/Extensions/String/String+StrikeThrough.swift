//
//  String+StrikeThrough.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

import Foundation
import UIKit

extension String {
  var strikeThrough: NSAttributedString {
    let attributeString =  NSMutableAttributedString(string: self)
    
    attributeString.addAttribute(
      NSAttributedString.Key.strikethroughStyle,
      value: NSUnderlineStyle.single.rawValue,
      range:NSMakeRange(0,attributeString.length)
    )
    
    return attributeString
  }
}
