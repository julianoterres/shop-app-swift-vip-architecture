//
//  NetworkEndpoints.swift
//  Shop
//
//  Created by Juliano Terres on 20/11/23.
//

enum NetworkEndpoints: String, Codable {
  // MARK: Public Properties

  var url: String {
    let baseURL = "https://run.mocky.io/v3"
    return "\(baseURL)\(rawValue)"
  }

  // MARK: Products

  case productsList = "/211abc1c-d875-487c-9819-4e4b41905b4a"
}
