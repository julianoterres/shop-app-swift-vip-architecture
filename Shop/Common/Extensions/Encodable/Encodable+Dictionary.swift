//
//  Encodable+Dictionary.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

import Foundation

extension Encodable {
  var asDictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self),
          let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return nil }
    return dictionary
  }
}
