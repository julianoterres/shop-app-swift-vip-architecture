//
//  NetworkEndpoints.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

enum NetworkEndpoints: String, Codable {
  // MARK: Public Properties

  var url: String {
    let baseURL = "http://www.mocky.io/v2"
    return "\(baseURL)\(rawValue)"
  }

  // MARK: Products

  case productsList = "/59b6a65a0f0000e90471257d"
}
