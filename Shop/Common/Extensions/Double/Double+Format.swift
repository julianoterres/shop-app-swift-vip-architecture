//
//  Double+Format.swift
//  Shop
//
//  Created by Juliano Terres on 21/11/23.
//

import Foundation

extension Double {
  var fortmatToCurrency: String {
    formatted(.currency(code: "BRL"))
  }
}
