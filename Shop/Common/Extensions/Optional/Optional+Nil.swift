//
//  Optional+Nil.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

extension Optional {
  var isNil: Bool {
    return self == nil
  }

  var isNotNil: Bool {
    return self != nil
  }
}
